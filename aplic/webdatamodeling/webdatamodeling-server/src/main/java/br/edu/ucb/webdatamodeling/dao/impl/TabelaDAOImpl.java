package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.TabelaDAO;
import br.edu.ucb.webdatamodeling.entity.Tabela;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "TabelaDAO")
public class TabelaDAOImpl extends AbstractObjectDAO<Tabela> implements TabelaDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<Tabela> persistence) {
		super.setPersistence(persistence);
	}
	
}
