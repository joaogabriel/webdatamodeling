package br.edu.ucb.webdatamodeling.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.dto.PastaDTO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Pasta;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.PastaService;
import br.edu.ucb.webdatamodeling.service.UsuarioService;

@Service(value = "PastaService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class PastaServiceImpl extends AbstractObjectService<Pasta, PastaDTO, PastaDAO> implements PastaService {

	private UsuarioService usuarioService;
	
	@Override
	public List<PastaDTO> getPastasByUsuarioAutenticado() {
		List<PastaDTO> pastas = null;
		UsuarioDTO usuarioPersistente = null;
		UsuarioDTO usuarioAutenticado = usuarioService.getUsuarioAutenticado();
		
		try {
			if (usuarioAutenticado != null) {
				usuarioPersistente = usuarioService.findById(usuarioAutenticado.getId());
				pastas = usuarioPersistente.getPastas();
				
				if (pastas != null && pastas.isEmpty()) {
					PastaDTO pastaDTO = new PastaDTO();
					pastaDTO.setNome("uepa");
					pastas.add(pastaDTO);
				}
			}
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
		return pastas;
	}

	@Resource(name = "UsuarioService")
	public void setUsuarioService(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}
	
}
