package br.edu.ucb.webdatamodeling.dto;

import java.util.Date;
import java.util.List;

import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class UsuarioDTO extends AbstractDTO<Usuario> {
	
	private Long id;
	private String nome;
	private String sobrenome;
	private String email;
	private String senha;
	private Date dataCadastro;
	private Date dataNascimento;
	private List<PastaDTO> pastas;
	private List<MerDTO> mers;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getSobrenome() {
		return sobrenome;
	}

	public void setSobrenome(String sobrenome) {
		this.sobrenome = sobrenome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public Date getDataCadastro() {
		return dataCadastro;
	}

	public void setDataCadastro(Date dataCadastro) {
		this.dataCadastro = dataCadastro;
	}

	public Date getDataNascimento() {
		return dataNascimento;
	}

	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}

	public List<PastaDTO> getPastas() {
		return pastas;
	}

	public void setPastas(List<PastaDTO> pastas) {
		this.pastas = pastas;
	}

	public List<MerDTO> getMers() {
		return mers;
	}

	public void setMers(List<MerDTO> mers) {
		this.mers = mers;
	}

}
