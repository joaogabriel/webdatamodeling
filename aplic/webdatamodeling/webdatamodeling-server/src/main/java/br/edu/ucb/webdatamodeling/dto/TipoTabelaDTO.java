package br.edu.ucb.webdatamodeling.dto;

import java.util.List;

import br.edu.ucb.webdatamodeling.entity.TipoTabela;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class TipoTabelaDTO extends AbstractDTO<TipoTabela, Long> {
	
	private Long id;
	private String descricao;
	private List<TabelaDTO> tabelas;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = doDefineIdValue(id);
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public List<TabelaDTO> getTabelas() {
		return tabelas;
	}

	public void setTabelas(List<TabelaDTO> tabelas) {
		this.tabelas = tabelas;
	}

}
