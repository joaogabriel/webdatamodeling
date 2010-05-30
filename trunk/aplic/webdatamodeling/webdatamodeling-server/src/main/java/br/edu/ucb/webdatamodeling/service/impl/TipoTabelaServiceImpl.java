package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.TipoTabelaDAO;
import br.edu.ucb.webdatamodeling.dto.TipoTabelaDTO;
import br.edu.ucb.webdatamodeling.entity.TipoTabela;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.TipoTabelaService;

@RemotingDestination
@Service(value = "TipoTabelaService")
public class TipoTabelaServiceImpl extends AbstractObjectService<TipoTabela, TipoTabelaDTO, TipoTabelaDAO> implements TipoTabelaService {

	@Resource(name = "TipoTabelaDAO")
	public void setDao(TipoTabelaDAO dao) {
		super.setDao(dao);
	}
	
}
