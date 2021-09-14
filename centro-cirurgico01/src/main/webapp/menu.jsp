<%@page import="org.wdl.model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<nav class="navbar navbar-expand-lg navbar-light bg-info">
<ul>
	<li><a href="painel.jsp">Home</a></li>
	<li><a href="gerenciar-painel.jsp">Cadastro</a></li>

	<%
	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
	boolean verLista = false;
	if (usuario != null) {

		verLista = true;
	%>
	<li><a class="navbar-brand h1 mb-0" href="alterarSenha.jsp">Alterar Senha</a></li>
	<li><a class="navbar-brand h1 mb-0" href="loginservlet?acao=sair">Logout</a></li>
	<span id="dadosUsuario">Bem vindo:<%=usuario.getEmail()%></span>
	<%
	} else {
	%>
	<li><a class="navbar-brand h1 mb-0" href="login.jsp">Login</a></li>
	<%
	}
	%>


</ul>
</nav>