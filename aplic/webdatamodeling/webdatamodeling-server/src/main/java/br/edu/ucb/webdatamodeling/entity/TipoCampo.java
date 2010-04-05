package br.edu.ucb.webdatamodeling.entity;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
@Table(name="tipo_campo")
public class TipoCampo extends AbstractEntity<Long> {
	
	private Long id;
	private String descricao;
	private BigDecimal valorMinimo;
	private BigDecimal valorMaximo;
	private List<Campo> campos;

	@Id
	@Column(name="id_tipo_campo")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="ds_tipo_campo")
	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@Column(name="ds_valor_minimo")
	public BigDecimal getValorMinimo() {
		return valorMinimo;
	}

	public void setValorMinimo(BigDecimal valorMinimo) {
		this.valorMinimo = valorMinimo;
	}

	@Column(name="ds_valor_maximo")
	public BigDecimal getValorMaximo() {
		return valorMaximo;
	}

	public void setValorMaximo(BigDecimal valorMaximo) {
		this.valorMaximo = valorMaximo;
	}

	@OneToMany(mappedBy="tipo")
	public List<Campo> getCampos() {
		return campos;
	}

	public void setCampos(List<Campo> campos) {
		this.campos = campos;
	}

}
