package br.edu.ucb.webdatamodeling.framework.dao;

import java.io.Serializable;
import java.util.List;

import br.edu.ucb.webdatamodeling.framework.entity.Entity;

/**
 * Interface que define os principais 
 * @author Gabriel
 *
 * @param <E>
 */
public interface ObjectDAO<E extends Entity<?>> extends DAO {

	E insert(E entity) throws ObjectDAOException;
	
	List<E> insertAll(List<E> entities) throws ObjectDAOException;
	
	E update(E entity) throws ObjectDAOException;
	
	List<E> updateAll(List<E> entities) throws ObjectDAOException;
	
	void remove(E entity) throws ObjectDAOException;
	
	void removeAll(List<E> entities) throws ObjectDAOException;
	
	E findById(Serializable id) throws ObjectDAOException;
	
	List<E> findByHQL(String query) throws ObjectDAOException;
	
	List<E> findByNativeQuery(String query, E resultEntity) throws ObjectDAOException;
	
	List<E> findAll() throws ObjectDAOException;
	
}
