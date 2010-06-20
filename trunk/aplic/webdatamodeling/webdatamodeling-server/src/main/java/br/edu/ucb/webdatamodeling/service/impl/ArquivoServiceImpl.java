package br.edu.ucb.webdatamodeling.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.dao.ArquivoDAO;
import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
import br.edu.ucb.webdatamodeling.dto.CampoDTO;
import br.edu.ucb.webdatamodeling.dto.MerDTO;
import br.edu.ucb.webdatamodeling.dto.NotaDTO;
import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
import br.edu.ucb.webdatamodeling.entity.Arquivo;
import br.edu.ucb.webdatamodeling.framework.service.AbstractObjectService;
import br.edu.ucb.webdatamodeling.framework.service.ServiceException;
import br.edu.ucb.webdatamodeling.service.ArquivoService;

@Service(value = "ArquivoService")
@RemotingDestination(channels = {"webdatamodeling-amf"})
public class ArquivoServiceImpl extends AbstractObjectService<Arquivo, ArquivoDTO, ArquivoDAO> implements ArquivoService {

	@Override
	public ArquivoDTO insert(ArquivoDTO dto) throws ServiceException {
		dto.setDataCriacao(new Date());
		return super.insert(dto);
	}
	
	@Override
	public ArquivoDTO update(ArquivoDTO dto) throws ServiceException {
		dto.setDataUltimaAlteracao(new Date());
		setTabelaNosCampos(dto.getMer());
		
		for (NotaDTO notaDTO : dto.getMer().getNotas()) {
			notaDTO.setMer(dto.getMer());
		}
		
		return super.update(dto);
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
	public byte[] gerarArquivoParaExportacao(String nomeArquivo, String script) {
		byte[] data = null;
		String caminhoArquivo = createNomeArquivo(nomeArquivo);
		FileInputStream fileInputStream = null;
		FileChannel fileChannel = null;
		ByteBuffer byteBuffer = null;
		
        try {
        	createArquivo(caminhoArquivo, script);
        	
            fileInputStream = new FileInputStream(caminhoArquivo);
            fileChannel = fileInputStream.getChannel();
            data = new byte[(int) (fileChannel.size())];
            byteBuffer = ByteBuffer.wrap(data);
            fileChannel.read(byteBuffer);
            
            removeArquivo(caminhoArquivo);
        } catch (Exception e) {
            
        }
        
		return data;
	}

	private void createArquivo(String pathArquivo, String script) throws IOException {
		BufferedWriter arquivo = new BufferedWriter(new FileWriter(pathArquivo));  
		arquivo.write(script);
		arquivo.close();
	}
	
	private void removeArquivo(String caminhoArquivo) {
		File arquivo = new File(caminhoArquivo);
		if (arquivo.exists()) {
			arquivo.delete();
		}
	}

	private String createNomeArquivo(String nomeArquivo) {
		StringBuilder nome= new StringBuilder();
		
		nome.append(System.getProperty("java.io.tmpdir"));
		nome.append(nomeArquivo);
		
		return nome.toString();
	}
	
	@Resource(name = "ArquivoDAO")
	public void setDao(ArquivoDAO dao) {
		super.setDao(dao);
	}
	
}
