package br.edu.ucb.webdatamodeling.mail.service;

import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.mail.MailException;

public interface MailService {

	void send(Usuario usuario) throws MailException;
	
}
