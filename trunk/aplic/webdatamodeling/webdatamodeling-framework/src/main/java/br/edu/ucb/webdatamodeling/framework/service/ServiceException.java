package br.edu.ucb.webdatamodeling.framework.service;

/**
 * Exce��o padr�o que deve ser lan�ada em todos os m�todos da camada de servi�o.
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
