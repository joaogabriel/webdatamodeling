package br.edu.ucb.webdatamodeling.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
@Table(name="notas")
@SuppressWarnings("serial")
public class Nota extends AbstractEntity<Long> {

	private Long id;
	private String descricao;
	private Mer mer;
	
	@Id
	@Column(name="id_nota")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "sequence")
	@SequenceGenerator(name = "sequence", sequenceName = "notas_id_nota_seq", allocationSize = 0)
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "ds_nota")
	public String getDescricao() {
		return descricao;
	}
	
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	@JoinColumn(name="id_mer")
	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public Mer getMer() {
		return mer;
	}
	
	public void setMer(Mer mer) {
		this.mer = mer;
	}
	
}
