package org.wdl.db;
import java.sql.Connection;

import java.sql.DriverManager;

public class Conexao {
	public static Connection conectar() {
		try {
			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://chunee.db.elephantsql.com:5432/wbuhhaks";
			String usuarioDb = "wbuhhaks";
			String senhaDb = "a0p5pPiSOLKrxzPs0yj5BggNfrSUGfQJ";
			return DriverManager.getConnection(url, usuarioDb, senhaDb);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("Erro de conex�o");
			e.printStackTrace();
			return null;
			
		}
		
	}
}
