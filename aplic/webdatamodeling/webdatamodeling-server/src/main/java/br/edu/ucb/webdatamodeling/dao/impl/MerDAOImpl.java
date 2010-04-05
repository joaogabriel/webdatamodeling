package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "MerDAO")
public class MerDAOImpl extends AbstractObjectDAO<Mer> implements MerDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<Mer> persistence) {
		super.setPersistence(persistence);
	}
	
}
