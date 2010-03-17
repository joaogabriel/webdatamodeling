package br.edu.ucb.webdatamodeling.framework.service;

import java.io.Serializable;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public abstract class AbstractObjectService<E extends Entity<?>, D extends ObjectDAO<E>> implements ObjectService<E, D> {

	private D dao;
	
	@Override
	@Transactional (propagation=Propagation.REQUIRED)
	public E insert(E entity) throws Exception {
		try {
			getObjectDAO().insert(entity);
		} catch (ObjectDAOException e) {
			throw new ServiceException("Erro");
		}
		return entity;
	}

	@Override
	public List<E> insertAll(List<E> entities) throws Exception {
		return null;
	}

	@Override
	@Transactional (propagation=Propagation.REQUIRED)
	public E update(E entity) throws Exception {
		try {
			dao.update(entity);
		} catch (ObjectDAOException e) {
			throw new ServiceException("Erro");
		}
		return entity;
	}

	@Override
	public List<E> updateAll(List<E> entities) throws Exception {
		return null;
	}

	@Override
	@Transactional (propagation=Propagation.REQUIRED)
	public void remove(E entity) throws Exception {
		
	}

	@Override
	public void removeAll(List<E> entities) throws Exception {
		
	}

	@Override
	public E findById(Serializable id) throws Exception {
		return null;
	}

	@Override
	public List<E> findByHQL(String query) throws Exception {
		return null;
	}

	@Override
	public List<E> findByNativeQuery(String query, E resultEntity) throws Exception {
		return null;
	}

	@Override
	public List<E> findAll() throws Exception {
		return null;
	}
	
	public D getDao() {
		return dao;
	}

	public void setDao(D dao) {
		this.dao = dao;
	}
	
	protected D getObjectDAO() throws ServiceException {
		if (!(this.dao instanceof ObjectDAO)) {
			throw new ServiceException("A DAO informada não é uma instância de " + ObjectDAO.class);
		}
		return (D) this.dao;
	}
	
}
