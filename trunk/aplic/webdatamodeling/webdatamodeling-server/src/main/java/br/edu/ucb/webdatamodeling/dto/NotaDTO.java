package br.edu.ucb.webdatamodeling.dto;

import java.math.BigDecimal;

import br.edu.ucb.webdatamodeling.entity.Nota;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class NotaDTO extends AbstractDTO<Nota, Long> {

	private Long id;
	private String descricao;
	private BigDecimal coordenadaX;
	private BigDecimal coordenadaY;
	private MerDTO mer;
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getDescricao() {
		return descricao;
	}
	
	public void setDescricao(String descricao) {
		this.descricao = descricao;
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
	
}
