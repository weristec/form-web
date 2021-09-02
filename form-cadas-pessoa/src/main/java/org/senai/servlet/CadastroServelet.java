
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

@WebServlet("/cadastro")
public class CadastroServelet extends HttpServlet {

	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Pessoa objP = new Pessoa();
		String acao = req.getParameter("acao");
		
		if (acao != null && acao.equals("apagar")) {
			objP.setId(Integer.parseInt(req.getParameter("id")));
		} else {
			objP.setNomeCompleto(req.getParameter("nome"));
			objP.setTelefone(req.getParameter("tel"));
			objP.setDtNascimento(req.getParameter("nasc"));
			objP.setEmail(req.getParameter("email"));
			objP.setEmail(req.getParameter("estado"));
			objP.setSexo(req.getParameter("sexo"));
			objP.setTecnologia(req.getParameterValues("tecnologia"));
			objP.setEscolaridade(req.getParameter("escolaridade"));
			objP.setId(Integer.parseInt(req.getParameter("id")));
		}

		PessoaDao objDao = new PessoaDao();
		
		boolean validar = false;

		if (objP.getId() > 0) {
			if (acao != null && acao.equals("apagar")) {
				validar = objDao.apagar(objP.getId());
			} else {
				validar = objDao.alterar(objP);
			}
		} else {
			validar = objDao.adicionar(objP);
		}

		if (validar) {
			res.sendRedirect("form-cadastro.jsp");
		} else {
			PrintWriter saida = res.getWriter();
			saida.println("<html>");
			saida.println("Erro ao gravar.");
			saida.println("</html>");
		}


	}

}