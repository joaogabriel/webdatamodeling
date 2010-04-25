package br.edu.ucb.webdatamodeling.framework.dto;

import java.lang.reflect.ParameterizedType;

import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public abstract class AbstractDTO<E extends Entity<?>> implements DTO<E> {

	private Boolean erro;
	private String mensagemErro;
	
	@Override
	public Boolean hasErro() {
		if (erro == null) {
			erro = Boolean.FALSE;
		}
		return erro;
	}

	public void setErro(Boolean erro) {
		this.erro = erro;
	}

	@Override
	public String getMensagemErro() {
		return mensagemErro;
	}

	public void setMensagemErro(String mensagemErro) {
		this.mensagemErro = mensagemErro;
	}
	
	@SuppressWarnings("unchecked")
	public Class<DTO<E>> getEntityClass() {
		return (Class<DTO<E>>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
}
