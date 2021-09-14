<%@page import="java.io.PrintWriter"%>
<%@page import="org.wdl.model.Painel"%>
<%@page import="org.wdl.dao.PainelDao"%>


<%@page import="java.util.List"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% try{
		PainelDao pd01 = new PainelDao();
		List<Painel> ls = pd01.listaPainel();
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
				<%
				for (Painel p1 : ls) {
				%>
				<tr onclick="window.location.href = 'gerenciar-painel.jsp?id=<%=p1.getId()%>'">
				<td><%=p1.getNomePaciente()%></td>
				<td><%=p1.getStatus()%></td>
				<td><%=p1.getInicioPrevisto()%></td>
				<td><%=p1.getInicioCirurgia()%></td>
				<td><%=p1.getFimCirurgia()%></td>
				<td><%=p1.getSaidaPrevista()%></td>
<%-- 		<td><a href="formCadastro.jsp?id=<%=ps.getId()%>">Editar</a> <a --%>
<%-- 			href="cadastroServlet?acao=apagar&id=<%=ps.getId()%>">Apagar</a></td> --%>
	</tr>
				<%
				}
				%>
				
			</thead>
			<tbody id="corpo-tabela" style="cursor: pointer;">

			</tbody>
		</table>
		<%}
		}catch(Exception e){
			e.printStackTrace();
		}%>