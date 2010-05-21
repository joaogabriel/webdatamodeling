package br.edu.ucb.webdatamodeling.dto;

import java.util.Date;
import java.util.List;

import br.edu.ucb.webdatamodeling.entity.Pasta;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class PastaDTO extends AbstractDTO<Pasta, Long> {
	
	private Long id;
	private String nome;
	private String descricao;
	private Date dataCriacao;
	private Date dataUltimaAlteracao;
	private UsuarioDTO usuario;
	private List<ArquivoDTO> arquivos;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = doDefineIdValue(id);
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Date getDataCriacao() {
		return dataCriacao;
	}

	public void setDataCriacao(Date dataCriacao) {
		this.dataCriacao = dataCriacao;
	}

	public Date getDataUltimaAlteracao() {
		return dataUltimaAlteracao;
	}

	public void setDataUltimaAlteracao(Date dataUltimaAlteracao) {
		this.dataUltimaAlteracao = dataUltimaAlteracao;
	}

	public UsuarioDTO getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioDTO usuario) {
		this.usuario = usuario;
	}

	public List<ArquivoDTO> getArquivos() {
		return arquivos;
	}

	public void setArquivos(List<ArquivoDTO> arquivos) {
		this.arquivos = arquivos;
	}

}
