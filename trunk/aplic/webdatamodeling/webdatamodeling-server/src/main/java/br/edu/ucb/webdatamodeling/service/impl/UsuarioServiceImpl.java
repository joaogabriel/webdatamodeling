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
import br.edu.ucb.webdatamodeling.mail.service.impl.MailServiceImpl;
import br.edu.ucb.webdatamodeling.service.UsuarioService;
import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

@Service(value = "UsuarioService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class UsuarioServiceImpl extends AbstractObjectService<Usuario, UsuarioDTO, UsuarioDAO> implements UsuarioService {

	private static final String USUARIO_SESSAO = "USUARIO_SESSAO";
	private MailServiceImpl mailService;
	private FlexSession flexSession;
	
	@Override
	public UsuarioDTO insert(UsuarioDTO dto) throws ServiceException {
		dto.setDataCadastro(new Date());
		return super.insert(dto);
	}

	@Override
	public UsuarioDTO efetuarLogin(UsuarioDTO usuarioDTO) throws ServiceException {
		Usuario usuario = null;
		
		try {
			usuario = parseEntity(usuarioDTO);
			usuario = getObjectDAO().findByEmailESenha(usuario);
			if (usuario != null) {
				usuarioDTO = parseDTO(usuario);
				getFlexSession().setAttribute(USUARIO_SESSAO, usuarioDTO);
			} else {
				usuarioDTO = null;
			}
		} catch (ObjectDAOException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a autenticação.");
		} catch (ServiceException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a autenticação.");
		}
		
		return usuarioDTO;
	}
	
	@Override
	public UsuarioDTO recuperarSenha(UsuarioDTO usuarioDTO) throws ServiceException {
		Usuario usuario = null;
		
		try {
			usuario = parseEntity(usuarioDTO);
			usuario = getObjectDAO().findByEmail(usuario);
			if (usuario != null) {
				mailService.send(usuario);
				usuarioDTO = parseDTO(usuario);
			} else {
				usuarioDTO = null;
			}
		} catch (MailException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante o envio do e-mail.");
		} catch (ServiceException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a recuperação da senha.");
		} catch (ObjectDAOException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a recuperação da senha.");
		}
		
		return usuarioDTO;
	}
	
	@Resource(name = "MailService")
	public void setMailService(MailServiceImpl mailService) {
		this.mailService = mailService;
	}
	
	public FlexSession getFlexSession() {
		if (flexSession == null) {
			flexSession = FlexContext.getFlexSession();
		}
		return flexSession;
	}

	public void setFlexSession(FlexSession flexSession) {
		this.flexSession = flexSession;
	}

	@Override
	@Resource(name = "UsuarioDAO")
	public void setDao(UsuarioDAO dao) {
		super.setDao(dao);
	}

	@Override
	public Boolean efetuarLogout() {
		getFlexSession().setAttribute(USUARIO_SESSAO, null);
		
		return true;
	}

	@Override
	public UsuarioDTO verificarUsuarioAutenticado() {
		if (getFlexSession().getAttribute(USUARIO_SESSAO) != null) {
			return (UsuarioDTO) getFlexSession().getAttribute(USUARIO_SESSAO);
		}
		return null;
	}

}
