package br.edu.ucb.webdatamodeling.entity;

import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public class EntidadeTeste implements Entity<Long> {

	private Long id;
	private String mensagem;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getMensagem() {
		return mensagem;
	}
	
	public void setMensagem(String mensagem) {
		this.mensagem = mensagem;
	}
	
}
