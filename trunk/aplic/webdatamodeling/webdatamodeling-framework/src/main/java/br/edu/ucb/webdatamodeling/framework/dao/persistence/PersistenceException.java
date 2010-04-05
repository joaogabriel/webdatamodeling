package br.edu.ucb.webdatamodeling.framework.dao.persistence;

/**
 * Exceção padrão que deve ser lançada em todos os métodos da camada de persistência.
 * 
 * @author joao.gabriel
 *
 */
@SuppressWarnings("serial")
public class PersistenceException extends Exception {

	public PersistenceException(String message) {
		super(message);
	}

	public PersistenceException(Throwable throwable) {
		super(throwable);
	}
	
	public PersistenceException(String message, Throwable throwable) {
		super(message, throwable);
	}
	
}
