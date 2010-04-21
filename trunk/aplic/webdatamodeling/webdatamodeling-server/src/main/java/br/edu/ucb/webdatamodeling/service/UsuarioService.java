package br.edu.ucb.webdatamodeling.service;

import br.edu.ucb.webdatamodeling.dao.UsuarioDAO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.framework.service.ObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;

public interface UsuarioService extends ObjectService<Usuario, UsuarioDTO, UsuarioDAO> {

	UsuarioDTO validarLogin(UsuarioDTO usuarioDTO) throws ServiceException;
	
	UsuarioDTO recuperarSenha(UsuarioDTO usuarioDTO) throws ServiceException;
	
}
