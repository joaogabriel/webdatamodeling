package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.CampoDAO;
import br.edu.ucb.webdatamodeling.entity.Campo;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "CampoDAO")
public class CampoDAOImpl extends AbstractObjectDAO<Campo> implements CampoDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<Campo> persistence) {
		super.setPersistence(persistence);
	}
	
}
