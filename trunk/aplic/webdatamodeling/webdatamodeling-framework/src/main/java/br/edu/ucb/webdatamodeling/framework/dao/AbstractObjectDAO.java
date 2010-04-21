package br.edu.ucb.webdatamodeling.framework.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.PersistenceException;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

/**
 * 
 * 
 * @author joao.gabriel
 *
 */
public abstract class AbstractObjectDAO<E extends Entity<?>> implements ObjectDAO<E> {

	private Persistence<E> persistence;
	
	@Override
	public E insert(E entity) throws ObjectDAOException {
		try {
			getPersistence().insert(entity);
		} catch (PersistenceException ex) {
			throw new ObjectDAOException("Ocorreu um erro ao inserir a entidade.", ex);
		}
		
		return entity;
	}

	@Override
	public List<E> insertAll(List<E> entities) throws ObjectDAOException {
		try {
			this.persistence.insertAll(entities);
		} catch (PersistenceException e) {
			throw new ObjectDAOException("Ocorreu um erro ao inserir todas as entidades.");
		}
		
		return entities;
	}
	
	@Override
	public E update(E entity) throws ObjectDAOException {
		try {
			this.persistence.update(entity);
		} catch (PersistenceException ex) {
			throw new ObjectDAOException("Ocorreu um erro ao atualizar a entidade.");
		}
		
		return entity;
	}

	@Override
	public List<E> updateAll(List<E> entities) throws ObjectDAOException {
		try {
			this.persistence.updateAll(entities);
		} catch (PersistenceException e) {
			throw new ObjectDAOException("Ocorreu um erro ao atualizar todas as entidades.");
		}
		
		return entities;
	}
	
	@Override
	public void remove(E entity) throws ObjectDAOException {
		try {
			this.persistence.remove(entity);
		} catch (PersistenceException ex) {
			throw new ObjectDAOException("Ocorreu um erro ao remover a entidade.");
		}
	}

	@Override
	public void removeAll(List<E> entities) throws ObjectDAOException {
		try {
			this.persistence.removeAll(entities);
		} catch (PersistenceException e) {
			throw new ObjectDAOException("Ocorreu um erro ao remover todas as entidades.");
		}
	}

	@Override
	public List<E> findByHQL(String query) throws ObjectDAOException {
		List<E> entities = null;
		
		try {
			entities = this.persistence.findByHQL(query);
		} catch (PersistenceException ex) {
			throw new ObjectDAOException("Ocorreu um erro ao atualizar a entidade.");
		}
		
		return entities;
	}

	@Override
	public E findById(Serializable id) throws ObjectDAOException {
		E entity = null;
		
		try {
			entity = (E) this.persistence.findByIdentifier((Class<E>) getEntityClass(), id);
		} catch (PersistenceException ex) {
			throw new ObjectDAOException("Ocorreu um erro ao atualizar a entidade.");
		}
		
		return entity;
	}

	@Override
	public List<E> findByNativeQuery(String query, E resultEntity) throws ObjectDAOException {
		List<E> entities = null;
		
		try {
			entities = this.persistence.findByNativeQuery(query, resultEntity);
		} catch (PersistenceException ex) {
			throw new ObjectDAOException("Ocorreu um erro ao atualizar a entidade.");
		}
		
		return entities;
	}
	
	@Override
	public List<E> findAll() throws ObjectDAOException {
		List<E> entities = null;
		
		try {
			entities = getPersistence().findAll((Class<E>) getEntityClass());
		} catch (PersistenceException ex) {
			throw new ObjectDAOException("Ocorreu um erro ao atualizar a entidade.");
		}
		
		return entities;
	}
	
	@SuppressWarnings("unchecked")
	protected Class<E> getEntityClass() {
		return (Class<E>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
	public Persistence<E> getPersistence() {
		return persistence;
	}
	
	public void setPersistence(Persistence<E> persistence) {
		this.persistence = persistence;
	}

}
