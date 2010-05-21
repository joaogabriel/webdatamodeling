package br.edu.ucb.webdatamodeling.dto;

import java.math.BigDecimal;
import java.util.List;

import br.edu.ucb.webdatamodeling.entity.Tabela;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class TabelaDTO extends AbstractDTO<Tabela, Long> {
	
	private Long id;
	private String descricao;
	private String comentario;
	private BigDecimal coordenadaX;
	private BigDecimal coordenadaY;
	private MerDTO mer;
	private TipoTabelaDTO tipo;
	private List<CampoDTO> campos;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = doDefineIdValue(id);
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public BigDecimal getCoordenadaX() {
		return coordenadaX;
	}

	public void setCoordenadaX(BigDecimal coordenadaX) {
		this.coordenadaX = coordenadaX;
	}

	public BigDecimal getCoordenadaY() {
		return coordenadaY;
	}

	public void setCoordenadaY(BigDecimal coordenadaY) {
		this.coordenadaY = coordenadaY;
	}

	public MerDTO getMer() {
		return mer;
	}

	public void setMer(MerDTO mer) {
		this.mer = mer;
	}

	public TipoTabelaDTO getTipo() {
		return tipo;
	}

	public void setTipo(TipoTabelaDTO tipo) {
		this.tipo = tipo;
	}

	public List<CampoDTO> getCampos() {
		return campos;
	}

	public void setCampos(List<CampoDTO> campos) {
		this.campos = campos;
	}
	
}
