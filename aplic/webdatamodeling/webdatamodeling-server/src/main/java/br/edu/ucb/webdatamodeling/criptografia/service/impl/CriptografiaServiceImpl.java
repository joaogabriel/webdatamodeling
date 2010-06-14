package br.edu.ucb.webdatamodeling.criptografia.service.impl;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.springframework.stereotype.Service;

import sun.misc.BASE64Encoder;
import br.edu.ucb.webdatamodeling.criptografia.service.CriptografiaService;

/**
 * <p>Essa classe centraliza todo o mecanismo de criptografia de senhas do sistema.</p>
 * 
 * <p>A criptografia das senhas está implementada da seguinte forma:</p>
 * 
 * <p>1. A senha é criptografada inicialmente com o algorítmo SHA1;<br/>
 * 2. A senha criptografada recebe um prefixo e um sufixo;<br/>
 * 3. Essa nova composição é criptografada com o algorítmo MD5.</p>
 * 
 * <p>Dessa forma, mesmo com os hashes de senhas criptografas usando o algorítmo MD5 encontradas facilmente na Web,
 * principalmente se a senha for considerada como "fraca", torna-se praticamente impossível recuperar a senha original do usuário,
 * pois a senha é criptografada com dois algotítmos diferentes, além de receber novas composições no início e fim (prefixo e sufixo).</p>
 * 
 * <p>Se o usuário solicitar a recuperação de senha, a classe implementa o método <code>{@link #gerarNovaSenha()}</code>,
 * uma vez que a sua senha anterior não poderá ser recuperada.</p>
 * 
 * <p>Há também o método <code>{@link #equals()}</code>, para verificar se duas senhas são iguais mediante a política de criptografia do sistema.</p>
 * 
 * @author joao.gabriel
 * 
 */
@Service(value = "CriptografiaService")
public class CriptografiaServiceImpl implements CriptografiaService { 
	// http://www.htmlstaff.org/ver.php?id=23633

	/**
	 * @see #getDigest()
	 */
	private MessageDigest digest;
	
	/**
	 * @see #getEncoder()
	 */
	private BASE64Encoder encoder;
	
	private static final String ALGORITMO_MD5 = "MD5";
	private static final String ALGORITMO_SHA1 = "SHA1";
	
	/**
	 * Prefixo utilizado para compor a senha durante nova encriptação.
	 * 
	 * @see #addTrash(String)
	 */
	private static final String TRASH_A = "$&*@-";
	
	/**
	 * Sufixo utilizado para compor a senha durante nova encriptação.
	 * 
	 * @see #addTrash(String)
	 */
	private static final String TRASH_B = "fofura";
	
	/**
	 * Encripta a senha informada com base na política descrita no comentário da classe.
	 * 
	 * @param senha original
	 * @return senha criptografada
	 * @see #CriptografiaSenha()
	 */
	@Override
	public String criptografarSenha(String senha) {
		String senhaEncriptada = criptografarSenhaSHA1(senha);
		senhaEncriptada = addTrash(senhaEncriptada);
		return criptografarSenhaMD5(senhaEncriptada);
	}
	
	/**
	 * Encripta a senha com o algorítmo SHA-1.
	 *  
	 * @param senha
	 * @return senha criptografada
	 */
	private String criptografarSenhaSHA1(String senha) {
		getDigest(ALGORITMO_SHA1).update(senha.getBytes());
		byte[] bytesSenhaEncriptada = getDigest(ALGORITMO_SHA1).digest();
		return getEncoder().encode(bytesSenhaEncriptada); 
	}
	
	/**
	 * Encripta a senha com o algorítmo MD5.
	 *  
	 * @param senha
	 * @return senha criptografada
	 */
	private String criptografarSenhaMD5(String senha) {
		getDigest(ALGORITMO_MD5).update(senha.getBytes());
		byte[] bytesSenhaEncriptada = getDigest(ALGORITMO_MD5).digest();
		return getEncoder().encode(bytesSenhaEncriptada); 
	}
	
	/**
	 * Verifica se as informadas são iguais, utilizando a política de criptografia do sistema.
	 * 
	 * @param senhaOriginal
	 * @param senhaInformada
	 * @return true: senhas iguais / false: senhas diferentes
	 */
	@Override
	public boolean equals(String senhaOriginal, String senhaInformada) {
		String senhaOriginalEncriptada = criptografarSenha(senhaOriginal);
		String senhaInformadaEncriptada = criptografarSenha(senhaInformada);
		return senhaOriginalEncriptada.equals(senhaInformadaEncriptada);
	}
	
	/**
	 * Gera uma nova senha, com caracteres aleatórios, de 10 (dez) caracteres.
	 * 
	 * @return senha gerada
	 */
	public String gerarNovaSenha() {
		String senha = null;
		
		// verificação realizada para que o primeiro caracter não seja "-"
		do {
			senha = Long.toString(new Random().nextLong(), Character.MAX_RADIX);
		} while (senha.startsWith("-"));
		
		return senha.substring(0, 10);
	}

	/**
	 * Acresenha o sufixo e o prefixo à senha informada.
	 * 
	 * @param senha
	 * @return senha composta por um novo prefixo e sufixo
	 */
	private String addTrash(String senha) {
		StringBuilder senhaTrash = new StringBuilder();
		senhaTrash.append(TRASH_A);
		senhaTrash.append(senha);
		senhaTrash.append(TRASH_B);
		return senhaTrash.toString();
	}

	/**
	 * Retorna uma instância do objeto digest, com base no algorítmo informado.
	 * 
	 * @param algoritmo
	 * @return instância do digest
	 */
	private MessageDigest getDigest(String algoritmo) {
		if (digest == null) {
			try {
				digest = MessageDigest.getInstance(algoritmo);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
		}
		return digest;
	}
	
	/**
	 * Retorna uma instância do objeto encoder, com base 64.
	 * 
	 * @return instância do encoder
	 */
	private BASE64Encoder getEncoder() {
		if (encoder == null) {
			 encoder = new BASE64Encoder();
		}
		return encoder;
	}

}
