package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.ArquivoDAO;
import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "ArquivoDAO")
public class ArquivoDAOImpl extends AbstractObjectDAO<Arquivo> implements ArquivoDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<Arquivo> persistence) {
		super.setPersistence(persistence);
	}
	
}
