package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.entity.EntidadeTeste;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "EntidadeTesteDAO")
public class EntidadeTesteDAOImpl extends AbstractObjectDAO<EntidadeTeste> {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<EntidadeTeste> persistence) {
		super.setPersistence(persistence);
	}
	
}
