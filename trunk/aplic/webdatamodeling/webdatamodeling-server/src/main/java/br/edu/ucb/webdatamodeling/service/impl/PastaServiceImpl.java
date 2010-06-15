package br.edu.ucb.webdatamodeling.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.PastaDTO;
import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
import br.edu.ucb.webdatamodeling.entity.Pasta;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.MerService;
import br.edu.ucb.webdatamodeling.service.PastaService;
import br.edu.ucb.webdatamodeling.service.UsuarioService;

@Service(value = "PastaService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class PastaServiceImpl extends AbstractObjectService<Pasta, PastaDTO, PastaDAO> implements PastaService {

	private UsuarioService usuarioService;
	private MerService merService;
	
	@Override
	public PastaDTO insert(PastaDTO dto) throws ServiceException {
		UsuarioDTO usuarioAutenticado = usuarioService.getUsuarioAutenticado();
		dto.setUsuario(usuarioAutenticado);
		return super.insert(dto);
	}
	
	@Override
	public List<PastaDTO> getPastasByUsuarioAutenticado() throws ServiceException {
		List<PastaDTO> pastas = null;
		List<PastaDTO> pastasCompartilhadas = null;
		UsuarioDTO usuarioPersistente = null;
		UsuarioDTO usuarioAutenticado = usuarioService.getUsuarioAutenticado();
		
		try {
			if (usuarioAutenticado != null) {
				usuarioPersistente = usuarioService.findById(usuarioAutenticado.getId());
				pastas = usuarioPersistente.getPastas();
				
				pastasCompartilhadas = verificarCompartilhamento(usuarioPersistente);
				
				if (pastasCompartilhadas != null && !pastasCompartilhadas.isEmpty()) {
					if (pastas == null) {
						pastas = pastasCompartilhadas;
					} else {
						pastas.addAll(pastasCompartilhadas);
					}
				}
			}
		} catch (ServiceException e) {
			throw new ServiceException("Erro durante a pesquisa das pastas do usuário autenticado.");
		}
		
		return pastas;
	}

	//@Override
	private List<PastaDTO> verificarCompartilhamento(UsuarioDTO usuarioDTO) throws ServiceException {
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
				
				if (!mapCompartilhamento.values().isEmpty()) {
					for (Long key : mapCompartilhamento.keySet()) {
						pastas.add(mapCompartilhamento.get(key));
					}
				}
			}
		} catch (ServiceException e) {
			throw new ServiceException("Erro ao verificar compartilhamentos.", e);
		}
		
		return pastas;
	}

	@Resource(name = "UsuarioService")
	public void setUsuarioService(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}
	
	@Resource(name = "MerService")
	public void setMerService(MerService merService) {
		this.merService = merService;
	}
	
	@Resource(name = "PastaDAO")
	public void setDao(PastaDAO dao) {
		super.setDao(dao);
	}
	
}
