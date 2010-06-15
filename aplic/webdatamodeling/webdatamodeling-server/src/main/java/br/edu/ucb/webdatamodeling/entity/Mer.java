package br.edu.ucb.webdatamodeling.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
@Table(name="mer")
@SuppressWarnings("serial")
public class Mer extends AbstractEntity<Long> {
	
	private Long id;
	private Boolean exportado;
	private Date dataUltimaExportacao;
	private Arquivo arquivo;
	private List<Tabela> tabelas;
	private List<Usuario> usuarios;
	private List<Nota> notas;

	public Mer() {
		
	}
	
	public Mer(Mer mer) {
		this.id = mer.getId();
		this.exportado = mer.getExportado();
		this.dataUltimaExportacao = mer.getDataUltimaExportacao();
		this.arquivo = mer.getArquivo();
		this.tabelas = mer.getTabelas();
		this.notas = mer.getNotas();
		this.usuarios = mer.getUsuarios();
	}
	
	@Id
	@Column(name="id_mer")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "sequence")
	@SequenceGenerator(name = "sequence", sequenceName = "mer_id_mer_seq", allocationSize = 0)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="exportado")
	public Boolean getExportado() {
		return exportado;
	}

	public void setExportado(Boolean exportado) {
		this.exportado = exportado;
	}

	@Column(name="dt_ultima_exportacao")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getDataUltimaExportacao() {
		return dataUltimaExportacao;
	}

	public void setDataUltimaExportacao(Date dataUltimaExportacao) {
		this.dataUltimaExportacao = dataUltimaExportacao;
	}

	@OneToOne(optional = false, fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name="id_arquivo", referencedColumnName="id_arquivo")
	public Arquivo getArquivo() {
		return arquivo;
	}

	public void setArquivo(Arquivo arquivo) {
		this.arquivo = arquivo;
	}

	@OneToMany(mappedBy="mer", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public List<Tabela> getTabelas() {
		return tabelas;
	}

	public void setTabelas(List<Tabela> tabelas) {
		this.tabelas = tabelas;
	}

	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name="compartilhamento",
		joinColumns=@JoinColumn(name="id_mer"),
		inverseJoinColumns=@JoinColumn(name="id_usuario"))
	public List<Usuario> getUsuarios() {
		return usuarios;
	}

	public void setUsuarios(List<Usuario> usuarios) {
		this.usuarios = usuarios;
	}

	@OneToMany(mappedBy="mer", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	public List<Nota> getNotas() {
		return notas;
	}

	public void setNotas(List<Nota> notas) {
		this.notas = notas;
	}
	
}
