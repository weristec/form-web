import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.jdi.connect.spi.Connection;
import java.sql.Connection;
@WebServlet("/cadastro")
public class CadastroServelet extends HttpServlet{
	
	protected void service(HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException{
		
		String nome = req.getParameter("nome");
		String tel = req.getParameter("tel");
		String nasc = req.getParameter("nasc");
		
		String email = req.getParameter("email");
		String sexo = req.getParameter("sexo");
		String[] tecnologia = req.getParameterValues("tecnologia");
		String escolaridade = req.getParameter("escolaridade");
		
		PrintWriter saida = res.getWriter() ;
		saida.println("<html>");
		saida.println("<body> Nome: "+nome+" Tel: "
				+tel+ " Nascimento: "+nasc+
				"Email: "+email+" sexo: "+sexo
				+" Escolaridade: "+escolaridade+" Tecnologias: ");
				
				String lsTecnologia = "";
				for(String t: tecnologia) {
					saida.println(t);
					lsTecnologia+=t+", ";
				}
		
		
		
		try {
			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://chunee.db.elephantsql.com:5432/wbuhhaks";
			String usuarioDb = "wbuhhaks";
			String senhaDb = "a0p5pPiSOLKrxzPs0yj5BggNfrSUGfQJ";
			java.sql.Connection cont = DriverManager.getConnection(url, usuarioDb, senhaDb);
			saida.println("Ok para conexão");
			
			String sql = "insert into pessoa(nome, tel, nasc, email, sexo, tecnologia, escolaridade) \r\n"
					+ "values('"+nome+"','"+tel+"','"+nasc+"','"+email+"','"+sexo+"','"+lsTecnologia+"','"+escolaridade+"');";
			
			PreparedStatement pst = cont.prepareStatement(sql);
			pst.execute();
			saida.println("Registro gravado");
			
		} catch (Exception e) {
			saida.println("Erro de conexão."+e);
			
		}
		
		saida.println("</body><html>");
		
	}
}
