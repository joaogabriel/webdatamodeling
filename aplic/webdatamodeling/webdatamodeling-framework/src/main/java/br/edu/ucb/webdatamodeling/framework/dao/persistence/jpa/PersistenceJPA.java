package br.edu.ucb.webdatamodeling.framework.dao.persistence.jpa;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.edu.ucb.webdatamodeling.framework.dao.persistence.Persistence;
import br.edu.ucb.webdatamodeling.framework.dao.persistence.PersistenceException;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

/**
 * Classe que implementa a interface <code>Persistence</code> oferecendo suporte ao JPA.
 * 
 * @author joao.gabriel
 * 
 */
@Component("persistence")
@Qualifier("JPA")
public class PersistenceJPA<E extends Entity<?>> implements Persistence<E> {

	private EntityManager entityManager;
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public E insert(E entity) throws PersistenceException {
		if (entity != null) {
			try {
				getEntityManager().persist(entity);
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
	@Transactional(propagation=Propagation.REQUIRED)
	public E update(E entity) throws PersistenceException {
		if (entity != null) {
			try {
				verificarIdentificadorInformado(entity.getId());
				getEntityManager().merge(entity);
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
	@Transactional(propagation=Propagation.REQUIRED)
	public void remove(E entity) throws PersistenceException {
		if (entity != null) {
			try {
				verificarIdentificadorInformado(entity.getId());
				getEntityManager().remove(entity);
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
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly = true)
	public List<E> findAll(Class<E> entityClass) throws PersistenceException {
		List<E> entities = null;
		
		if (entityClass != null) {
			try {
				entities = getEntityManager().createQuery(new String("from " + entityClass.getCanonicalName())).getResultList();
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entities;
	}

	@Override
	@Transactional(readOnly = true)
	public E findByIdentifier(Class<E> entityClass, Serializable id) throws PersistenceException {
		E entity = null;
		
		if (id != null) {
			try {
				entity = getEntityManager().find(entityClass, id);
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entity;
	}

	@Override
	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<E> findByHQL(String query) throws PersistenceException {
		List<E> entities = null;
		
		if (query != null && !query.isEmpty()) {
			try {
				entities = getEntityManager().createQuery(query).getResultList();
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entities;
	}
	
	@Override
	@Transactional(readOnly = true)
	@SuppressWarnings("unchecked")
	public List<E> findByNativeQuery(String query, E resultEntity) throws PersistenceException {
		List<E> entities = null;
		
		if (query != null && !query.isEmpty() && resultEntity != null) {
			try {
				entities = getEntityManager().createNativeQuery(query, resultEntity.getClass()).getResultList();
			} catch (Exception ex) {
				throw new PersistenceException(ex);
			}
		}
		
		return entities;
	}

	public EntityManager getEntityManager() {
		return entityManager;
	}
	
	@PersistenceContext
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}
	
	@Override
	public void closeTransaction() {
		//this.entityManager.close();
	}
	
	private void verificarIdentificadorInformado(Serializable id) throws PersistenceException {
		if (id == null) {
			throw new PersistenceException("A entidade não possui identificador.");
		}
	}

}
