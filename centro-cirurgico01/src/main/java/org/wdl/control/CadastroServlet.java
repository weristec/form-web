package org.wdl.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.wdl.dao.UsuarioDao;
import org.wdl.model.Usuario;

@WebServlet("/cadastroServlet")
public class CadastroServlet extends HttpServlet {
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		UsuarioDao uDao = new UsuarioDao();
		Usuario u1 = new Usuario();
			

			u1.setNome(req.getParameter("usNome"));
			u1.setEmail(req.getParameter("usEmail"));
			u1.setSenha(req.getParameter("usSenha"));
			
			
			uDao.adicionar(u1);
			res.sendRedirect("usuarioCadastro.jsp");
			
	}
	
}
