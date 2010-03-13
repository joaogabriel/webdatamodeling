package br.edu.ucb.webdatamodeling.framework.dao.persistence;

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
