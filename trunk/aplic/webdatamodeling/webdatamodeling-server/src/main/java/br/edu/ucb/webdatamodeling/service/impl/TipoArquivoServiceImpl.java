package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.TipoArquivoDAO;
import br.edu.ucb.webdatamodeling.dto.TipoArquivoDTO;
import br.edu.ucb.webdatamodeling.entity.TipoArquivo;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.TipoArquivoService;

@RemotingDestination
@Service(value = "TipoArquivoService")
public class TipoArquivoServiceImpl extends AbstractObjectService<TipoArquivo, TipoArquivoDTO, TipoArquivoDAO> implements TipoArquivoService {

	@Resource(name = "TipoArquivoDAO")
	public void setDao(TipoArquivoDAO dao) {
		super.setDao(dao);
	}
	
}
