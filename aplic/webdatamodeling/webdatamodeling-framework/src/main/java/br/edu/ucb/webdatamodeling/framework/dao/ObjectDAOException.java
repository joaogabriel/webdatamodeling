package br.edu.ucb.webdatamodeling.framework.dao;

/**
 * Exce��o padr�o que deve ser lan�ada em todos os m�todos da camada de acesso a dados.
 * 
 * @author joao.gabriel
 *
 */
@SuppressWarnings("serial")
public class ObjectDAOException extends Exception {

	public ObjectDAOException(String message) {
		super(message);
	}

	public ObjectDAOException(String message, Throwable throwable) {
		super(message, throwable);
	}
	
}
