package br.edu.ucb.webdatamodeling.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.criptografia.service.CriptografiaService;
import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.PastaDTO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.dao.ObjectDAOException;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.mail.MailException;
import br.edu.ucb.webdatamodeling.mail.service.impl.MailServiceImpl;
import br.edu.ucb.webdatamodeling.service.MerService;
import br.edu.ucb.webdatamodeling.service.UsuarioService;
import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

@Service(value = "UsuarioService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class UsuarioServiceImpl extends AbstractObjectService<Usuario, UsuarioDTO, UsuarioDAO> implements UsuarioService {

	private static final String USUARIO_SESSAO = "USUARIO_SESSAO";
	
	private MailServiceImpl mailService;
	private CriptografiaService criptografiaService;
	private MerService merService;
	
	private FlexSession flexSession;
	
	@Override
	public UsuarioDTO insert(UsuarioDTO dto) throws ServiceException {
		String senhaCriptografada = null;
		
		//verifica se o usuário informou a senha 
		if (dto.getSenha() == null || dto.getSenha().isEmpty()) {
			throw new ServiceException("A senha é obrigatória.");
		}
		
		// armazena a data atual na data de cadastro
		dto.setDataCadastro(new Date());
		
		// valida se o e-mail ja esta cadastrado
		verificarEmailCadastrado(dto);
		
		// criptografa a senha
		senhaCriptografada = criptografiaService.criptografarSenha(dto.getSenha());
		
		// armazena a senha criptografada
		dto.setSenha(senhaCriptografada);
		
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
			throw new ServiceException("Erro durante o acesso a Base de Dados.", e);
		} catch (ServiceException e) {
			dto.setErro(Boolean.TRUE);
			dto.setMensagemErro(e.getMessage());
			throw new ServiceException("O e-mail já está cadastrado na Base de Dados.", e);
		}
	}

	@Override
	public UsuarioDTO efetuarLogin(UsuarioDTO usuarioDTO) throws ServiceException {
		Usuario usuario = null;
		String senhaCriptografada = null;
		List<PastaDTO> pastasCompartilhadas = null;
		
		try {
			usuario = parseEntity(usuarioDTO);
			senhaCriptografada = criptografiaService.criptografarSenha(usuarioDTO.getSenha());
			usuario.setSenha(senhaCriptografada);
			usuario = getObjectDAO().findByEmailESenha(usuario);
			
			if (usuario != null) {
				usuarioDTO = parseDTO(usuario);
				
				pastasCompartilhadas = verificarCompartilhamento(usuarioDTO);
				
				if (usuarioDTO.getPastas() == null) {
					usuarioDTO.setPastas(new ArrayList<PastaDTO>());
				}
				
				usuarioDTO.getPastas().addAll(pastasCompartilhadas);
				
				getFlexSession().setAttribute(USUARIO_SESSAO, usuarioDTO);
			} else {
				usuarioDTO = null;
			}
		} catch (ObjectDAOException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a autenticação.", e);
		} catch (ServiceException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a autenticação.", e);
		}
		
		return usuarioDTO;
	}
	
	@Override
	public UsuarioDTO recuperarSenha(UsuarioDTO usuarioDTO) throws ServiceException {
		Usuario usuario = null;
		String novaSenha = criptografiaService.gerarNovaSenha();
		String novaSenhaCriptografada = criptografiaService.criptografarSenha(novaSenha); 
		
		try {
			usuario = parseEntity(usuarioDTO);
			usuario = getObjectDAO().findByEmail(usuario);
			
			if (usuario != null) {
				usuario.setSenha(novaSenha);
				
				// envia e-mail com a nova senha
				mailService.send(usuario);
				usuarioDTO = parseDTO(usuario);
				
				usuario.setSenha(novaSenhaCriptografada);
				usuarioDTO = parseDTO(usuario);
				update(usuarioDTO);
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
	
	@Override
	public Boolean efetuarLogout() throws ServiceException {
		try {
			getFlexSession().setAttribute(USUARIO_SESSAO, null);
		} catch (Exception e) {
			throw new ServiceException("Erro durante o logout.", e);
		}
		return true;
	}

	@Override
	public List<PastaDTO> verificarCompartilhamento(UsuarioDTO usuarioDTO) throws ServiceException {
		PastaDTO pastaDTO = null;
		Long idUsuario = null;
		String nomeUsuario = null;
		List<PastaDTO> pastas = null;
		List<MerDTO> mersCompartilhados = null;
		Map<Long, PastaDTO> mapCompartilhamento = null;
		
		try {
			mersCompartilhados = merService.findMersByUsuarioCompartilhado(usuarioDTO);
			
			if (mersCompartilhados != null && !mersCompartilhados.isEmpty()) {
				mapCompartilhamento = new HashMap<Long, PastaDTO>();
				pastas = new ArrayList<PastaDTO>();
				
				for (MerDTO mer : mersCompartilhados) {
					idUsuario = mer.getArquivo().getPasta().getUsuario().getId();
					nomeUsuario = mer.getArquivo().getPasta().getUsuario().getNome();
					
					if (mapCompartilhamento.containsKey(nomeUsuario)) {
						mapCompartilhamento.get(nomeUsuario).getArquivos().add(mer.getArquivo());
					} else {
						pastaDTO = new PastaDTO();
						pastaDTO.setNome("MERs compartilhados por " + nomeUsuario);
						pastaDTO.setArquivos(new ArrayList<ArquivoDTO>());
						pastaDTO.getArquivos().add(mer.getArquivo());
						
						mapCompartilhamento.put(idUsuario, pastaDTO);
					}
				}
				
				pastas = (List<PastaDTO>) mapCompartilhamento.values();
			}
		} catch (ServiceException e) {
			throw new ServiceException("Erro ao verificar compartilhamentos.", e);
		}
		
		return pastas;
	}
	
	@Override
	public UsuarioDTO verificarUsuarioAutenticado() throws ServiceException {
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
			throw new ServiceException("Erro durante a execução da pesquisa.", e);
		} catch (ObjectDAOException e) {
			usuarioDTO.setErro(Boolean.TRUE);
			usuarioDTO.setMensagemErro(e.getMessage());
			throw new ServiceException("Erro durante a execução da pesquisa.", e);
		}
		
		return usuarios;
	}

	@Override
	public UsuarioDTO getUsuarioAutenticado() throws ServiceException {
		return (UsuarioDTO) getFlexSession().getAttribute(USUARIO_SESSAO);
	}
	
	@Resource(name = "MailService")
	public void setMailService(MailServiceImpl mailService) {
		this.mailService = mailService;
	}
	
	@Resource(name = "CriptografiaService")
	public void setCriptografiaService(CriptografiaService criptografiaService) {
		this.criptografiaService = criptografiaService;
	}
	
	public FlexSession getFlexSession() throws ServiceException {
		if (flexSession == null) {
			flexSession = FlexContext.getFlexSession();
			flexSession.setTimeoutPeriod(300000L); // 5 minutos
			return flexSession;
		} else if (flexSession.isValid()) {
			return flexSession;
		} else {
			throw new ServiceException("Sessão inválida.");
		}
	}

	public void setFlexSession(FlexSession flexSession) {
		this.flexSession = flexSession;
	}

	@Override
	@Resource(name = "UsuarioDAO")
	public void setDao(UsuarioDAO dao) {
		super.setDao(dao);
	}
	
	@Resource(name = "MerService")
	public void setMerService(MerService merService) {
		this.merService = merService;
	}

	@Override
	public List<UsuarioDTO> getUsuariosPossivelCompartilhamento() throws ServiceException {
		List<UsuarioDTO> resultList = findAll();
		UsuarioDTO usuarioAutenticado = getUsuarioAutenticado();
		
		for (UsuarioDTO usuario : new ArrayList<UsuarioDTO>(resultList)) {
			if (usuario.getId().equals(usuarioAutenticado.getId())) {
				resultList.remove(usuario);
			}
		}

		return resultList;
	}

}
