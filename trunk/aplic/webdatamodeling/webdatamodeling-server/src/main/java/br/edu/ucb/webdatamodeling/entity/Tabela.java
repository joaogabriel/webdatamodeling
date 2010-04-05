package br.edu.ucb.webdatamodeling.entity;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
public class Tabela extends AbstractEntity<Long> {
	
	private Long id;
	private String descricao;
	private String comentario;
	private BigDecimal coordenadaX;
	private BigDecimal coordenadaY;
	private Mer mer;
	private TipoTabela tipo;
	private List<Campo> campos;

	@Id
	@Column(name="id_tabela")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="ds_tabela")
	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@Column(name="ds_comentario")
	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	@Column(name="coordenada_x")
	public BigDecimal getCoordenadaX() {
		return coordenadaX;
	}

	public void setCoordenadaX(BigDecimal coordenadaX) {
		this.coordenadaX = coordenadaX;
	}

	@Column(name="coordenada_y")
	public BigDecimal getCoordenadaY() {
		return coordenadaY;
	}

	public void setCoordenadaY(BigDecimal coordenadaY) {
		this.coordenadaY = coordenadaY;
	}

	@ManyToOne
	@JoinColumn(name="id_mer")
	public Mer getMer() {
		return mer;
	}

	public void setMer(Mer mer) {
		this.mer = mer;
	}

	@ManyToOne
	@JoinColumn(name="id_tipo_tabela")
	public TipoTabela getTipo() {
		return tipo;
	}

	public void setTipo(TipoTabela tipo) {
		this.tipo = tipo;
	}

	@OneToMany(mappedBy="tabela")
	public List<Campo> getCampos() {
		return campos;
	}

	public void setCampos(List<Campo> campos) {
		this.campos = campos;
	}

}
