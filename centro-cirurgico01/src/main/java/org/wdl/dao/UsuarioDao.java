package org.wdl.dao;

import java.sql.Connection;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.wdl.db.Conexao;
import org.wdl.model.Usuario;

public class UsuarioDao {
	public boolean adicionar(Usuario u1) {
		//Inserir dados
		try {
			Connection cont = Conexao.conectar();
			String sql = "insert into cc_usuario(us_nome, us_email, us_senha) "
					+ "values(?,?,?) ";
			PreparedStatement pst = cont.prepareStatement(sql);		
			pst.setString(1, u1.getNome());
			pst.setString(2, u1.getEmail());
			pst.setString(3, u1.getSenha());
			
			pst.execute();
			pst.close();
			cont.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//Deletar Usuário
	public boolean apagar(int id) {
		try {
			Connection cont = Conexao.conectar();

			String sql = " delete from cc_usuario where  us_id = ?";
			
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
	
	//Selecionar um registro específico
	public Usuario getUsuario(int id) {
		Usuario u1 = new Usuario();
		try {
			Connection cont = Conexao.conectar();
			PreparedStatement pst = cont.prepareStatement("select * from cc_usuario where us_id = ? ");
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				u1.setNome(rs.getString("us_nome"));
				u1.setEmail(rs.getString("us_email"));
				u1.setSenha(rs.getString("us_senha"));
				u1.setId(rs.getInt("us_id"));
				
			}
			cont.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return u1;
	}
	//Acessar area restrita
	public Usuario logar(String login, String senha) {
		Usuario u1 = new Usuario();
		try {
			Connection cont = Conexao.conectar();
			PreparedStatement pst = cont.prepareStatement("select * from cc_usuario WHERE us_email = '"+login+"' AND us_senha = '"+senha+"'");
//			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();
			
			rs.next();
			u1.setId(rs.getInt("us_id"));
			cont.close();
			
			u1 = getUsuario(u1.getId());
			cont.close();
			return u1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return u1;
		
	}
	
	//Alterar senha
		public boolean alterarSenha(Usuario u1) {
			try {
				Connection cont = Conexao.conectar();

				String sql = " update cc_usuario set us_senha = ? where us_id = ? ";
				
				
				PreparedStatement pst = cont.prepareStatement(sql);
				pst.setString(1, u1.getSenha());
				pst.setInt(2, u1.getId());

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

