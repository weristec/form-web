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
    <fieldset>
    <form action="login" method="post">
        <legend>ACESSAR</legend>
        <img id="img-java" src="img/java.png" alt="imagem java">
        <label for="login">Login:</label>
        <input class="larguraTexto" type="text" name="login" id="login" placeholder="Digite seu login" autocomplete="off">
        <label for="senha">Senha:</label>
        <input class="larguraTexto" type="password" name="senha" id="senha" placeholder="Digite sua senha">
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
    </fieldset>
    
</body>
</html>