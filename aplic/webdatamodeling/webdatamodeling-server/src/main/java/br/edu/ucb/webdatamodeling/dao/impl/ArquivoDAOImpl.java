package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.ArquivoDAO;
import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "ArquivoDAO")
public class ArquivoDAOImpl extends AbstractObjectDAO<Arquivo> implements ArquivoDAO {

	private PastaDAO pastaDAO;
	
	@Override
	public Arquivo insert(Arquivo entity) throws ObjectDAOException {
		if (entity.getPasta() != null && entity.getPasta().getId() != null) {
			entity.setPasta(pastaDAO.findById(entity.getPasta().getId()));
		}
		return super.insert(entity);
	}
	
	@Override
	public void remove(Arquivo entity) throws ObjectDAOException {
		entity = findById(entity.getId());
		super.remove(entity);
	}
	
	@Resource(name = "PastaDAO")
	public void setPastaDAO(PastaDAO pastaDAO) {
		this.pastaDAO = pastaDAO;
	}
	
	@Resource(name = "persistence")
	public void setPersistence(Persistence<Arquivo> persistence) {
		super.setPersistence(persistence);
	}
	
}
