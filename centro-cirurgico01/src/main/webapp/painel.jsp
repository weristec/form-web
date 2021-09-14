<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="org.wdl.model.Painel"%>
<%@page import="org.wdl.dao.PainelDao"%>
<html>
<head>
	<meta charset="UTF-8">
<title>Centro Cirúrgico</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<%@ include file="menu.jsp"%>
	<p>
		<img
			src="img/Bandeira_do_Distrito_Federal_Brasil.png"
			height="100px">
		<script>
			//var myVar = setInterval(myTimer, 1000);
			function myTimer() {
				var d = new Date();
				document.getElementById("dt-hora").innerHTML = d.getDate()+'/'+(d.getMonth()+1)+'/'+d.getFullYear()+' '+ d
						.toLocaleTimeString();

				var tabela = localStorage.getItem('corpo-tabela');

				document.getElementById("corpo-tabela").innerHTML = tabela;
			}
			documento.myTimer();
		</script>
		Hospital Regional de Taguatinga|Secretaria de Estado de Saúde do
		Distrito Federal| Pacientes no Centro Cirúgico - <span id="dt-hora"></span>
	</p>
	
	<% 
	PainelDao pDao = new PainelDao();
	List<Painel> ls = pDao.listaPainel();
	if (ls.size() > 0) {
	%>
	<table class="table table-striped">
		<thead>
			<tr>
				<th width="40%">Nome do paciente</th>
				<th width="20%">Status</th>
				<th width="10%">Início Prevísto</th>
				<th width="10%">Início da Cirurgia</th>
				<th width="10%">Fim da Cirurgia</th>
				<th width="10%">Saída Prevista</th>
			</tr>
		</thead>
		<tbody id="corpo-tabela" class="font-weight-bold text-monospace">
			<% for(Painel ps : ls){ %>
					<tr>
						<td><%=ps.getNomePaciente() %></td>
						<td id="st" value="<%=ps.getStatus()%>"><%=ps.getStatus()%></td>
						<td><%=ps.getLocal()%></td>
						<td><%=ps.getInicioPrevisto()%></td>
						<td><%=ps.getInicioCirurgia()%></td>
						<td><%=ps.getFimCirurgia()%></td>
						<td><%=ps.getSaidaPrevista()%></td>			
					</tr>
			<%}%>
		</tbody>
	</table>
<%}%>
<script type="text/javascript">
	function mudaCor() {
		var status = document.getElementeById("st").value;
		switch (status) {
		case 'operatorio':
			document.getElementeById("st").style.background="'#fbd972'";
		case 'sala-cirurgica':
			document.getElementeById("st").style.background='#fd5766';
		case 'recuperacao':
			document.getElementeById("st").style.background='#89e89f';
		case 'transferido':
			document.getElementeById("st").style.background='#b8daff';
	}
}
	mudaCor();
</script>
</body>
</html>
