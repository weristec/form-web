package org.wdl.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.wdl.dao.PainelDao;
import org.wdl.model.Painel;

import com.google.gson.Gson;

@WebServlet("/painelServlet")
public class PainelServlet extends HttpServlet {
	protected void service(HttpServletRequest req, HttpServletResponse res) 
	throws ServletException, IOException {
		PrintWriter saida = res.getWriter();
		Painel p1 = new Painel();
		Map msg = new HashMap<>();
		//
		/*String act = req.getParameter("act");
		PainelDao p1Dao = new PainelDao();
		
		if (act != null && act.equals("deletar")) {
			p1.setId(Integer.parseInt(req.getParameter("id")));
		}else {
			p1.setNomePaciente(req.getParameter("nome"));
			p1.setStatus(req.getParameter("status"));
			p1.setLocal(req.getParameter("local"));
			p1.setInicioPrevisto(req.getParameter("inicio-previsto"));
			p1.setInicioCirurgia(req.getParameter("inicio-cirurgia"));
			p1.setFimCirurgia(req.getParameter("fim-cirurgia"));
			p1.setSaidaPrevista(req.getParameter("saida-prevista"));
		}
		if(p1.getId()>1) {
			if(act.equals("deletar")) {
				p1Dao.apagar(p1.getId());
			}else if(act.equals("atualizar")) {
				p1Dao.alterar(p1);
			}
		}else {
			p1Dao.adicionar(p1);
			if(p1Dao.adicionar(p1)) {
				res.sendRedirect("gerenciar-painel.jsp");
			}
		}*/
		
		String acao = req.getParameter("acao");

		if (acao != null && acao.equals("apagar")) {
			p1.setId(Integer.parseInt(req.getParameter("id")));
		} else {
			p1.setNomePaciente(req.getParameter("nome"));
			p1.setStatus(req.getParameter("status"));
			p1.setLocal(req.getParameter("local"));
			p1.setInicioPrevisto(req.getParameter("inicio-previsto"));
			p1.setInicioCirurgia(req.getParameter("inicio-cirurgia"));
			p1.setFimCirurgia(req.getParameter("fim-cirurgia"));
			p1.setSaidaPrevista(req.getParameter("saida-prevista"));
			p1.setId(Integer.parseInt(req.getParameter("id")));
		}

		PainelDao objDao = new PainelDao();

		boolean validar = false;
		res.setContentType("application/json");
		res.setCharacterEncoding("UTF-8");

		if (p1.getId() > 0) {
			if (acao != null && acao.equals("apagar")) {
				validar = objDao.apagar(p1.getId());
				msg.put("msg", "Sucesso ao apagar");
			} else {
				validar = objDao.alterar(p1);
				msg.put("msg", "Sucesso ao alterar");
			}
		} else {
				validar = objDao.adicionar(p1);
				msg.put("msg", "Sucesso ao gravar");
			} 

		}

		saida.print(new Gson().toJson(msg));

}
