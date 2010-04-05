package br.edu.ucb.webdatamodeling.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
@Table(name="arquivo")
public class Arquivo extends AbstractEntity<Long> {
	
	private Long id;
	private String versao;
	private String nome;
	private String descricao;
	private Date dataCriacao;
	private Date dataUltimaAlteracao;
	private Pasta pasta;
	private TipoArquivo tipo;
	private Mer mer;

	@Id
	@Column(name="id_arquivo")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="ds_versao")
	public String getVersao() {
		return versao;
	}

	public void setVersao(String versao) {
		this.versao = versao;
	}

	@Column(name="ds_nome")
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Column(name="ds_descricao")
	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	@Column(name="dt_criacao")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getDataCriacao() {
		return dataCriacao;
	}

	public void setDataCriacao(Date dataCriacao) {
		this.dataCriacao = dataCriacao;
	}

	@Column(name="dt_ultima_alteracao")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getDataUltimaAlteracao() {
		return dataUltimaAlteracao;
	}

	public void setDataUltimaAlteracao(Date dataUltimaAlteracao) {
		this.dataUltimaAlteracao = dataUltimaAlteracao;
	}

	@ManyToOne
	@JoinColumn(name="id_pasta")
	public Pasta getPasta() {
		return pasta;
	}

	public void setPasta(Pasta pasta) {
		this.pasta = pasta;
	}

	@ManyToOne
	@JoinColumn(name="id_tipo_arquivo")
	public TipoArquivo getTipo() {
		return tipo;
	}

	public void setTipo(TipoArquivo tipo) {
		this.tipo = tipo;
	}
	
	@OneToOne(mappedBy="arquivo")
	public Mer getMer() {
		return mer;
	}

	public void setMer(Mer mer) {
		this.mer = mer;
	}

}
