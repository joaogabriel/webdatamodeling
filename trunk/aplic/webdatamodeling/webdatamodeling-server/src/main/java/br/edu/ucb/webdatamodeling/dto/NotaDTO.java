package br.edu.ucb.webdatamodeling.dto;

import br.edu.ucb.webdatamodeling.entity.Nota;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class NotaDTO extends AbstractDTO<Nota, Long> {

	private Long id;
	private String descricao;
	private MerDTO mer;
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getDescricao() {
		return descricao;
	}
	
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	public MerDTO getMer() {
		return mer;
	}
	
	public void setMer(MerDTO mer) {
		this.mer = mer;
	}
	
}
