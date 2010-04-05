package br.edu.ucb.webdatamodeling.service.impl;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.ArquivoDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.ArquivoService;

@RemotingDestination
@Service(value = "ArquivoService")
public class ArquivoServiceImpl extends AbstractObjectService<Arquivo, ArquivoDTO, ArquivoDAO> implements ArquivoService {

}
