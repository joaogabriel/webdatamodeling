package br.edu.ucb.webdatamodeling.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.edu.ucb.webdatamodeling.framework.entity.AbstractEntity;

@Entity
@Table(name = "usuario")
public class Usuario extends AbstractEntity<Long> {
	
	private Long id;
	private String nome;
	private String sobrenome;
	private String email;
	private String senha;
	private Date dataCadastro;
	private Date dataNascimento;
	private List<Pasta> pastas;
	private List<Mer> mers;

	@Id
	@Column(name="id_usuario")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "sequence")
	@SequenceGenerator(name = "sequence", sequenceName = "usuario_id_usuario_seq", allocationSize = 0)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="ds_usuario")
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Column(name="ds_sobrenome")
	public String getSobrenome() {
		return sobrenome;
	}

	public void setSobrenome(String sobrenome) {
		this.sobrenome = sobrenome;
	}

	@Column(name="ds_email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name="ds_senha")
	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	@Column(name="dt_cadastro")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getDataCadastro() {
		return dataCadastro;
	}

	public void setDataCadastro(Date dataCadastro) {
		this.dataCadastro = dataCadastro;
	}

	@Column(name="dt_nascimento")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getDataNascimento() {
		return dataNascimento;
	}

	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}

	@OneToMany(mappedBy="usuario")
	public List<Pasta> getPastas() {
		return pastas;
	}

	public void setPastas(List<Pasta> pastas) {
		this.pastas = pastas;
	}

	@ManyToMany(mappedBy="usuarios")
	public List<Mer> getMers() {
		return mers;
	}

	public void setMers(List<Mer> mers) {
		this.mers = mers;
	}

}
