package br.edu.ucb.webdatamodeling.dto;

import java.util.Date;

import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class ArquivoDTO extends AbstractDTO<Arquivo> {
	
	private Long id;
	private String versao;
	private String nome;
	private String descricao;
	private Date dataCriacao;
	private Date dataUltimaAlteracao;
	private PastaDTO pasta;
	private TipoArquivoDTO tipo;
	private MerDTO mer;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getVersao() {
		return versao;
	}

	public void setVersao(String versao) {
		this.versao = versao;
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

	public PastaDTO getPasta() {
		return pasta;
	}

	public void setPasta(PastaDTO pasta) {
		this.pasta = pasta;
	}

	public TipoArquivoDTO getTipo() {
		return tipo;
	}

	public void setTipo(TipoArquivoDTO tipo) {
		this.tipo = tipo;
	}
	
	public MerDTO getMer() {
		return mer;
	}

	public void setMer(MerDTO mer) {
		this.mer = mer;
	}

}
