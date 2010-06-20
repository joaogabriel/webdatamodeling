package br.edu.ucb.webdatamodeling.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.TipoCampoDAO;
import br.edu.ucb.webdatamodeling.dto.TipoCampoDTO;
import br.edu.ucb.webdatamodeling.entity.TipoCampo;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.TipoCampoService;

@RemotingDestination
@Service(value = "TipoCampoService")
public class TipoCampoServiceImpl extends AbstractObjectService<TipoCampo, TipoCampoDTO, TipoCampoDAO> implements TipoCampoService {

	@Resource(name = "TipoCampoDAO")
	public void setDao(TipoCampoDAO dao) {
		super.setDao(dao);
	}
	
	@Override
	public List<TipoCampoDTO> findAll() throws ServiceException {
		List<TipoCampoDTO> findAll = super.findAll();
		
		Collections.sort(findAll, new Comparator<TipoCampoDTO>() {
			@Override
			public int compare(TipoCampoDTO o1, TipoCampoDTO o2) {
				return o1.getDescricao().compareTo(o2.getDescricao());
			}
		});
		
		if (findAll != null && !findAll.isEmpty()) {
			for (TipoCampoDTO tipoCampo : new ArrayList<TipoCampoDTO>(findAll)) {
				if (tipoCampo.getDescricao().equals("INTEGER")) {
					findAll.remove(tipoCampo);
					findAll.add(0, tipoCampo);
				}
			}
		}
		
		return findAll;
	}
	
}
