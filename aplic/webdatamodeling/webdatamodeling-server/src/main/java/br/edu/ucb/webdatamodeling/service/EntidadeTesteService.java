package br.edu.ucb.webdatamodeling.service;

import br.edu.ucb.webdatamodeling.dao.EntidadeTesteDAO;
import br.edu.ucb.webdatamodeling.entity.EntidadeTeste;
import br.edu.ucb.webdatamodeling.framework.service.ObjectService;

public interface EntidadeTesteService extends ObjectService<EntidadeTeste, EntidadeTesteDAO> {

	String getMensagemFromServer();
	
	String testParameter(String parameter);
	
}
