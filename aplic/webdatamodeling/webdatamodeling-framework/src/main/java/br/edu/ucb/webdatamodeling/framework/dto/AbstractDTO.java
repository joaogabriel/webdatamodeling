package br.edu.ucb.webdatamodeling.framework.dto;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public abstract class AbstractDTO<E extends Entity<?>, ID extends Serializable> implements DTO<E, ID> {

	private Boolean erro;
	private String mensagemErro;
	
	protected ID doDefineIdValue(ID id) {
		if (id instanceof Long && ((Long) id).equals(0L)) {
			id = null;
		}
		return id;
	}
	
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
	public Class<DTO<E, ID>> getEntityClass() {
		return (Class<DTO<E, ID>>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
}
