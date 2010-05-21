package br.edu.ucb.webdatamodeling.framework.service;

import java.io.Serializable;
import java.util.List;

import br.edu.ucb.webdatamodeling.framework.dao.DAO;
import br.edu.ucb.webdatamodeling.framework.dto.DTO;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public interface ObjectService<E extends Entity<?>, T extends DTO<?, ?>, D extends DAO> extends Service {

	T insert(T dto) throws ServiceException;
	
	List<T> insertAll(List<T> dtos) throws ServiceException;
	
	T update(T dto) throws ServiceException;
	
	List<T> updateAll(List<T> dtos) throws ServiceException;
	
	void remove(T dto) throws ServiceException;
	
	void removeAll(List<T> dtos) throws ServiceException;
	
	T findById(Serializable id) throws ServiceException;
	
	List<T> findByHQL(String query) throws ServiceException;
	
	List<T> findByNativeQuery(String query, T resultDTO) throws ServiceException;
	
	List<T> findAll() throws ServiceException;
	
	E parseEntity(T dto) throws ServiceException;
	
	List<E> parseEntities(List<T> dtos) throws ServiceException;
		
	T parseDTO(E entity) throws ServiceException;;
	
	List<T> parseDTOs(List<E> entities) throws ServiceException;
	
}
