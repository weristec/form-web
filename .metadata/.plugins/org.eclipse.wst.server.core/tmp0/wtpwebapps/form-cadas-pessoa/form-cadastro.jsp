<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.senai.dao.PainelDao"%>
<%@page import="org.senai.model.Painel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/estilo.css">

    <style>
        .bloco-inline label,
        .bloco-inline input,
        .bloco-inline * {
            display: inline;
        }
    </style>
</head>
<body>
	<%@include file="menu.jsp"%>
	<%
	Painel p = new Painel();
			String dt = "";
			try {
		int id = Integer.parseInt(request.getParameter("id"));
		PainelDao dao = new PainelDao();
		p = dao.getPessoa(id);
		
		if(p.getDtNascimento() != null){
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
			dt = s.format(p.getDtNascimento().getTime());
		}
			} catch (Exception e) {
			}
			//out.print(id);
	%>
	
    <form action="cadastroServlet">
    <div id="msg" style="text-align: center; padding-top: 10px;" ></div>
    <input type="hidden" name="id" id="id" value="<%=p.getId()%>">
        <fieldset>
        
        <!-- ENTRADA DE DADOS PARA CadastroServlet-->
            <legend>CADASTRO</legend>
            <img id="img-java" src="img/java.png" alt="imagem java">
            <label for="nome">Nome Completo:</label>
            <input class="larguraTexto" type="text" id="nome" name="nome"
                placeholder="Digite seu nome completo" value="<%=p.getNomeCompleto()%>">
                
            <label for="telefone">Telefone:</label>
            <input class="larguraTexto" type="text" placeholder="(61)9.9999-9999"
            	 id="tel" name="tel" required="required" value="<%=p.getTelefone()%>">
            	 
            <label for="nasc">Data de Nascimento:</label>
            <input class="larguraTexto" type="date" 
            	 id="nasc" name="nasc" required="required" value="<%=dt%>"> 
            
            <label for="email">E-mail:</label>
            <input class="larguraTexto" type="email" id="email"
            	name="email" value="<%=p.getEmail()%>">
            
            <label
				for="uf">Estado:
			</label>	
            <select id="uf" name="uf">
				<option>Selecione</option>
			</select>
            
            <label for="sexo">Sexo:</label>
            <div class="bloco-inline">
                <input type="radio" id="masc" name="sexo" value="m"> <label for="masc"> Masculino</label>
                <input type="radio" id="fem" name="sexo" value="f"> <label for="fem"> Feminino</label>
            </div>
            
            <label for="">Tecnologias:</label>
            <div class="bloco-inline">
                <input type="checkbox" id="html" name="tecnologia" value="html"> <label for="html"> HTML</label>
                <input type="checkbox" id="css" name="tecnologia" value="css"><label for="css"> CSS</label>
                <input type="checkbox" id="java" name="tecnologia" value="java"><label for="java"> Java</label>
                <input type="checkbox" id="php" name="tecnologia" value="php"><label for="php"> PHP</label>
            </div>
            
            <label for="">Escolaridade:</label>
            <select name="escolaridade" id="escolaridade">
                <option value="">Selecione</option>
                <option value="Fundamental">Fundamental</option>
                <option value="Ensino Médio">Ensino Médio</option>
                <option value="Superior">Superior</option>
            </select> 
        
          <!-- Botões -->  
            <a class="bt" href="form-cadastro.jsp">Novo Cadastro</a>
           
            <%
                       if (p.getId() > 0) {
                       %>
			<input type="button" "bt" value="Apagar" onclick="apagar(<%=p.getId()%>)">
			<%
			} else {
			%>
			<input type="reset" class="bt" value="Limpar">
			<%
			}
			%>
            <input type="button" class="bt" value="Gravar" onclick="enviarDados()">
        </fieldset>
        
    </form>
    
    <!-- Scripts -->
    <script type="text/javascript">
		var lsSexo = document.getElementsByName("sexo");
		for (i in lsSexo) {
			if (lsSexo[i].value == '<%=p.getSexo()%>') {
				lsSexo[i].setAttribute('checked', 'checked');
			}
		}
		
		document.getElementById("escolaridade").value = '<%=p.getEscolaridade()%>';
	<%for (String t : p.getTecnologia()) {
		if (!t.equals("")) {
			out.println("document.getElementById('" + t + "').setAttribute('checked', 'checked')");
		}
	}%>
	
	function acessarApi() {
		const api = new XMLHttpRequest();
		
		api.open("GET","https://servicodados.ibge.gov.br/api/v1/localidades/estados");
		api.send();
		api.onload = function() {
			var dados = this.responseText;
			dados = JSON.parse(dados);
			
			
			dados.sort(function(a,b){
				return a.nome < b.nome ? -1 : a.nome > b.nome ? 1 : 0;
			});
			var lsEstados = "<option value=''>Selecione</option>";
			
			for(i in dados){
				var uf = dados[i].sigla;
				var nome = dados[i].nome;
				lsEstados += "<option value='"+uf+"'>"+nome+"</option>";
			}
		
			var estado = document.getElementById("uf");
			estado.innerHTML = lsEstados;
			if('<%=p.getEstado()%>' != 'null')
			document.getElementById("uf").value = '<%=p.getEstado()%>';
		}
	}
	acessarApi();
	
	function enviarDados(){
		var id	= document.querySelector("#id").value;
		var nomecompleto = document.querySelector("#nome").value;
		var telefone = document.querySelector("#tel").value;
		var dtNascimento = document.querySelector("#nasc").value;
		var email = document.querySelector("#email").value;
		var sexo = document.querySelector("[name='sexo']").value;
		var escolaridade = document.querySelector("#escolaridade").value;
		
		var lst = document.querySelectorAll('[name="tecnologia"]:checked');
		var tecnologia = "";
		for(let i = 0; i < lst.length; i++){
			tecnologia += lst[i].value+",";
		}
		
		var out = "id=$id&nome=$nome&tel=$tel&nasc=$nasc&email=$email&sexo=$sexo&escolaridade=$escolaridade&tecnologia=$tecnologia";
		out = out.replace("$id",id);
		out = out.replace("$nome",nomecompleto);
		out = out.replace("$tel",telefone);
		out = out.replace("$nasc",dtNascimento);
		out = out.replace("$email",email);
		out = out.replace("$sexo",sexo);
		out = out.replace("$escolaridade",escolaridade);
		out = out.replace("$tecnologia",tecnologia);
		acessarApiServlet(out);
		
		
	}
	
	function apagar(id){
		if(confirm('Você realmente quer apagar esse registro?')){
			acessarApiServlet("id="+id+"&acao=apagar");
		}
	}
	
	function acessarApiServlet(parametros) {
		const api = new XMLHttpRequest();
		// ?orderBy=nome
		api.open("GET","cadastroServlet?"+parametros);
		api.send();
		api.onload = function() {
			var dados = this.responseText;
			dados = JSON.parse(dados);
			document.querySelector("#msg").innerHTML = dados.msg;
		}
	}
		
	</script>
	<%
	if (verLista) {
	%>
	<div id="tb">
		<%@include file="listaPessoas.jsp" %>	
	</div>
	<%
	}
	%>
</body>
</html>