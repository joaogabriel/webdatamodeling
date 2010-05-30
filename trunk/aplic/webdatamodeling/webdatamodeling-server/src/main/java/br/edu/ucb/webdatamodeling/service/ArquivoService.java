package br.edu.ucb.webdatamodeling.service;

import br.edu.ucb.webdatamodeling.dao.ArquivoDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.framework.service.ObjectService;

public interface ArquivoService extends ObjectService<Arquivo, ArquivoDTO, ArquivoDAO> {

	byte[] gerarArquivoParaExportacao(String nomeArquivo, String script);
	
}
