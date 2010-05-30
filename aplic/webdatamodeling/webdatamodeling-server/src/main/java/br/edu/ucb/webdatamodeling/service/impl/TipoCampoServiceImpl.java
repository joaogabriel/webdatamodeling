package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.TipoCampoDAO;
import br.edu.ucb.webdatamodeling.dto.TipoCampoDTO;
import br.edu.ucb.webdatamodeling.entity.TipoCampo;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.TipoCampoService;

@RemotingDestination
@Service(value = "TipoCampoService")
public class TipoCampoServiceImpl extends AbstractObjectService<TipoCampo, TipoCampoDTO, TipoCampoDAO> implements TipoCampoService {

	@Resource(name = "TipoCampoDAO")
	public void setDao(TipoCampoDAO dao) {
		super.setDao(dao);
	}
	
}
