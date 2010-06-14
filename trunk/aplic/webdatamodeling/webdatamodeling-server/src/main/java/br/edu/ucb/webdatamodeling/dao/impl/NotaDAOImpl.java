package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.NotaDAO;
import br.edu.ucb.webdatamodeling.entity.Nota;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "NotaDAO")
public class NotaDAOImpl extends AbstractObjectDAO<Nota> implements NotaDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<Nota> persistence) {
		super.setPersistence(persistence);
	}
	
}
