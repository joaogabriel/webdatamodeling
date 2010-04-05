package br.edu.ucb.webdatamodeling.framework.dto;

@SuppressWarnings("serial")
public class DTOException extends Exception {

	public DTOException(String message) {
		super(message);
	}

	public DTOException(String message, Throwable t) {
		super(message, t);
	}
	
}
