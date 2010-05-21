package br.edu.ucb.webdatamodeling.framework.dto;

import java.io.Serializable;

import br.edu.ucb.webdatamodeling.framework.entity.Entity;

/**
 * Interface de marcação para as classes de transporte.
 * 
 * @author joao.gabriel
 *
 */
public interface DTO<E extends Entity<?>, ID extends Serializable> {

	ID getId();
	
	void setId(ID id);
	
	Class<DTO<E, ID>> getEntityClass();
	
	Boolean hasErro();
	
	void setErro(Boolean erro);

	String getMensagemErro();
	
	void setMensagemErro(String mensagemErro);
	
}
