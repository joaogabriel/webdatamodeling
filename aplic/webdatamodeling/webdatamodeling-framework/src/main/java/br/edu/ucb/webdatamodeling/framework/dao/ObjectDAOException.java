package br.edu.ucb.webdatamodeling.framework.dao;

@SuppressWarnings("serial")
public class ObjectDAOException extends Exception {

	public ObjectDAOException(String message) {
		super(message);
	}

	public ObjectDAOException(String message, Throwable throwable) {
		super(message, throwable);
	}
	
}
