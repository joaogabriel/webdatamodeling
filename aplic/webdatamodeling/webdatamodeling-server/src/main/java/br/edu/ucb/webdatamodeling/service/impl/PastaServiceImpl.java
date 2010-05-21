package br.edu.ucb.webdatamodeling.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.PastaDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
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
					getEstruturaHardCode(pastas);
				}
			}
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
		return pastas;
	}

	private void getEstruturaHardCode(List<PastaDTO> pastas) {
		ArquivoDTO arquivo1 = new ArquivoDTO();
		arquivo1.setNome("Arquivo 1");
		
		ArquivoDTO arquivo2 = new ArquivoDTO();
		arquivo2.setNome("Arquivo 2");
		
		ArquivoDTO arquivo3 = new ArquivoDTO();
		arquivo3.setNome("Arquivo 3");
		
		ArquivoDTO arquivo4 = new ArquivoDTO();
		arquivo4.setNome("Arquivo 4");
		
		ArquivoDTO arquivo5 = new ArquivoDTO();
		arquivo5.setNome("Arquivo 5");
		
		PastaDTO pastaA = new PastaDTO();
		pastaA.setNome("Pasta A");
		
		PastaDTO pastaB = new PastaDTO();
		pastaB.setNome("Pasta B");
		
		pastaA.setArquivos(new ArrayList<ArquivoDTO>());
		pastaA.getArquivos().add(arquivo1);
		pastaA.getArquivos().add(arquivo2);
		pastaA.getArquivos().add(arquivo3);
		
		pastaB.setArquivos(new ArrayList<ArquivoDTO>());
		pastaB.getArquivos().add(arquivo4);
		pastaB.getArquivos().add(arquivo5);
		
		pastas.add(pastaA);
		pastas.add(pastaB);
	}

	@Resource(name = "UsuarioService")
	public void setUsuarioService(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}
	
}
