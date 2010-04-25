package br.edu.ucb.webdatamodeling.dao;

import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;

public interface UsuarioDAO extends ObjectDAO<Usuario> {

	Usuario findByEmail(Usuario usuario) throws ObjectDAOException;
	
	Usuario findByEmailESenha(Usuario usuario) throws ObjectDAOException;
	
}
