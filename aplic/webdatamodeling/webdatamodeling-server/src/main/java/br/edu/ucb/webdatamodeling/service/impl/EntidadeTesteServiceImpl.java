package br.edu.ucb.webdatamodeling.service.impl;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.EntidadeTesteDAO;
import br.edu.ucb.webdatamodeling.entity.EntidadeTeste;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.EntidadeTesteService;

@RemotingDestination
@Service(value = "EntidadeTesteService")
public class EntidadeTesteServiceImpl extends AbstractObjectService<EntidadeTeste, EntidadeTesteDAO> implements EntidadeTesteService {

	@Override
	public String getMensagemFromServer() {
		return "Caralho! Conectei com a porra do servidor.";
	}

	@Override
	public String testParameter(String parameter) {
		String result = "false!!!";
		
		if (parameter != null && !parameter.isEmpty()) {
			result = "true!!!";
		}
		
		return result;
	}

}
