package br.edu.ucb.webdatamodeling.service.impl;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.dto.PastaDTO;
import br.edu.ucb.webdatamodeling.entity.Pasta;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.PastaService;

@RemotingDestination
@Service(value = "PastaService")
public class PastaServiceImpl extends AbstractObjectService<Pasta, PastaDTO, PastaDAO> implements PastaService {

}
