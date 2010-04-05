package br.edu.ucb.webdatamodeling.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
@Table(name="campo")
public class Campo extends AbstractEntity<Long> {
	
	private Long id;
	private String descricao;
	private String valorPadrao;
	private String comentario;
	private Boolean naoNulo;
	private Boolean autoIncremento;
	private Boolean chavePrimaria;
	private Boolean chaveEstrangeira;
	private Tabela tabela;
	private TipoCampo tipo;

	@Id
	@Column(name="id_campo")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="ds_campo")
	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@Column(name="ds_valor_padrao")
	public String getValorPadrao() {
		return valorPadrao;
	}

	public void setValorPadrao(String valorPadrao) {
		this.valorPadrao = valorPadrao;
	}

	@Column(name="ds_comentario")
	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	@Column(name="nao_nulo")
	public Boolean getNaoNulo() {
		return naoNulo;
	}

	public void setNaoNulo(Boolean naoNulo) {
		this.naoNulo = naoNulo;
	}

	@Column(name="auto_incremento")
	public Boolean isAutoIncremento() {
		return autoIncremento;
	}

	public void setAutoIncremento(Boolean autoIncremento) {
		this.autoIncremento = autoIncremento;
	}

	@Column(name="chave_primaria")
	public Boolean isChavePrimaria() {
		return chavePrimaria;
	}

	public void setChavePrimaria(Boolean chavePrimaria) {
		this.chavePrimaria = chavePrimaria;
	}

	@Column(name="chave_estrangeira")
	public Boolean isChaveEstrangeira() {
		return chaveEstrangeira;
	}

	public void setChaveEstrangeira(Boolean chaveEstrangeira) {
		this.chaveEstrangeira = chaveEstrangeira;
	}

	@ManyToOne
	@JoinColumn(name="id_tabela")
	public Tabela getTabela() {
		return tabela;
	}

	public void setTabela(Tabela tabela) {
		this.tabela = tabela;
	}

	@ManyToOne
	@JoinColumn(name="id_tipo_campo")
	public TipoCampo getTipo() {
		return tipo;
	}

	public void setTipo(TipoCampo tipo) {
		this.tipo = tipo;
	}

}
