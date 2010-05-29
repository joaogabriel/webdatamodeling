package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.MerService;
import br.edu.ucb.webdatamodeling.service.UsuarioService;

@Service(value = "MerService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class MerServiceImpl extends AbstractObjectService<Mer, MerDTO, MerDAO> implements MerService {

	private UsuarioService usuarioService;
	
	@Override
	public MerDTO insert(MerDTO dto) throws ServiceException {
		if (dto != null) {
			for (TabelaDTO tabelaDTO : dto.getTabelas()) {
				tabelaDTO.setMer(dto);
			}
		}
		return super.insert(dto);
	}
	
	@Override
	@Resource(name = "MerDAO")
	public void setDao(MerDAO dao) {
		super.setDao(dao);
	}

	@Resource(name = "UsuarioService")
	public void setUsuarioService(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}
	
	@Override
	public MerDTO getMerByArquivo(ArquivoDTO arquivoDTO) {
		UsuarioDTO usuarioAutenticado = usuarioService.getUsuarioAutenticado();
		try {
			Mer mer = getObjectDAO().getMerByArquivo(arquivoDTO.getId());
			if (mer != null) {
				return parseDTO(mer);
			}
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
