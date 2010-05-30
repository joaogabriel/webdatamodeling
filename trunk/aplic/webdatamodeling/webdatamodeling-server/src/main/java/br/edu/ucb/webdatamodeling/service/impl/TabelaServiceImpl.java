package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.TabelaDAO;
import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
import br.edu.ucb.webdatamodeling.entity.Tabela;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.TabelaService;

@RemotingDestination
@Service(value = "TabelaService")
public class TabelaServiceImpl extends AbstractObjectService<Tabela, TabelaDTO, TabelaDAO> implements TabelaService {

	@Resource(name = "TabelaDAO")
	public void setDao(TabelaDAO dao) {
		super.setDao(dao);
	}
	
}
