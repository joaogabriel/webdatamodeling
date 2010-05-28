package br.edu.ucb.webdatamodeling.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.ArquivoDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.ArquivoService;
import br.edu.ucb.webdatamodeling.service.UsuarioService;

@Service(value = "ArquivoService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class ArquivoServiceImpl extends AbstractObjectService<Arquivo, ArquivoDTO, ArquivoDAO> implements ArquivoService {

	private UsuarioService usuarioService;

	@Override
	public ArquivoDTO insert(ArquivoDTO dto) throws ServiceException {
		//UsuarioDTO usuarioAutenticado = usuarioService.getUsuarioAutenticado();
		
		dto.setDataCriacao(new Date());
		return super.insert(dto);
	}
	
	@Override
	public ArquivoDTO update(ArquivoDTO dto) throws ServiceException {
		dto.setDataUltimaAlteracao(new Date());
		return super.update(dto);
	}
	
	@Resource(name = "UsuarioService")
	public void setUsuarioService(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}
	
	@Resource(name = "ArquivoDAO")
	public void setDao(ArquivoDAO dao) {
		super.setDao(dao);
	}
	
}
