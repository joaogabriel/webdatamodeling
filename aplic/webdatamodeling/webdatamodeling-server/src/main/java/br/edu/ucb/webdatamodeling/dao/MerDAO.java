package br.edu.ucb.webdatamodeling.dao;

import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAO;

public interface MerDAO extends ObjectDAO<Mer> {

	Mer getMerByArquivo(Long idArquivo);
	
}
