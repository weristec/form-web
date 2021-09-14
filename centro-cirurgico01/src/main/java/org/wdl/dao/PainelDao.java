package org.wdl.dao;

import java.sql.PreparedStatement;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.wdl.db.Conexao;
import org.wdl.model.Painel;

import java.sql.Connection;
import java.sql.Date;


public class PainelDao {
	public boolean adicionar(Painel p1) {
		
		try {
			Connection cont = Conexao.conectar();

			String sql = "insert into cc_painel "
					+ "(pa_nm_paciente, pa_status, pa_local, pa_in_previsto, "
					+ "pa_in_cirurgia, pa_fi_cirurgia, pa_sa_prevista) "
					+ "values(?,?,?,?,?,?,?)";
			PreparedStatement pst = cont.prepareStatement(sql);		
			pst.setString(1, p1.getNomePaciente());
			pst.setString(2, p1.getStatus());
			pst.setString(3, p1.getLocal());
			pst.setString(4, p1.getInicioPrevisto());
			pst.setString(5, p1.getInicioCirurgia());
			pst.setString(6, p1.getFimCirurgia());
			pst.setString(7, p1.getSaidaPrevista());
			
			pst.execute();
			pst.close();
			cont.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Painel> listaPainel(){
		List<Painel> ls = new ArrayList<>();
		try {
			Connection cont = Conexao.conectar();
			PreparedStatement pst = cont.prepareStatement("select * from cc_painel;");
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Painel pn1 = new Painel();
				pn1.setNomePaciente(rs.getString("pa_nm_paciente"));
				//pa_nm_paciente, pa_status, pa_local, pa_in_previsto, pa_in_cirurgia, pa_fi_cirurgia,
				//pa_sa_prevista
				pn1.setStatus(rs.getString("pa_status"));
				pn1.setLocal(rs.getString("pa_local"));
				pn1.setInicioPrevisto(rs.getString("pa_in_previsto"));
				pn1.setInicioCirurgia(rs.getString("pa_in_cirurgia"));
				pn1.setFimCirurgia(rs.getString("pa_fi_cirurgia"));
				pn1.setSaidaPrevista(rs.getString("pa_sa_prevista"));
				pn1.setId(rs.getInt("pa_id"));
				
				ls.add(pn1);
				System.out.println(pn1.getNomePaciente());

			}
			cont.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ls;
	}
	
	public Painel getPessoa(int id) {
		Painel p = new Painel();
		try {
			Connection cont = Conexao.conectar();
			PreparedStatement pst = cont.prepareStatement("select * from cc_painel where pa_id = ? ");
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				p.setNomePaciente(rs.getString("pa_nm_paciente"));
				p.setStatus(rs.getString("pa_status"));
				p.setLocal(rs.getString("pa_local"));
				p.setInicioPrevisto(rs.getString("pa_in_previsto"));
				p.setInicioCirurgia(rs.getString("pa_in_cirurgia"));
				p.setFimCirurgia(rs.getString("pa_fi_cirurgia"));
				p.setSaidaPrevista(rs.getString("pa_sa_prevista"));
				
				p.setId(rs.getInt("pa_id"));
			}
			cont.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return p;
	}
	
	public boolean alterar(Painel p1) {
		try {
			Connection cont = Conexao.conectar();

			String sql = " update cc_painel set "
					+ "pa_nm_paciente = ?,"
					+ "pa_status = ?,"
					+ "pa_local = ?,"
					+ "pa_in_previsto = ?,"
					+ "pa_in_cirurgia = ?,"
					+ "pa_fi_cirurgia = ?,"
					+ "pa_sa_prevista = ?,"
					+ "where "
					+ "pa_id = ?";
			
			PreparedStatement pst = cont.prepareStatement(sql);
			pst.setString(1, p1.getNomePaciente());
			pst.setString(2, p1.getStatus());
			pst.setString(3, p1.getLocal());
			pst.setString(4, p1.getInicioPrevisto());
			pst.setString(5, p1.getInicioCirurgia());
			pst.setString(6, p1.getFimCirurgia());
			pst.setString(7, p1.getSaidaPrevista());
			pst.setInt(8, p1.getId());

			pst.execute();
			pst.close();
			cont.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean apagar(int id) {
		try {
			Connection cont = Conexao.conectar();

			String sql = " delete from cc_painel where  pa_id = ?";
			
			PreparedStatement pst = cont.prepareStatement(sql);  
			pst.setInt(1, id);

			pst.execute();
			pst.close();
			cont.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
