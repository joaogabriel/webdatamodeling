package br.edu.ucb.webdatamodeling.criptografia.service.impl;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.criptografia.service.CriptografiaService;

import sun.misc.BASE64Encoder;

@Service(value = "CriptografiaService")
public class CriptografiaServiceImpl implements CriptografiaService {

	private MessageDigest digest;
	
	public String criptografarSenha(String senha) {
		BASE64Encoder encoder = new BASE64Encoder();
		getDigest().update(senha.getBytes());
		byte[] bytesSenhaEncriptada = getDigest().digest();
		return encoder.encode(bytesSenhaEncriptada);
	}
	
	public boolean equals(String senhaOriginal, String senhaInformada) {
		String senhaOriginalEncriptada = criptografarSenha(senhaOriginal);
		String senhaInformadaEncriptada = criptografarSenha(senhaInformada);
		return senhaOriginalEncriptada.equals(senhaInformadaEncriptada);
	}
	
	private MessageDigest getDigest() {
		try {
			if (digest == null) {
				digest = MessageDigest.getInstance("MD5");
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return digest;
	}
	
}
