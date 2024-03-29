package br.edu.ucb.webdatamodeling.service;

import java.util.List;

import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.service.ObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;

public interface UsuarioService extends ObjectService<Usuario, UsuarioDTO, UsuarioDAO> {

	UsuarioDTO efetuarLogin(UsuarioDTO usuarioDTO) throws ServiceException;
	
	UsuarioDTO recuperarSenha(UsuarioDTO usuarioDTO) throws ServiceException;
	
	UsuarioDTO verificarUsuarioAutenticado() throws ServiceException;
	
	Boolean efetuarLogout() throws ServiceException;
	
	List<UsuarioDTO> findByNomeOuEmail(UsuarioDTO usuarioDTO) throws ServiceException;
	
	UsuarioDTO getUsuarioAutenticado() throws ServiceException;
	
	List<UsuarioDTO> getUsuariosPossivelCompartilhamento(MerDTO mer) throws ServiceException;
	
}
