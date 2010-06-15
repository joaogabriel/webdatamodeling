package br.edu.ucb.webdatamodeling.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import br.edu.ucb.webdatamodeling.dao.ArquivoDAO;
import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.dao.AbstractObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.PersistenceException;

@Repository(value = "MerDAO")
public class MerDAOImpl extends AbstractObjectDAO<Mer> implements MerDAO {

	private ArquivoDAO arquivoDAO;
	
	@Override
	public Mer insert(Mer entity) throws ObjectDAOException {
		entity.setArquivo(arquivoDAO.findById(entity.getArquivo().getId()));
		return super.insert(entity);
	}
	
	@Resource(name = "ArquivoDAO")
	public void setArquivoDAO(ArquivoDAO arquivoDAO) {
		this.arquivoDAO = arquivoDAO;
	}
	
	@Resource(name = "persistence")
	public void setPersistence(Persistence<Mer> persistence) {
		super.setPersistence(persistence);
	}

	@Override
	public Mer getMerByArquivo(Long idArquivo) throws ObjectDAOException {
		Mer mer = null;
		List<Mer> resultList = null;
		StringBuilder query = new StringBuilder();
		
		try {
			query.append("from ").append(getEntityClass().getName()).append(" mer");
			query.append(" where mer.arquivo.id = ").append(idArquivo);
			
			resultList = getPersistence().findByHQL(query.toString());
			
			if (resultList != null && resultList.size() == 1) {
				mer = resultList.get(0);
			}
		} catch (PersistenceException e) {
			throw new ObjectDAOException("Não foi possível recuperar o MER a partir do arquivo com identificador " + idArquivo, e);
		}
		
		return mer;
	}

	@Override
	public List<Mer> findMersByUsuarioCompartilhado(Long idUsuario) throws ObjectDAOException {
		List<Mer> resultList = null;
		StringBuilder query = new StringBuilder();
		
		try {
			query.append("select new Mer(mer)");
			query.append("from ").append(getEntityClass().getName()).append(" mer");
			query.append(" left outer join mer.usuarios usuario");//left outer join usuarios.usuario usuario
			query.append(" where usuario.id = ").append(idUsuario);
			
			resultList = getPersistence().findByHQL(query.toString());
		} catch (PersistenceException e) {
			throw new ObjectDAOException("Não foi possível recuperar MERs compartilhados com o usuário com identificador " + idUsuario, e);
		}
		
		return resultList;
	}
	
}
