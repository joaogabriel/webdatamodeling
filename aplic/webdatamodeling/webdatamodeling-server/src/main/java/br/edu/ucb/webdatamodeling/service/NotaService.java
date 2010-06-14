package br.edu.ucb.webdatamodeling.service;

import br.edu.ucb.webdatamodeling.dao.NotaDAO;
import br.edu.ucb.webdatamodeling.dto.NotaDTO;
import br.edu.ucb.webdatamodeling.entity.Nota;
import br.edu.ucb.webdatamodeling.framework.service.ObjectService;

public interface NotaService extends ObjectService<Nota, NotaDTO, NotaDAO> {

}
