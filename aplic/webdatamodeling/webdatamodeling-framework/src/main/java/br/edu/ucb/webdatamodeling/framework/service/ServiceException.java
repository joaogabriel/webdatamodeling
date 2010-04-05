package br.edu.ucb.webdatamodeling.framework.service;

/**
 * Exceção padrão que deve ser lançada em todos os métodos da camada de serviço.
 * 
 * @author joao.gabriel
 *
 */
@SuppressWarnings("serial")
public class ServiceException extends Exception {

	public ServiceException(String message) {
		super(message);
	}

	public ServiceException(String message, Throwable t) {
		super(message, t);
	}
	
}
