<%@page import="org.wdl.model.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<nav class="navbar navbar-expand-lg navbar-light bg-light">
<div class="container-fluid">
<ul class="navbar-nav me-auto mb-2 mb-lg-0">
	<li><a class="nav-link active" aria-current="page" href="index.jsp">Início</a></li>
	<li><a target="_blank" class="nav-link active" aria-current="page" href="painel.jsp">Painel</a></li>
	<li><a class="nav-link active" aria-current="page" href="gerenciar-painel01.jsp">Gerenciar Painel</a></li>

	<%
	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
	boolean verLista = false;
	if (usuario != null) {

		verLista = true;
	%>
	<li><a class="nav-link active" aria-current="page" href="alterarSenha.jsp">Alterar Senha</a></li>
	<li><a class="nav-link active" aria-current="page" href="loginservlet?acao=sair">Logout</a></li>
	<span id="dadosUsuario">Bem vindo <%=usuario.getNome()%>.</span>
	<%
	} else {
	%>
	<li><a class="nav-link active" aria-current="page" href="login.jsp">Acesso</a></li>
	<li><a class="nav-link active" aria-current="page" href="usuarioCadastro.jsp">Cadastro</a></li>
	<%
	}
	%>


</ul>
</div>
</nav>