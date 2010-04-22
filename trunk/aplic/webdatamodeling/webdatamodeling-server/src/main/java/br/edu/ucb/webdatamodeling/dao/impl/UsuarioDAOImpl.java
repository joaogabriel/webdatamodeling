package br.edu.ucb.webdatamodeling.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.PersistenceException;

@Repository(value = "UsuarioDAO")
public class UsuarioDAOImpl extends AbstractObjectDAO<Usuario> implements UsuarioDAO {

	@Override
	public Usuario findByEmailESenha(Usuario usuario) throws ObjectDAOException {
		List<Usuario> usuarios  = null;
		
		try {
			StringBuilder query = new StringBuilder();
			query.append("from ").append(getEntityClass().getName()).append(" usuario");
			query.append(" where usuario.email = '").append(usuario.getEmail()).append("'");
			query.append(" and usuario.senha = '").append(usuario.getSenha()).append("'");
			
			usuarios = getPersistence().findByHQL(query.toString());
			
			if (usuarios != null && usuarios.size() == 1) {
				usuario = usuarios.get(0);
			} else {
				usuario = null;
			}
		} catch (PersistenceException e) {
			throw new ObjectDAOException("Não foi possível pesquisar o usuário.", e);
		}
		
		return usuario;
	}
	
	@Resource(name = "persistence")
	public void setPersistence(Persistence<Usuario> persistence) {
		super.setPersistence(persistence);
	}
	
}
