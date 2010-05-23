package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.entity.Pasta;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "PastaDAO")
public class PastaDAOImpl extends AbstractObjectDAO<Pasta> implements PastaDAO {

	private UsuarioDAO usuarioDAO;
	
	@Override
	public Pasta insert(Pasta entity) throws ObjectDAOException {
		Usuario usuarioPersistente = usuarioDAO.findById(entity.getUsuario().getId());
		entity.setUsuario(usuarioPersistente);
		return super.insert(entity);
	}
	
	@Resource(name = "persistence")
	public void setPersistence(Persistence<Pasta> persistence) {
		super.setPersistence(persistence);
	}
	
	@Resource(name = "UsuarioDAO")
	public void setUsuarioDAO(UsuarioDAO usuarioDAO) {
		this.usuarioDAO = usuarioDAO;
	}
	
}
