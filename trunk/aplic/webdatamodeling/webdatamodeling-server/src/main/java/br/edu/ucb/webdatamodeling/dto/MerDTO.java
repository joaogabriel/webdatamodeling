package br.edu.ucb.webdatamodeling.dto;

import java.util.Date;
import java.util.List;

import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class MerDTO extends AbstractDTO<Mer, Long> {
	
	private Long id;
	private Boolean exportado;
	private Date dataUltimaExportacao;
	private ArquivoDTO arquivo;
	private List<TabelaDTO> tabelas;
	private List<UsuarioDTO> usuarios;
	private List<NotaDTO> notas;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = doDefineIdValue(id);
	}

	public Boolean getExportado() {
		return exportado;
	}

	public void setExportado(Boolean exportado) {
		this.exportado = exportado;
	}

	public Date getDataUltimaExportacao() {
		return dataUltimaExportacao;
	}

	public void setDataUltimaExportacao(Date dataUltimaExportacao) {
		this.dataUltimaExportacao = dataUltimaExportacao;
	}

	public ArquivoDTO getArquivo() {
		return arquivo;
	}

	public void setArquivo(ArquivoDTO arquivo) {
		this.arquivo = arquivo;
	}

	public List<TabelaDTO> getTabelas() {
		return tabelas;
	}

	public void setTabelas(List<TabelaDTO> tabelas) {
		this.tabelas = tabelas;
	}

	public List<UsuarioDTO> getUsuarios() {
		return usuarios;
	}

	public void setUsuarios(List<UsuarioDTO> usuarios) {
		this.usuarios = usuarios;
	}

	public List<NotaDTO> getNotas() {
		return notas;
	}

	public void setNotas(List<NotaDTO> notas) {
		this.notas = notas;
	}
	
}
