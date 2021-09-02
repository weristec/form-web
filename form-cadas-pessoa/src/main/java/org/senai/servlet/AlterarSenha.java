package org.senai.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.senai.dao.PessoaDao;
import org.senai.model.Pessoa;

@WebServlet("/alterarSenha")
public class AlterarSenha extends HttpServlet {
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String senhaAtual = req.getParameter("senhaAtual");
		String novaSenha = req.getParameter("novaSenha");
		String confirmarSenha = req.getParameter("confirmarSenha");
		
		Pessoa p = (Pessoa) req.getSession().getAttribute("usuario");
		res.setCharacterEncoding("UTF-8");	
		PrintWriter out = res.getWriter();
		if(novaSenha.equals(confirmarSenha) && p.getSenha().equals(senhaAtual) ) {
			//chamar um metodo para aterar a senha 
			p.setSenha(novaSenha);
			PessoaDao dao = new PessoaDao();
			dao.alterarSenha(p);
			
			out.print("Ok para alterar a senha.");
		}else {
			
			out.print("Não foi possível aterar a senha");
		}
		
		
	}
}
