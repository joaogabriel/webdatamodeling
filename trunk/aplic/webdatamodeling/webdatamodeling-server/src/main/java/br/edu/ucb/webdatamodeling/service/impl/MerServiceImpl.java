package br.edu.ucb.webdatamodeling.service.impl;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.MerDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.CampoDTO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
import br.edu.ucb.webdatamodeling.dto.TipoCampoDTO;
import br.edu.ucb.webdatamodeling.entity.Mer;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.MerService;

@Service(value = "MerService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class MerServiceImpl extends AbstractObjectService<Mer, MerDTO, MerDAO> implements MerService {

	@Override
	public MerDTO insert(MerDTO dto) throws ServiceException {
		setTabelaNosCampos(dto);
		return super.insert(dto);
	}

	private void setTabelaNosCampos(MerDTO dto) {
		if (dto != null) {
			for (TabelaDTO tabelaDTO : dto.getTabelas()) {
				tabelaDTO.setMer(dto);
				for (CampoDTO campoDTO : tabelaDTO.getCampos()) {
					campoDTO.setTabela(tabelaDTO);
				}
			}
		}
	}
	
	@Override
	public MerDTO getMerByArquivo(ArquivoDTO arquivoDTO) {
		Mer mer = null;
		MerDTO merDTO = null;
		
		try {
			mer = getObjectDAO().getMerByArquivo(arquivoDTO.getId());
			
			if (mer != null) {
				merDTO = parseDTO(mer);
				
				// XXX thundercat
				// TODO remover!!!
				for (TabelaDTO tabela : merDTO.getTabelas()) {
					for (CampoDTO campo : tabela.getCampos()) {
						TipoCampoDTO tipoCampoDTO = new TipoCampoDTO();
						tipoCampoDTO.setDescricao("INTEGER");
						campo.setTipo(tipoCampoDTO);
					}
				}
			}
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
		return merDTO;
	}
	
	@Override
	@Resource(name = "MerDAO")
	public void setDao(MerDAO dao) {
		super.setDao(dao);
	}
	
}
