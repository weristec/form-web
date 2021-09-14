<%@page import="org.senai.model.Painel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style>
ul {
	background-color: #eee;
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
li {
	float: left;
}
li a {
	color: black;
	padding: 16px;
	display: block;
	text-align: center;
	text-decoration: none;
}
li a:hover {
	background-color: #ddd;
}
</style>
<ul>
	<li><a href="index.jsp">Home</a></li>
	<li><a href="form-cadastro.jsp">Cadastro</a></li>
	
	<%
		Painel usuario = (Painel) request.getSession().getAttribute("usuario");
			boolean verLista = false;
			if (usuario != null) {
				verLista = true;
		%>
	<li><a href="login?acao=sair">Logout</a></li>
	<span id="dadosUsuario">Bem vindo:<%=usuario.getNomeCompleto()%></span>
	<li><a href="alterarSenha.jsp">Alterar senha</a></li>
	<%
	} else {
	%>
	<li><a href="login.jsp">Login</a></li>
	<%
	}
	%>
</ul>