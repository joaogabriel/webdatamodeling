package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.TipoTabelaDAO;
import br.edu.ucb.webdatamodeling.entity.TipoTabela;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "TipoTabelaDAO")
public class TipoTabelaDAOImpl extends AbstractObjectDAO<TipoTabela> implements TipoTabelaDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence persistence) {
		super.setPersistence(persistence);
	}
	
}
