package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.NotaDAO;
import br.edu.ucb.webdatamodeling.dto.NotaDTO;
import br.edu.ucb.webdatamodeling.entity.Nota;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.NotaService;

@Service(value = "NotaService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class NotaServiceImpl extends AbstractObjectService<Nota, NotaDTO, NotaDAO> implements NotaService {

	@Resource(name = "NotaDAO")
	public void setDao(NotaDAO dao) {
		super.setDao(dao);
	}
	
}
