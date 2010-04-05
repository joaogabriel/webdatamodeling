package br.edu.ucb.webdatamodeling.service.impl;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.service.MerService;

@RemotingDestination
@Service(value = "MerService")
public class MerServiceImpl extends AbstractObjectService<Mer, MerDTO, MerDAO> implements MerService {

}
