package br.edu.ucb.webdatamodeling.framework.dao.persistence;

import java.io.Serializable;
import java.util.List;

import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public interface Persistence<E extends Entity<?>> {

	E insert(E entity) throws PersistenceException;
	
	List<E> insertAll(List<E> entities) throws PersistenceException;
	
	E update(E entity) throws PersistenceException;
	
	List<E> updateAll(List<E> entities) throws PersistenceException;
	
	void remove(E entity) throws PersistenceException;
	
	void removeAll(List<E> entities) throws PersistenceException;
	
	E findByIdentifier(Class<E> entityClass, Serializable id) throws PersistenceException;
	
	List<E> findByHQL(String query) throws PersistenceException;
	
	List<E> findByNativeQuery(String query, E resultEntity) throws PersistenceException;
	
	List<E> findAll(Class<E> entityClass) throws PersistenceException;
	
	void closeTransaction() throws PersistenceException;
	
}
