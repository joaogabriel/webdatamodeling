package br.edu.ucb.webdatamodeling.dao;

import java.util.List;

import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;

public interface UsuarioDAO extends ObjectDAO<Usuario> {

	Usuario findByEmail(Usuario usuario) throws ObjectDAOException;
	
	Usuario findByEmailESenha(Usuario usuario) throws ObjectDAOException;
	
	List<Usuario> findByNomeOuEmail(Usuario usuario) throws ObjectDAOException;
	
}
