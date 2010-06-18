package br.edu.ucb.webdatamodeling.dto;

import br.edu.ucb.webdatamodeling.entity.Campo;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class CampoDTO extends AbstractDTO<Campo, Long> {
	
	private Long id;
	private String descricao;
	private String valorPadrao;
	private String comentario;
	private Integer tamanho;
	private Boolean naoNulo;
	private Boolean autoIncremento;
	private Boolean chavePrimaria;
	private TabelaDTO tabela;
	private TabelaDTO tabelaEstrangeira;
	private TipoCampoDTO tipo;

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

	public String getValorPadrao() {
		return valorPadrao;
	}

	public void setValorPadrao(String valorPadrao) {
		this.valorPadrao = valorPadrao;
	}

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	
	public Integer getTamanho() {
		return tamanho;
	}

	public void setTamanho(Integer tamanho) {
		this.tamanho = tamanho;
	}

	public Boolean getNaoNulo() {
		return naoNulo;
	}

	public void setNaoNulo(Boolean naoNulo) {
		this.naoNulo = naoNulo;
	}

	public Boolean getAutoIncremento() {
		return autoIncremento;
	}

	public void setAutoIncremento(Boolean autoIncremento) {
		this.autoIncremento = autoIncremento;
	}

	public Boolean getChavePrimaria() {
		return chavePrimaria;
	}

	public void setChavePrimaria(Boolean chavePrimaria) {
		this.chavePrimaria = chavePrimaria;
	}

	public TabelaDTO getTabela() {
		return tabela;
	}

	public void setTabela(TabelaDTO tabela) {
		this.tabela = tabela;
	}
	
	public TabelaDTO getTabelaEstrangeira() {
		return tabelaEstrangeira;
	}

	public void setTabelaEstrangeira(TabelaDTO tabelaEstrangeira) {
		this.tabelaEstrangeira = tabelaEstrangeira;
	}

	public TipoCampoDTO getTipo() {
		return tipo;
	}

	public void setTipo(TipoCampoDTO tipo) {
		this.tipo = tipo;
	}

}
