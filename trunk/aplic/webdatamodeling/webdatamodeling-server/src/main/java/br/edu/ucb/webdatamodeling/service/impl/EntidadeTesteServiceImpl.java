package br.edu.ucb.webdatamodeling.service.impl;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.EntidadeTesteDAO;
import br.edu.ucb.webdatamodeling.entity.EntidadeTeste;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;

@RemotingDestination
@Service(value = "EntidadeTesteService")
public class EntidadeTesteServiceImpl extends AbstractObjectService<EntidadeTeste, EntidadeTesteDAO> {

}
