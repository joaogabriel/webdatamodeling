package br.edu.ucb.webdatamodeling.framework.dto;

import java.util.List;

public class ResponseDTO {

	private DTO<?, ?> dto;
	private List<DTO<?, ?>> dtos;
	private Boolean erro;
	private String mensagemErro;
	
	public DTO<?, ?> getDto() {
		return dto;
	}

	public void setDto(DTO<?, ?> dto) {
		this.dto = dto;
	}

	public List<DTO<?, ?>> getDtos() {
		return dtos;
	}

	public void setDtos(List<DTO<?, ?>> dtos) {
		this.dtos = dtos;
	}

	public Boolean hasErro() {
		return erro;
	}

	public void setErro(Boolean erro) {
		this.erro = erro;
	}

	public String getMensagemErro() {
		return mensagemErro;
	}

	public void setMensagemErro(String mensagemErro) {
		this.mensagemErro = mensagemErro;
	}
	
}
