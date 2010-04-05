package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.TipoCampoDAO;
import br.edu.ucb.webdatamodeling.entity.TipoCampo;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "TipoCampoDAO")
public class TipoCampoDAOImpl extends AbstractObjectDAO<TipoCampo> implements TipoCampoDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<TipoCampo> persistence) {
		super.setPersistence(persistence);
	}
	
}
