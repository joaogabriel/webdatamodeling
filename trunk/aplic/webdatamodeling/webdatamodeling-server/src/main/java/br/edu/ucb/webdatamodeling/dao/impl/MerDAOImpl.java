package br.edu.ucb.webdatamodeling.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.PersistenceException;

@Repository(value = "MerDAO")
public class MerDAOImpl extends AbstractObjectDAO<Mer> implements MerDAO {

	@Resource(name = "persistence")
	public void setPersistence(Persistence<Mer> persistence) {
		super.setPersistence(persistence);
	}

	@Override
	public Mer getMerByArquivo(Long idArquivo) {
		StringBuilder query = new StringBuilder();
		query.append("from ").append(getEntityClass().getName()).append(" mer");
		query.append(" where mer.arquivo.id = ").append(idArquivo);
		
		try {
			List<Mer> resultList = getPersistence().findByHQL(query.toString());
			if (resultList != null && resultList.size() == 1) {
				return resultList.get(0);
			}
		} catch (PersistenceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
}
