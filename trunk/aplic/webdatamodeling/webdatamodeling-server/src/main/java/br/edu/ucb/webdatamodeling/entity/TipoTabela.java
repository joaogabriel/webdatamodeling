package br.edu.ucb.webdatamodeling.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
@Table(name="tipo_tabela")
@SuppressWarnings("serial")
public class TipoTabela extends AbstractEntity<Long> {
	
	private Long id;
	private String descricao;
	private List<Tabela> tabelas;

	@Id
	@Column(name="id_tipo_tabela")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "sequence")
	@SequenceGenerator(name = "sequence", sequenceName = "tipo_tabela_id_tipo_tabela_seq", allocationSize = 0)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="ds_tipo_tabela")
	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@OneToMany(mappedBy="tipo", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public List<Tabela> getTabelas() {
		return tabelas;
	}

	public void setTabelas(List<Tabela> tabelas) {
		this.tabelas = tabelas;
	}

}
