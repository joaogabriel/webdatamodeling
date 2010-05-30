package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.CampoDAO;
import br.edu.ucb.webdatamodeling.dto.CampoDTO;
import br.edu.ucb.webdatamodeling.entity.Campo;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.CampoService;

@RemotingDestination
@Service(value = "CampoService")
public class CampoServiceImpl extends AbstractObjectService<Campo, CampoDTO, CampoDAO> implements CampoService {

	@Resource(name = "CampoDAO")
	public void setDao(CampoDAO dao) {
		super.setDao(dao);
	}
	
}
