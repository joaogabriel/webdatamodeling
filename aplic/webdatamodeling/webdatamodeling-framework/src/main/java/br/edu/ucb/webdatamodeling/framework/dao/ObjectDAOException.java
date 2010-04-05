package br.edu.ucb.webdatamodeling.framework.dao;

/**
 * Exceção padrão que deve ser lançada em todos os métodos da camada de acesso a dados.
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
