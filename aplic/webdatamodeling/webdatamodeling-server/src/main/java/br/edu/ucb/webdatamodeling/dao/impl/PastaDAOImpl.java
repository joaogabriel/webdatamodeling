package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.entity.Pasta;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "PastaDAO")
public class PastaDAOImpl extends AbstractObjectDAO<Pasta> implements PastaDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence persistence) {
		super.setPersistence(persistence);
	}
	
}
