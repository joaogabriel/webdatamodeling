package br.edu.ucb.webdatamodeling.mail;

@SuppressWarnings("serial")
public class MailException extends Exception {

	public MailException(String message) {
		super(message);
	}

	public MailException(String message, Throwable throwable) {
		super(message, throwable);
	}

}
