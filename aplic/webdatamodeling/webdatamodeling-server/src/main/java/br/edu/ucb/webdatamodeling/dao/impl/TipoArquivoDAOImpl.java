package br.edu.ucb.webdatamodeling.dao.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.TipoArquivoDAO;
import br.edu.ucb.webdatamodeling.entity.TipoArquivo;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;

@Repository(value = "TipoArquivoDAO")
public class TipoArquivoDAOImpl extends AbstractObjectDAO<TipoArquivo> implements TipoArquivoDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence persistence) {
		super.setPersistence(persistence);
	}
	
}
