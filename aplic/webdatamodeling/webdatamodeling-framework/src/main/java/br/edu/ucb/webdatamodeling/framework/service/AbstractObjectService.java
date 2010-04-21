package br.edu.ucb.webdatamodeling.framework.service;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.dozer.Mapper;
import org.dozer.MappingException;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAO;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.dto.DTO;
import br.edu.ucb.webdatamodeling.framework.dto.DefaultDTO;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

/**
 * Classe abstrata que implementa todos os métodos da interface <code>ObjectService</code>
 */
public abstract class AbstractObjectService<E extends Entity<?>, T extends DTO<E>, D extends ObjectDAO<E>> implements ObjectService<E, T, D> {

	private D dao;
	private Mapper mapper;
	
	@Transactional(propagation=Propagation.REQUIRED)
	public T insert(T dto) throws ServiceException {
		E entity = null;
		
		try {
			entity = parseEntity(dto);
			entity.setId(null);
			getObjectDAO().insert(entity);
			dto = parseDTO(entity);
		} catch (ObjectDAOException e) {
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro ao inserir uma entidade no Banco de Dados.");
		}
		
		return dto;
	}

	@Override
	public List<T> insertAll(List<T> dtos) throws ServiceException {
		if (dtos != null && !dtos.isEmpty()) {
			for (T dto : dtos) {
				this.insert(dto);
			}
		}
		return dtos;
	}

	@Override
	@Transactional (propagation=Propagation.REQUIRED)
	public T update(T dto) throws ServiceException {
		E entity = null;
		
		try {
			entity = parseEntity(dto);
			getObjectDAO().update(entity);
			dto = parseDTO(entity);
		} catch (ObjectDAOException e) {
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro a atualizar no Banco de Dados a entidade com id: " + entity.getId());
		}
		
		return dto;
	}

	@Override
	public List<T> updateAll(List<T> dtos) throws ServiceException {
		if (dtos != null && !dtos.isEmpty()) {
			for (T dto : dtos) {
				this.update(dto);
			}
		}
		return dtos;
	}

	@Override
	@Transactional (propagation=Propagation.REQUIRED)
	public void remove(T dto) throws ServiceException {
		E entity = null;
		
		try {
			entity = parseEntity(dto);
			getObjectDAO().remove(entity);
		} catch (ObjectDAOException e) {
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro a remover no Banco de Dados a entidade com id: " + entity.getId());
		}
	}

	@Override
	public void removeAll(List<T> dtos) throws ServiceException {
		if (dtos != null && !dtos.isEmpty()) {
			for (T dto : dtos) {
				this.remove(dto);
			}
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public T findById(Serializable id) throws ServiceException {
		E entity = null;
		T dto = null;
			
		try {
			entity = getObjectDAO().findById(id);
			dto = parseDTO(entity);
		} catch (ObjectDAOException e) {
			dto = (T) new DefaultDTO();
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro a pesquisar no Banco de Dados uma entidade com id: " + id);
		}
		
		return dto;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<T> findByHQL(String query) throws ServiceException {
		List<E> entities = null;
		List<T> dtos = Collections.EMPTY_LIST;
		
		try {
			entities = getObjectDAO().findByHQL(query);
			dtos = parseDTOs(entities);
		} catch (ObjectDAOException e) {
			T dto = (T) new DefaultDTO();
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			dtos.add(dto);
			throw new ServiceException("Erro a pesquisar no Banco de Dados utilizando a query: " + query, e);
		}
		
		return dtos;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<T> findByNativeQuery(String query, T resultDTO) throws ServiceException {
		E entity = null;
		List<E> entities = null;
		List<T> dtos = null;
		
		try {
			entity = (E) resultDTO.getEntityClass().newInstance();
			entities = getObjectDAO().findByNativeQuery(query, entity);
			dtos = parseDTOs(entities);
		} catch (ObjectDAOException e) {
			throw new ServiceException("Erro a pesquisar no Banco de Dados utilizando a query: " + query, e);
		} catch (InstantiationException e) {
			throw new ServiceException("Erro a pesquisar no Banco de Dados utilizando a query: " + query, e);
		} catch (IllegalAccessException e) {
			throw new ServiceException("Erro a pesquisar no Banco de Dados utilizando a query: " + query, e);
		}
		
		return dtos;
	}

	@Override
	public List<T> findAll() throws ServiceException {
		List<E> entities = null;
		List<T> dtos = null;
		
		try {
			entities = getObjectDAO().findAll();
			
			if (entities != null && !entities.isEmpty()) {
				dtos = new ArrayList<T>();
				
				for (E entity : entities) {
					dtos.add(parseDTO(entity));
				}
			}
		} catch (ObjectDAOException e) {
			throw new ServiceException("Erro a pesquisar no Banco de Dados todas as entidades do tipo: " + getEntityClass(), e);
		}
		
		return dtos;
	}
	
	protected D getObjectDAO() throws ServiceException {
		if (!(getDao() instanceof ObjectDAO)) {
			throw new ServiceException("A DAO informada não é uma instância de " + ObjectDAO.class);
		}
		return (D) getDao();
	}

	@Override
	@SuppressWarnings("unchecked")
	public E parseEntity(T dto) throws ServiceException {
		E entity = null;
		
		try {
			entity = (E) getMapper().map(dto, getEntityClass());
		} catch (MappingException e) {
			throw new ServiceException("Ocorreu um erro ao transferir informações entre objetos.", e);
		}
		
		return entity; 
	}
	
	@Override
	public List<E> parseEntities(List<T> dtos) throws ServiceException {
		List<E> entities = null;
		
		if (dtos != null && !dtos.isEmpty()) {
			entities = new ArrayList<E>();
			
			for (T dto : dtos) {
				entities.add(parseEntity(dto));
			}
		}
		
		return entities;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public T parseDTO(E entity) throws ServiceException {
		T dto = null;
		
		try {
			dto = (T) getMapper().map(entity, getDTOClass());
		} catch (MappingException me) {
			throw new ServiceException("Ocorreu um erro ao transferir informações entre objetos.");
		}
		
		return dto; 
	}
	
	@Override
	public List<T> parseDTOs(List<E> entities) throws ServiceException {
		List<T> dtos = null;
		
		if (entities != null && !entities.isEmpty()) {
			dtos = new ArrayList<T>();
			
			for (E entity : entities) {
				dtos.add(parseDTO(entity));
			}
		}
		
		return dtos;
	}
	
	@SuppressWarnings("unchecked")
	protected Class<DTO> getEntityClass() {
		return (Class<DTO>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
	@SuppressWarnings("unchecked")
	protected Class<DTO> getDTOClass() {
		return (Class<DTO>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[1];
	}
	
	public D getDao() {
		return dao;
	}

	public void setDao(D dao) {
		this.dao = dao;
	}
	
	public Mapper getMapper() {
		return mapper;
	}

	@Resource(name = "mapper")
	public void setMapper(Mapper mapper) {
		this.mapper = mapper;
	}
	
}
