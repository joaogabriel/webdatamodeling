package br.edu.ucb.webdatamodeling.framework.service;

import java.io.Serializable;
import java.util.List;

import br.edu.ucb.webdatamodeling.framework.dao.DAO;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public interface ObjectService<E extends Entity<?>, D extends DAO> extends Service {

	E insert(E entity) throws Exception;
	
	List<E> insertAll(List<E> entities) throws Exception;
	
	E update(E entity) throws Exception;
	
	List<E> updateAll(List<E> entities) throws Exception;
	
	void remove(E entity) throws Exception;
	
	void removeAll(List<E> entities) throws Exception;
	
	E findById(Serializable id) throws Exception;
	
	List<E> findByHQL(String query) throws Exception;
	
	List<E> findByNativeQuery(String query, E resultEntity) throws Exception;
	
	List<E> findAll() throws Exception;
	
}
