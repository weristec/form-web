package org.senai.model;

public class Pessoa {

	private int id;
	private String nome = "";
	private String tel = "";
	private String nasc = "";
	private String email = "";
	private String sexo = "";
	private String[] tecnologia = {""};
	private String escolaridade = "";

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNomeCompleto() {
		return nome;
	}

	public void setNomeCompleto(String nome) {
		this.nome = nome;
	}

	public String getTelefone() {
		return tel;
	}

	public void setTelefone(String tel) {
		this.tel = tel;
	}

	public String getDtNascimento() {
		return nasc;
	}

	public void setDtNascimento(String nasc) {
		this.nasc = nasc;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String[] getTecnologia() {
		return tecnologia;
	}

	public void setTecnologia(String[] tecnologia) {
		this.tecnologia = tecnologia;
	}

	public String getEscolaridade() {
		return escolaridade;
	}

	public void setEscolaridade(String escolaridade) {
		this.escolaridade = escolaridade;
	}

}
