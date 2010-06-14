package br.edu.ucb.webdatamodeling.dao;

import java.util.List;

import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;

public interface MerDAO extends ObjectDAO<Mer> {

	Mer getMerByArquivo(Long idArquivo) throws ObjectDAOException;
	
	List<Mer> findMersByUsuarioCompartilhado(Long idUsuario) throws ObjectDAOException;
	
}
