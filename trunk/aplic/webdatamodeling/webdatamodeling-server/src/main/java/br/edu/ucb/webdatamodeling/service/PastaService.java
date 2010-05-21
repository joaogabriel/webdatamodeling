package br.edu.ucb.webdatamodeling.service;

import java.util.List;

import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.dto.PastaDTO;
import br.edu.ucb.webdatamodeling.entity.Pasta;
import br.edu.ucb.webdatamodeling.framework.service.ObjectService;

public interface PastaService extends ObjectService<Pasta, PastaDTO, PastaDAO> {

	List<PastaDTO> getPastasByUsuarioAutenticado();
	
}
