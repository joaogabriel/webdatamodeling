package br.edu.ucb.webdatamodeling.framework.dto;

import br.edu.ucb.webdatamodeling.framework.entity.Entity;

/**
 * Interface de marcação para as classes de transporte.
 * 
 * @author joao.gabriel
 *
 */
public interface DTO<E extends Entity<?>> {

	Class<DTO<E>> getEntityClass();
	
	Boolean hasErro();
	
	void setErro(Boolean erro);

	String getMensagemErro();
	
	void setMensagemErro(String mensagemErro);
	
}
