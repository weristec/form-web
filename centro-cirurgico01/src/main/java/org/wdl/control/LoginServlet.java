package org.wdl.control;
import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.wdl.dao.UsuarioDao;
import org.wdl.model.Usuario;

@WebServlet("/loginservlet")
public class LoginServlet extends HttpServlet {

	protected void service(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		String acao = req.getParameter("acao");

		if (acao != null && acao.equals("sair")) {
			req.getSession().removeAttribute("usuario");
			res.sendRedirect("login.jsp");
		} else {
			String login = req.getParameter("login");
			String senha = req.getParameter("senha");

			UsuarioDao dao = new UsuarioDao();
			Usuario p = dao.logar(login, senha);

			if (p.getId() > 0) {
				res.sendRedirect("gerenciar-painel01.jsp");
				req.getSession().setAttribute("usuario", p);
			} else {
				res.sendRedirect("login.jsp?erro");
			}
		}

	}
}
