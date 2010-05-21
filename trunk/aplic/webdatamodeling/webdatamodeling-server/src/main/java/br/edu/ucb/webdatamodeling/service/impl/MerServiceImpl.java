package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.CampoDTO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.MerService;

@Service(value = "MerService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class MerServiceImpl extends AbstractObjectService<Mer, MerDTO, MerDAO> implements MerService {

	@Override
	public MerDTO insert(MerDTO dto) throws ServiceException {
		for (TabelaDTO tabelaDTO : dto.getTabelas()) {
			for (CampoDTO campoDTO : tabelaDTO.getCampos()) {
				if (campoDTO.getDescricao().length() > 9) {
					campoDTO.setDescricao("krai");
				}
			}
		}
		dto.setArquivo(new ArquivoDTO());
		return super.insert(dto);
	}
	
	@Override
	@Resource(name = "MerDAO")
	public void setDao(MerDAO dao) {
		super.setDao(dao);
	}
	
}
