<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<%@ include file="menu.jsp"%>
<%
	if(usuario == null){
		response.sendRedirect("form-cadastro.jsp");
	}
%>
    <fieldset>
        <legend id="msg" name="msg">Altere sua senha</legend>
        <img id="img-java" src="img/java.png" alt="imagem java">
        <label for="senhaAtual">Senha Atual</label>
        <input class="larguraTexto" type="password" name="senhaAtual" id="senhaAtual">
        <label for="novaSenha">Nova Senha:</label>
        <input class="larguraTexto" type="password" name="novaSenha" id="novaSenha">
        <label for="confSenha">Confirmar Senha:</label>
        <input class="larguraTexto" type="password" name="confirmarSenha" id="confirmarSenha">
        <input type="submit" class="bt" value="Alterar" onclick="alterarSenha()">
        <span style="background-color: blue; color: #fff;" id="msg"></span>
    </fieldset>
    
   <script type="text/javascript">
		
		function alterarSenha(){
			var senhaAtual = document.getElementById("senhaAtual").value;
			var novaSenha = document.getElementById("novaSenha").value;
			var confirmarSenha = document.getElementById("confirmarSenha").value;
			
			var parametros = "senhaAtual="+senhaAtual;
			 parametros += "&novaSenha="+novaSenha;
			 parametros += "&confirmarSenha="+confirmarSenha;
			 acessarApi(parametros);
		}
		
		function acessarApi(parametros){
			const api = new XMLHttpRequest();
			api.open("POST","http://localhost:8080/form-cadas-pessoa/alterarSenha");
			api.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			api.send(parametros);
			api.onload = function() {
				document.getElementById("msg").innerHTML = this.responseText;
			}
		}
		
	</script>
    
</body>
</html>