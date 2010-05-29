package br.edu.ucb.webdatamodeling.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.criptografia.service.CriptografiaService;
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
	private CriptografiaService criptografiaService;
	private FlexSession flexSession;
	
	@Override
	public UsuarioDTO insert(UsuarioDTO dto) throws ServiceException {
		String senhaCriptografada = null;
		
		// armazena a data atual na data de cadastro
		dto.setDataCadastro(new Date());
		
		// valida se o e-mail ja esta cadastrado
		verificarEmailCadastrado(dto);

		//verifica se o usuário informou a senha 
		if (dto.getSenha() == null || dto.getSenha().isEmpty()) {
			throw new ServiceException("A senha é obrigatória.");
		}
		
		// criptografa a senha
		senhaCriptografada = criptografiaService.criptografarSenha(dto.getSenha());
		
		// armazena a senha criptografada
		dto.setSenha(senhaCriptografada);
		
		dto.setId(null);
		
		return super.insert(dto);
	}

	private void verificarEmailCadastrado(UsuarioDTO dto) throws ServiceException {
		Usuario usuario = null;
		try {
			usuario = parseEntity(dto);
			usuario = getObjectDAO().findByEmail(usuario);
			
			if (usuario != null) {
				throw new ServiceException("O e-mail já está cadastrado na Base de Dados.");
			}
		} catch (ObjectDAOException e) {
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante o acesso a Base de Dados.");
		} catch (ServiceException e) {
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			throw new ServiceException("O e-mail já está cadastrado na Base de Dados.");
		}
		
	}

	@Override
	public UsuarioDTO efetuarLogin(UsuarioDTO usuarioDTO) throws ServiceException {
		Usuario usuario = null;
		String senhaCriptografada = null;
		
		try {
			usuario = parseEntity(usuarioDTO);
			senhaCriptografada = criptografiaService.criptografarSenha(usuarioDTO.getSenha());
			usuario.setSenha(senhaCriptografada);
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
		String novaSenha = criptografiaService.gerarNovaSenha();
		
		try {
			usuario = parseEntity(usuarioDTO);
			usuario = getObjectDAO().findByEmail(usuario);
			usuario.setSenha(novaSenha);
			update(parseDTO(usuario));
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
	
	@Resource(name = "CriptografiaService")
	public void setCriptografiaService(CriptografiaService criptografiaService) {
		this.criptografiaService = criptografiaService;
	}
	
	public FlexSession getFlexSession() {
		if (flexSession == null) {
			flexSession = FlexContext.getFlexSession();
			flexSession.setTimeoutPeriod(5000000000000L);
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

	@Override
	public List<UsuarioDTO> findByNomeOuEmail(UsuarioDTO usuarioDTO) throws ServiceException {
		List<Usuario> resultSearch = null;
		List<UsuarioDTO> usuarios = null;
		try {
			resultSearch = getObjectDAO().findByNomeOuEmail(parseEntity(usuarioDTO));
			usuarios = parseDTOs(resultSearch);
		} catch (ServiceException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a execução da pesquisa.");
		} catch (ObjectDAOException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a execução da pesquisa.");
		}
		
		return usuarios;
	}

	@Override
	public UsuarioDTO getUsuarioAutenticado() {
		return (UsuarioDTO) getFlexSession().getAttribute(USUARIO_SESSAO);
	}

}
