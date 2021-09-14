package org.wdl.control;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.wdl.dao.PainelDao;
import org.wdl.model.Painel;



@WebServlet("/painelServlet")
public class PainelServlet extends HttpServlet {
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			PainelDao pDao = new PainelDao();
			Painel p1 = new Painel();
		
			int id = 0;
			if (req.getParameter("id") != null && req.getParameter("id") != "") {
				id = Integer.parseInt(req.getParameter("id"));
			}
			String acao = req.getParameter("acao");
		
			if (acao != null && acao.equals("apagar")) {
				pDao.apagar(id);
			} else if(id > 0) {
				
				p1.setId(id);
				p1.setNomePaciente(req.getParameter("nome"));
				p1.setStatus(req.getParameter("status"));
				p1.setLocal(req.getParameter("local"));
				p1.setInicioPrevisto(req.getParameter("inicio-previsto"));
				p1.setInicioCirurgia(req.getParameter("inicio-cirurgia"));
				p1.setFimCirurgia(req.getParameter("fim-cirurgia"));
				p1.setSaidaPrevista(req.getParameter("saida-previsto"));
				
				pDao.alterar(p1);
				
			} else {
				p1.setNomePaciente(req.getParameter("nome"));
				p1.setStatus(req.getParameter("status"));
				p1.setLocal(req.getParameter("local"));
				p1.setInicioPrevisto(req.getParameter("inicio-previsto"));
				p1.setInicioCirurgia(req.getParameter("inicio-cirurgia"));
				p1.setFimCirurgia(req.getParameter("fim-cirurgia"));
				p1.setSaidaPrevista(req.getParameter("saida-previsto"));
				
				pDao.adicionar(p1);
			}
			res.sendRedirect("gerenciar-painel01.jsp");
			System.out.println("Gravado!");
		}
		

	}

