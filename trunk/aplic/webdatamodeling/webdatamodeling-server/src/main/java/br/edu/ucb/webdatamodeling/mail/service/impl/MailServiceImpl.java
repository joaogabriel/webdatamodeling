package br.edu.ucb.webdatamodeling.mail.service.impl;

import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.SMTP_AUTH;
import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.SMTP_AUTH_PASSWORD;
import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.SMTP_AUTH_USER;
import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.SMTP_HOST_NAME;
import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.SMTP_HOST_PORT;
import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.TRANSPORT_PROTOCOL;
import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.TYPE_HTML;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

import br.edu.ucb.webdatamodeling.entity.Usuario;
import br.edu.ucb.webdatamodeling.mail.MailException;
import br.edu.ucb.webdatamodeling.mail.service.MailService;

@Service(value = "MailService")
public class MailServiceImpl implements MailService {

	private Properties props = new Properties();
	
	public MailServiceImpl() {
		initSession(props);
	}

	@Override
	public void send(Usuario usuario) throws MailException {
		Session mailSession = null;
		Transport transport = null;
		String mensagem = null;
		MimeMessage message = null;
		
		try {
			mailSession = Session.getDefaultInstance(props);
			mailSession.setDebug(true);
			
			transport = mailSession.getTransport();
			
			mensagem = createMessage(usuario);
			
			message = new MimeMessage(mailSession);
			message.setSubject("Web Data Modeling - Recuperação de Senha");
			message.setContent(mensagem.toString(), TYPE_HTML.getValue());
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(usuario.getEmail()));

			transport.connect(SMTP_HOST_NAME.getValue(), new Integer(SMTP_HOST_PORT.getValue()), SMTP_AUTH_USER.getValue(), SMTP_AUTH_PASSWORD.getValue());
			transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
		} catch (NoSuchProviderException e) {
			throw new MailException("Ocorreu um erro na comunicação com o servidor de envio de e-mail.", e);
		} catch (MessagingException e) {
			throw new MailException("Ocorreu um erro durante o envio de e-mail.", e);
		} finally {
			try {
				transport.close();
			} catch (MessagingException e) {
				throw new MailException("Ocorreu um erro ao encerrar a conexão com o servidor de e-mail.", e);
			}
		}

	}

	private void initSession(Properties props) {
		props.put("mail.transport.protocol", TRANSPORT_PROTOCOL.getValue());
		props.put("mail.smtps.host", SMTP_HOST_NAME.getValue());
		props.put("mail.smtps.auth", SMTP_AUTH.getValue());
	}

	private String createMessage(Usuario usuario) {
		StringBuilder message = new StringBuilder();
		
		message.append("<html>");
		message.append("<body>");
		message.append("<span style=\"font-family: Verdana; font-size: small\">Olá ").append(usuario.getNome()).append(",</span>");
		message.append("<br>");
		message.append("<br>");
		message.append("<span style=\"font-family: Verdana; font-size: small\">A sua senha para acesso ao Web Data Modeling é: <b>").append(usuario.getSenha()).append("</b></span>");
		message.append("<br>");
		message.append("<br>");
		message.append("<span style=\"font-family: Verdana; font-size: small\">Atenciosamente,</span>");
		message.append("<br>");
		message.append("<span style=\"font-family: Verdana; font-size: small\">Equipe Web Data Modeling</span>");
		message.append("<br>");
		message.append("<a style=\"font-family: Verdana; font-size: small; text-decoration: underline\" href=\"mailto:webdatamodeling@gmail.com\">webdatamodeling@gmail.com</a>");
		message.append("<br>");
		message.append("<br>");
		message.append("<span style=\"font-family: Verdana; font-size: small\">ATENÇÃO: NÃO RESPONDA A ESTE E-MAIL. O ENVIO É AUTOMÁTICO.</span>");
		message.append("</body>");
		message.append("</html>");
		
		return message.toString();
	}

}
