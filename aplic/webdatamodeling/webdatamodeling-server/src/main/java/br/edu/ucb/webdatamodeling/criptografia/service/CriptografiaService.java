package br.edu.ucb.webdatamodeling.criptografia.service;

public interface CriptografiaService {

	/**
	 * Encripta a senha informada com base na política descrita no comentário da classe.
	 * 
	 * @param senha original
	 * @return senha criptografada
	 * @see #CriptografiaSenha()
	 */
	String criptografarSenha(String senha);
	
	/**
	 * Verifica se as informadas são iguais, utilizando a política de criptografia do sistema.
	 * 
	 * @param senhaOriginal
	 * @param senhaInformada
	 * @return true: senhas iguais / false: senhas diferentes
	 */
	boolean equals(String senhaOriginal, String senhaInformada);
	
	/**
	 * Gera uma nova senha, com caracteres aleatórios, de 10 (dez) caracteres.
	 * 
	 * @return senha gerada
	 */
	String gerarNovaSenha();
	
}
