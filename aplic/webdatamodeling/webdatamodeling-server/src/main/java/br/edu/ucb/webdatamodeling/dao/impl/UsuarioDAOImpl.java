package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "UsuarioDAO")
public class UsuarioDAOImpl extends AbstractObjectDAO<Usuario> implements UsuarioDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<Usuario> persistence) {
		super.setPersistence(persistence);
	}
	
}
