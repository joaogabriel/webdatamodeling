package br.edu.ucb.webdatamodeling.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.mail.MailException;
import br.edu.ucb.webdatamodeling.mail.SendMail;
import br.edu.ucb.webdatamodeling.service.UsuarioService;

@Service(value = "UsuarioService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class UsuarioServiceImpl extends AbstractObjectService<Usuario, UsuarioDTO, UsuarioDAO> implements UsuarioService {

	@Override
	public UsuarioDTO insert(UsuarioDTO dto) throws ServiceException {
		dto.setDataCadastro(new Date());
		return super.insert(dto);
	}

	@Override
	public UsuarioDTO validarLogin(UsuarioDTO usuarioDTO) throws ServiceException {
		Usuario usuario = null;
		
		try {
			usuario = parseEntity(usuarioDTO);
			usuario = getObjectDAO().findByEmailESenha(usuario);
			if (usuario != null) {
				usuarioDTO = parseDTO(usuario);
			} else {
				usuarioDTO = null;
			}
		} catch (ObjectDAOException e) {
			e.printStackTrace();
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
		return usuarioDTO;
	}
	
	@Override
	public UsuarioDTO recuperarSenha(UsuarioDTO usuarioDTO) throws ServiceException {
		Usuario usuario = null;
		SendMail sendEmail = new SendMail();
		try {
			usuario = parseEntity(usuarioDTO);
			sendEmail.send(usuario);
		} catch (MailException e) {
			e.printStackTrace();
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	@Resource(name = "UsuarioDAO")
	public void setDao(UsuarioDAO dao) {
		super.setDao(dao);
	}

}
