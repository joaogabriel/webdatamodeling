package br.edu.ucb.webdatamodeling.dto;

import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class EntidadeTesteDTO extends AbstractDTO {

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
