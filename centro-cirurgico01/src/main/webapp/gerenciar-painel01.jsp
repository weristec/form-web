
<%@page import="org.wdl.model.Painel"%>
<%@page import="org.wdl.dao.PainelDao"%>
<%@page import="java.util.List"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>

<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<title>Gerenciar Painel</title>
<meta charset="utf-8">
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<%@ include file="menu.jsp"%>
<script>
		var pacientes = localStorage.getItem('ls-tabela');
		
		if(pacientes == null){
			pacientes = [];
		}else{
			pacientes = JSON.parse(pacientes);
		}

		function gravar(event) {
			event.preventDefault();
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
			

// 			if (vLocal != '') {
// 				vLocal = '(' + vLocal + ')';
// 			}

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
					pacientes.splice(pacientes.length, 0, paciente);
				} else {
					pacientes[vId] = paciente;
				}
 				//atualizarTabela();
				
				document.getElementById('form-paciente').submit();
				
				//limpaForm();
				
			}
			
			return paciente;
						
		}
	 	
	
		function preparaEdicao(id, nome, status, local, iniPre, iniCir, fimCir, saida) {
// 			var p = pacientes[id]
			document.getElementById("id").value = id;
			document.getElementById("nome").value = nome;
			document.getElementById("status").value = status;
			document.getElementById("local").value = local.replace("(","").replace(")","");
			document.getElementById("inicio-previsto").value = iniPre;
			document.getElementById("inicio-cirurgia").value = iniCir;
			document.getElementById("fim-cirurgia").value = fimCir;
			document.getElementById("saida-prevista").value = saida;

		}


		/*function atualizarTabela() {
		var tabela = ""; 
 			for (i in pacientes) {
 				var stts = status(pacientes[i].status);
 				tabela += '<tr onclick="preparaEdicao(' + i + ')">' 
 							+ '<td>'+ pacientes[i].nome + '</td>'
 							+ '<td style="background-color: '+stts.cor+';">'+ stts.label + pacientes[i].local + '</td>'
 							+ '<td>'+ pacientes[i].iniPrevisto + '</td>' 
 							+ '<td>'+ pacientes[i].iniCirurgia + '</td>'
 							+ '<td>'+ pacientes[i].fimCirurgia + '</td>' 
 							+ '<td>'+ pacientes[i].saidaPrev + '</td>' 
 						+ '</tr>';
 			}		
 			document.getElementById("corpo-tabela").innerHTML = tabela;
 			localStorage.setItem('corpo-tabela', tabela);
 			localStorage.setItem('ls-tabela', JSON.stringify(pacientes));
		}*/

		function limpaForm() {
			document.getElementById("id").value = '';
			document.getElementById('form-paciente').reset();
		}

		function apagar() {
			var vId = document.getElementById("id").value;
			if (vId != '') {
				"asd"+vId
				var save = confirm("Tem certeza que quer apagar esse registro?");
				if (save) {
					window.location = "painelServlet?id="+vId+"&acao=apagar";
// 					pacientes.splice(vId, 1);
// 					atualizarTabela();
// 					limpaForm();
				}
			}
		}
	</script>
	
	<div class="container">
		<br>
		<h2>Gerenciar Painel dos Paciente no Centro Cirúrgico</h2>
		<form method="get" action="painelServlet" name="form-paciente" id="form-paciente">
			<input type="hidden" id="id" name="id">
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="nome">Nome Paciente:</label>
					 <input type="text"class="form-control" id="nome" placeholder="Nome do Paciente" name="nome">
				</div>
				<div class="form-group col-md-3">
					<label for="nome">Status:</label>
					 <select name="status" id="status" class="form-control">
						<option value="operatorio">Pré-Operatório</option>
						<option value="sala-cirurgica">Em sala cirúrgica</option>
						<option value="recuperacao">Em recuperação</option>
						<option value="transferido">Transferido</option>
					</select>
					
				</div>
				<div class="form-group col-md-3">
					<label for="local">Local:</label>
					 <input type="text"	class="form-control" id="local" placeholder="Sala/Quarto"name="local">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group  col-md-3">
					<label for="inicio-previsto">Início Previsto:</label>
					 <input	type="time" class="form-control" id="inicio-previsto"name="inicio-previsto" size="20">
				</div>
				<div class="form-group  col-md-3">
					<label for="inicio-previsto">Início Cirurgia:</label>
					 <input	type="time" class="form-control" id="inicio-cirurgia"name="inicio-cirurgia" size="20">
				</div>
				<div class="form-group  col-md-3">
					<label for="inicio-previsto">Fim daCirurgia:</label>
					 <input type="time" class="form-control" id="fim-cirurgia" 	name="fim-cirurgia" size="20">
				</div>
				<div class="form-group  col-md-3">
					<label for="inicio-previsto">Saída Prevista:</label>
					 <input type="time" class="form-control" id="saida-prevista"name="saida-prevista" size="20">
				</div>
			</div>
			<button type="button" class="btn btn-secondary" onclick="limpaForm()">Novo</button>
			<button type="submit" class="btn btn-primary" onclick="gravar(event)">Gravar</button>
			<button type="button" class="btn btn-danger" onclick="apagar()">Apagar</button>
<!-- 				<a class="btn btn-danger" onclick="apagar()" href="">Apagar</a> -->
		</form>

		<br>
		<table class="table table-hover">
			<thead>
				<tr>
					<th width="40%">Nome do Paciente</th>
					<th width="30%">Status</th>
					<th width="10%">Local</th>
					<th width="10%">Início Previsto</th>
					<th width="10%">Início da Cirurgia</th>
					<th width="10%">Fim da Cirurgia</th>
					<th width="10%">Saída Prevista</th>
				</tr>
			</thead>
			<tbody id="corpo-tabela" style="cursor: pointer;">
			<%			
				PainelDao objDao = new PainelDao();
				List<Painel> ls = objDao.listaPainel();
				if (ls.size() > 0) {
					for(Painel p1 : ls){	
			%>		
					<tr onclick='preparaEdicao(<%=p1.getId() %>, "<%=p1.getNomePaciente() %>", "<%=p1.getStatus() %>", "<%=p1.getLocal() %>", "<%=p1.getInicioPrevisto()%>", "<%=p1.getInicioCirurgia()%>", "<%=p1.getFimCirurgia()%>", "<%=p1.getSaidaPrevista()%>")'>
						<td><%=p1.getNomePaciente() %></td>
						<td style="background-color: <%=p1.mudaCor()%>"><%=p1.getStatus()%></td>
						<td><%=p1.getLocal()%></td>
						<td><%=p1.getInicioPrevisto()%></td>
						<td><%=p1.getInicioCirurgia()%></td>
						<td><%=p1.getFimCirurgia()%></td>
						<td><%=p1.getSaidaPrevista()%></td>			
					</tr>
			<%
					}
				
				}
			%>
			

			</tbody>
		</table>

		<script type="text/javascript">
// 			var tabela = localStorage.getItem('corpo-tabela');
// 			document.getElementById("corpo-tabela").innerHTML = tabela;

		</script>

	</div>
</body>
</html>