package br.edu.ucb.webdatamodeling.framework.dao.persistence.jpa;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.PersistenceException;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

@Component("persistence")
@Qualifier("JPA")
public class PersistenceJPA<E extends Entity<?>> implements Persistence<E> {

	private EntityManager entityManager;
	
	@Override
	public E insert(E entity) throws PersistenceException {
		if (entity != null) {
			try {
				entityManager.persist(entity);
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		return entity;
	}

	@Override
	public List<E> insertAll(List<E> entities) throws PersistenceException {
		if (entities != null && !entities.isEmpty()) {
			for (E entity : entities) {
				this.insert(entity);
			}
		}
		return entities;
	}
	
	@Override
	public E update(E entity) throws PersistenceException {
		if (entity != null) {
			try {
				verificarIdentificadorInformado(entity.getId());
				entityManager.merge(entity);
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		return entity;
	}

	@Override
	public List<E> updateAll(List<E> entities) throws PersistenceException {
		if (entities != null && !entities.isEmpty()) {
			for (E entity : entities) {
				this.update(entity);
			}
		}
		return entities;
	}
	
	@Override
	public void remove(E entity) throws PersistenceException {
		if (entity != null) {
			try {
				verificarIdentificadorInformado(entity.getId());
				entityManager.remove(entity);
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
	}

	@Override
	public void removeAll(List<E> entities) throws PersistenceException {
		if (entities != null && !entities.isEmpty()) {
			for (E entity : entities) {
				this.remove(entity);
			}
		}
	}
	
	@Override
	public List<E> findAll(Class<E> entityClass) throws PersistenceException {
		List<E> entities = null;
		
		if (entityClass != null) {
			try {
				entityManager.createQuery(new String("from " + entityClass.getCanonicalName()));
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entities;
	}

	@Override
	public E findByIdentifier(Class<E> entityClass, Serializable id) throws PersistenceException {
		E entity = null;
		
		if (id != null) {
			try {
				entity = entityManager.find(entityClass, id);
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entity;
	}

	@Override
	public List<E> findByHQL(String query) throws PersistenceException {
		List<E> entities = null;
		
		if (query != null && !query.isEmpty()) {
			try {
				entityManager.createQuery(query);
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entities;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<E> findByNativeQuery(String query, E resultEntity) throws PersistenceException {
		List<E> entities = null;
		
		if (query != null && !query.isEmpty() && resultEntity != null) {
			try {
				entities = entityManager.createNativeQuery(query, resultEntity.getClass()).getResultList();
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entities;
	}

	@PersistenceContext
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}
	
	@Override
	public void closeTransaction() {
		this.entityManager.close();
	}
	
	private void verificarIdentificadorInformado(Serializable id) throws PersistenceException {
		if (id == null) {
			throw new PersistenceException("A entidade não possui identificador.");
		}
	}

}
