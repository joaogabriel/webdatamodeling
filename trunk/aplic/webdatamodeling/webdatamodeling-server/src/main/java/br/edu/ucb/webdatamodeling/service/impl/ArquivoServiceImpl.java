package br.edu.ucb.webdatamodeling.service.impl;

import java.io.BufferedWriter;
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
		return super.update(dto);
	}
	
	@Resource(name = "ArquivoDAO")
	public void setDao(ArquivoDAO dao) {
		super.setDao(dao);
	}

	@Override
	public byte[] gerarArquivoParaExportacao(String nomeArquivo, String tipoArquivo, String script) {
		byte[] data = null;
		String caminhoArquivo = createNomeArquivo(nomeArquivo, tipoArquivo);
		FileInputStream fileInputStream = null;
		FileChannel fileChannel = null;
		ByteBuffer byteBuffer = null;
		
        try {
        	createArquivo(caminhoArquivo, tipoArquivo);
        	
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
		// remover arquivo
	}

	private String createNomeArquivo(String nomeArquivo, String tipoArquivo) {
		StringBuilder nome= new StringBuilder();
		
		nome.append(System.getProperty("java.io.tmpdir"));
		nome.append(nomeArquivo);
		nome.append(".");
		nome.append(tipoArquivo);
		
		return nome.toString();
	}
	
}
