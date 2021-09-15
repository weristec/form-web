<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>Cadastrar Usuário</title>
</head>
<body>
<%@ include file="menu.jsp"%>
<div class="container">
<form action="cadastroServlet" method="post">
<div class="input-group mb-3">
  <span class="input-group-text" id="basic-addon1">@</span>
  <input id="usNome" name="usNome" type="text" class="form-control" placeholder="Nome" 
  	aria-label="Username" aria-describedby="basic-addon1">
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="basic-addon1">@</span>
  <input id="usEmail" name="usEmail" type="text" class="form-control" placeholder="Email" aria-label="Username" aria-describedby="basic-addon1">
</div>

<div class="input-group mb-3">
  <span class="input-group-text" id="basic-addon1">@</span>
  <input id="usSenha" name="usSenha" type="text" class="form-control" 
  placeholder="Senha" aria-label="Username" aria-describedby="basic-addon1">
</div>
<input type="submit" value="Cadastrar">
</form>
</div>
</body>
</html>