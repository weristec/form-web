
<%@page import="org.wdl.model.Painel"%>
<%@page import="org.wdl.dao.PainelDao"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Gerenciar Painel Pacientes</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<%
Painel pn2 = new Painel();
PainelDao pd1 = new PainelDao();

int id = Integer.parseInt(request.getParameter("id"));
pn2 = pd1.getPessoa(id);
%>
	<script>
		var pacientes = localStorage.getItem('ls-tabela');
		
		if(pacientes == null){
			pacientes = [];
		}else{
			pacientes = JSON.parse(pacientes);
		}

		function gravar(){
			var vId = document.getElementById("id").value;
			var vNome = document.getElementById("nome").value.toUpperCase();	
			if (vNome == '') {
				alert('O Nome do Paciente é obrigatório.');
				return false;
			}

			var vStatus = document.getElementById("status").value;
			var vLocal = document.getElementById("local").value;
			var vIniPrevisto = document.getElementById("inicio-previsto").value;
			var vIniCirurgia = document.getElementById("inicio-cirurgia").value;
			var vFimCirurgia = document.getElementById("fim-cirurgia").value;
			var vSaidaPrev = document.getElementById("saida-prevista").value;

			if (vLocal != '') {
				vLocal = '(' + vLocal + ')';
			}

			var save = confirm("Deseja Salvar as alterações?");
			if (save) {

				var paciente = {
					nome : vNome,
					status : vStatus,
					local : vLocal,
					iniPrevisto : vIniPrevisto,
					iniCirurgia : vIniCirurgia,
					fimCirurgia : vFimCirurgia,
					saidaPrev : vSaidaPrev,
				};

				if (vId == '') {
					paciente.splice(pacientes.length, 0, paciente);
				} else {
					paciente[vId] = paciente;
				}
				acessarApiServlet(paciente);
				atualizarTabela();
				limpaForm();
				
			}
		}

		function preparaEdicao(id) {
			var p = pacientes[id];
			document.getElementById("id").value = id;
			document.getElementById("nome").value = p.nome;
			document.getElementById("status").value = p.status;
			document.getElementById("local").value = p.local.replace("(","").replace(")","");
			document.getElementById("inicio-previsto").value = p.iniPrevisto;
			document.getElementById("inicio-cirurgia").value = p.iniCirurgia;
			document.getElementById("fim-cirurgia").value = p.fimCirurgia;
			document.getElementById("saida-prevista").value = p.saidaPrev;

		}

		function status(status) {
			switch (status) {
			case 'operatorio':
				return {
					label : 'Pré-Operatório',
					cor : '#fbd972'
				};
			case 'sala-cirurgica':
				return {
					label : 'Em sala cirúrgica',
					cor : '#fd5766'
				};
			case 'recuperacao':
				return {
					label : 'Em recuperação',
					cor : '#89e89f'
				};
			case 'transferido':
				return {
					label : 'Transferído',
					cor : '#b8daff'
				};
			}
		}

		function atualizarTabela() {
			var tabela = "";

			for (i in pacientes) {
				var stts = status(pacientes[i].status);
				tabela += '<tr onclick="preparaEdicao(' + i + ')">' + '<td>'
						+ pacientes[i].nome + '</td>'
						+ '<td style="background-color: '+stts.cor+';">'
						+ stts.label + pacientes[i].local + '</td>' + '<td>'
						+ pacientes[i].iniPrevisto + '</td>' + '<td>'
						+ pacientes[i].iniCirurgia + '</td>' + '<td>'
						+ pacientes[i].fimCirurgia + '</td>' + '<td>'
						+ pacientes[i].saidaPrev + '</td>' + '</tr>';
			}

			document.getElementById("corpo-tabela").innerHTML = tabela;
			localStorage.setItem('corpo-tabela', tabela);
			localStorage.setItem('ls-tabela', JSON.stringify(pacientes));
		}

		function limpaForm() {
			document.getElementById("id").value = '';
			document.getElementById('form-paciente').reset();
		}

		function apagar() {
			var vId = document.getElementById("id").value;
			if (vId != '') {
				var save = confirm("Tem certeza que quer apagar esse registro?");
				if (save) {
					
					acessarApiServlet("id="+id+"&acao=apagar");
					pacientes.splice(vId, 1);
					atualizarTabela();
					limpaForm();
				}
			}
		}
	</script>

	<div class="container">
		<br>
		<h2>Gerenciar Painel dos Pacientes no Centro Cirúrgico</h2>
		
		<form name="form-paciente" id="form-paciente" action="painelServlet">
			<input type="hidden" id="id" name="id" value="<%=pn2.getId()%>">
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="nome">Nome Paciente:</label> 
					<input type="text" class="form-control" id="nome" 
						placeholder="Nome do Paciente" name="nome" value="<%=pn2.getNomePaciente()%>">
				</div>
				<div class="form-group col-md-3">
					<label for="nome">Status:</label> <select name="status" id="status"
						class="form-control">
						<option value="operatorio">Pré-Operatório</option>
						<option value="sala-cirurgica">Em sala cirúrgica</option>
						<option value="recuperacao">Em recuperação</option>
						<option value="transferido">Transferído</option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label for="local">Local:</label> <input type="text"
						class="form-control" id="local" placeholder="Sala/Quarto"
						name="local" value="<%=pn2.getLocal()%>">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group  col-md-3">
					<label for="inicio-previsto">Início Prevísto:</label> <input
						type="time" class="form-control" id="inicio-previsto"
						name="inicio-previsto" size="20" value="<%=pn2.getInicioPrevisto()%>">
				</div>
				<div class="form-group  col-md-3">
					<label for="inicio-cirurgia">Início Cirurgia:</label> <input
						type="time" class="form-control" id="inicio-cirurgia"
						name="inicio-cirurgia" size="20" value="<%=pn2.getInicioCirurgia()%>">
				</div>
				<div class="form-group  col-md-3">
					<label for="fim-cirurgia">Fim daCirurgia:</label> <input
						type="time" class="form-control" id="fim-cirurgia"
						name="fim-cirurgia" size="20" value="<%=pn2.getFimCirurgia()%>">
				</div>
				<div class="form-group  col-md-3">
					<label for="saida-prevista">Saída Prevista:</label> <input
						type="time" class="form-control" id="saida-prevista"
						name="saida-prevista" size="20" value="<%=pn2.getSaidaPrevista()%>">
				</div>
			</div>
			
			<div class="form-row">
			<div class="form-group col-md-3">
					<label for="act">Ação:</label> <select name="act" id="act"
						class="form-control">
						<option value="cadastrar">cadastrar</option>
						<option value="deletar">deletar</option>
						<option value="atualizar">atualizar</option>
					</select>
			</div>
			</div>
			
			<input type="submit" value="enviar" class="btn btn-secondary">
			
			<%if(pn2.getId() > 0){%>
			<button type="button" class="btn btn-danger" onclick="apagar()">Apagar</button>
			<%}else{%>
			<button type="button" class="btn btn-secondary" onclick="limpaForm()">Novo</button>
			<%}%>
			<button type="button" class="btn btn-primary" onclick="gravar(this)">Gravar</button>
		</form>

		<br>
		<%try{
				List<Painel> ls = pd1.listaPainel();
				if(ls.size() > 0){
		%>
		<table class="table table-hover">
			<thead>
				<tr>
					<th width="40%">Nome do Paciente</th>
					<th width="30%">Status</th>
					<th width="10%">Início Prevísto</th>
					<th width="10%">Início da Cirurgia</th>
					<th width="10%">Fim da Cirurgia</th>
					<th width="10%">Saída Prevista</th>
				</tr>
			</thead>
	
				<%for(Painel pn1 : ls){ %>
				<tr onclick="window.location.href = 'gerenciar-painel.jsp?id=<%=pn1.getId()%>'">
				<td><%=pn1.getNomePaciente()%></td>
				<td><%=pn1.getStatus()%></td>
				<td><%=pn1.getInicioPrevisto()%></td>
				<td><%=pn1.getInicioCirurgia()%></td>
				<td><%=pn1.getFimCirurgia()%></td>
				<td><%=pn1.getSaidaPrevista()%></td>
				<!--  <td><a href="gerenciar-painel.jsp?id=<%=pn1.getId()%>">Editar</a></td>-->
				</tr>
				<%}%>
				
			<tbody id="corpo-tabela" style="cursor: pointer;">

			</tbody>
		</table>
		<%}
		}catch(Exception e){
			e.printStackTrace();
		}%>
		<script type="text/javascript">
			var tabela = localStorage.getItem('corpo-tabela');
			document.getElementById("corpo-tabela").innerHTML = tabela;
		</script>

		<script type="text/javascript">
			var tabela = localStorage.getItem('corpo-tabela');
			document.getElementById("corpo-tabela").innerHTML = tabela;
			
			function acessarApiServlet(parametros) {
				const api = new XMLHttpRequest();
				// ?orderBy=nome
				api.open("GET","painelServlet?"+parametros);
				api.send();
				api.onload = function() {
					var dados = this.responseText;
					dados = JSON.parse(dados);
					document.querySelector("#msg").innerHTML = dados.msg;
				}
			}
			
			
		</script>

	</div>
</div>
</body>
</html>

