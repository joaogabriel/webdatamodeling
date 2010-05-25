package br.edu.ucb.webdatamodeling.criptografia.service;

public interface CriptografiaService {

	/**
	 * Encripta a senha informada com base na pol�tica descrita no coment�rio da classe.
	 * 
	 * @param senha original
	 * @return senha criptografada
	 * @see #CriptografiaSenha()
	 */
	String criptografarSenha(String senha);
	
	/**
	 * Verifica se as informadas s�o iguais, utilizando a pol�tica de criptografia do sistema.
	 * 
	 * @param senhaOriginal
	 * @param senhaInformada
	 * @return true: senhas iguais / false: senhas diferentes
	 */
	boolean equals(String senhaOriginal, String senhaInformada);
	
	/**
	 * Gera uma nova senha, com caracteres aleat�rios, de 10 (dez) caracteres.
	 * 
	 * @return senha gerada
	 */
	String gerarNovaSenha();
	
}
