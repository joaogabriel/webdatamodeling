package br.edu.ucb.webdatamodeling.service;

import java.util.List;

import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.service.ObjectService;

public interface MerService extends ObjectService<Mer, MerDTO, MerDAO> {

	Boolean compartilhar(MerDTO mer, List<UsuarioDTO> usuarios);
	
	MerDTO getMerByArquivo(ArquivoDTO arquivoDTO);
	
}
