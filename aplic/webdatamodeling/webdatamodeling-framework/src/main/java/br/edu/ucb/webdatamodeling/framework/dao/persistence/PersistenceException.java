package br.edu.ucb.webdatamodeling.framework.dao.persistence;

/**
 * Exce��o padr�o que deve ser lan�ada em todos os m�todos da camada de persist�ncia.
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
