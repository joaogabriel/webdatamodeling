package br.edu.ucb.webdatamodeling.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.UsuarioService;

@Service(value = "UsuarioService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class UsuarioServiceImpl extends AbstractObjectService<Usuario, UsuarioDTO, UsuarioDAO> implements UsuarioService {

	public String getTeste() {
		return "integrou!!!";
	}

	@Override
	@Resource(name = "UsuarioDAO")
	public void setDao(UsuarioDAO dao) {
		super.setDao(dao);
	}

	@Override
	public UsuarioDTO insert(UsuarioDTO dto) throws ServiceException {
		List<UsuarioDTO> findAll = findAll();
		return super.insert(dto);
	}
}
