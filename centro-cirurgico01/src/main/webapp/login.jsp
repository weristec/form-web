<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Acessar</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container">
<div class="form-row">
	<%@ include file="menu.jsp"%>
		<form action="loginservlet" method="post">
			<img id="img-java" src="img/Bandeira_do_Distrito_Federal_Brasil.png" 
			width=100px; height=100px; style="float:right;"> 
			<label for="login">Login:</label> 
			<input class="larguraTexto" type="text" 
				id="login" name="login" autocomplete="off"
				placeholder="Digite seu login"> 
				
			<label for="senha">Senha:</label>
			<input class="larguraTexto" type="password" name="senha" id="senha"
			placeholder="Digite sua senha"> 
			<input type="submit" class="bt" value="Acessar">
		</form>

		<%
		String erro = request.getParameter("erro");
		if (erro != null) {
		%>

		<script type="text/javascript">
			alert("Login ou senha não encontrado");
		</script>
		<%
		}
		%>
</body>
</html>