package br.edu.ucb.webdatamodeling.dto;

import java.util.List;

import br.edu.ucb.webdatamodeling.entity.TipoArquivo;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class TipoArquivoDTO extends AbstractDTO<TipoArquivo, Long> {
	
	private Long id;
	private String descricao;
	private List<ArquivoDTO> arquivos;

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

	public List<ArquivoDTO> getArquivos() {
		return arquivos;
	}

	public void setArquivos(List<ArquivoDTO> arquivos) {
		this.arquivos = arquivos;
	}

}
