<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.senai.model.Painel"%>
<%@page import="java.util.List"%>
<%@page import="org.senai.dao.PainelDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="org.senai.db.Conexao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	PainelDao objDao = new PainelDao();
			List<Painel> ls = objDao.listaPessoa();
			if (ls.size() > 0) {
	%>
	<table id="estilo-tb">
		<tr>
			<th>ID</th>
			<th>Nome</th>
			<th>E-mail</th>
			<th>Data Nascimento</th>
<!-- 			<th>Ação</th>  -->
		</tr>

		<%
		String dtN = "";
			for (Painel ps : ls) {
				
			SimpleDateFormat s = new SimpleDateFormat("dd/MM/yyyy");
			dtN = s.format(ps.getDtNascimento().getTime());
		%>
		<tr  onclick="window.location.href = 'form-cadastro.jsp?id=<%=ps.getId()%>'">
			<td><%=ps.getId()%></td>
			<td><%=ps.getNomeCompleto()%></td>
			<td><%=ps.getEmail()%></td>
			<td><%=dtN%></td>
<%-- 			<td><a href="form-cadastro.jsp?id=<%=ps.getId()%>" >Editar</a>  --%>
<%--  			<a href="cadastro?acao=apagar&id=<%=ps.getId()%>" >Apagar</a></td>  --%>
		</tr>
		<%
		}
		%>

	</table>
	<%
	}
	%>
