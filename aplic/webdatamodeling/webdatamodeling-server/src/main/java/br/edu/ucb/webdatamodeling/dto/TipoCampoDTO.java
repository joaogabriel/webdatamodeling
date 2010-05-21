package br.edu.ucb.webdatamodeling.dto;

import java.math.BigDecimal;
import java.util.List;

import br.edu.ucb.webdatamodeling.entity.TipoCampo;
import br.edu.ucb.webdatamodeling.framework.dto.AbstractDTO;

public class TipoCampoDTO extends AbstractDTO<TipoCampo, Long> {
	
	private Long id;
	private String descricao;
	private BigDecimal valorMinimo;
	private BigDecimal valorMaximo;
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

	public BigDecimal getValorMinimo() {
		return valorMinimo;
	}

	public void setValorMinimo(BigDecimal valorMinimo) {
		this.valorMinimo = valorMinimo;
	}

	public BigDecimal getValorMaximo() {
		return valorMaximo;
	}

	public void setValorMaximo(BigDecimal valorMaximo) {
		this.valorMaximo = valorMaximo;
	}

	public List<CampoDTO> getCampos() {
		return campos;
	}

	public void setCampos(List<CampoDTO> campos) {
		this.campos = campos;
	}

}
