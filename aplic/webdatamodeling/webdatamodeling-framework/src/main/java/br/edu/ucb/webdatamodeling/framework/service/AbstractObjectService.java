package br.edu.ucb.webdatamodeling.framework.service;

import java.io.Serializable;
import java.util.List;

import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAO;
import br.edu.ucb.webdatamodeling.framework.entity.Entity;

public abstract class AbstractObjectService<E extends Entity<?>, D extends ObjectDAO<E>> implements ObjectService<E, D> {

	@Override
	//@Transactional (propagation=Propagation.REQUIRED)
	public E insert(E entity) throws Exception {
		
		return null;
	}

	@Override
	public List<E> insertAll(List<E> entities) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public E update(E entity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<E> updateAll(List<E> entities) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void remove(E entity) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeAll(List<E> entities) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public E findById(Serializable id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<E> findByHQL(String query) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<E> findByNativeQuery(String query, E resultEntity)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<E> findAll() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	protected D getEntityDAO() {
//		String[] beanNamesForType = getApplicationContext().getBeanNamesForType(GenericsUtil.getDeclaredTypeArgument(getClass(), 2));
//		
//		if (beanNamesForType == null || beanNamesForType.length == 0 || beanNamesForType.length > 1) {
//			throw new IllegalStateException("Não foi possível injetar a instância EntityService. Talvez ela não tenha sido definida ou exista 2 ou mais beans definidos para o mesmo tipo declarado.");
//		}
//		
//		return (SERVICE) getApplicationContext().getBean(beanNamesForType[0]);
		return null;
	}

}
