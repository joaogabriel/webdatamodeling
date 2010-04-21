package br.edu.ucb.webdatamodeling.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import br.edu.ucb.webdatamodeling.entity.Usuario;

import static br.edu.ucb.webdatamodeling.mail.EnumMailProperties.*;

public class SendMail {

	private Properties props = new Properties();
	
	public SendMail() {
		initSession(props);
	}
	
	public void send(Usuario usuario) throws MailException {
		Session mailSession = null;
		Transport transport = null;
		String email = usuario.getEmail();
		String senha = usuario.getSenha();
		String mensagem = null;
		MimeMessage message = null;
		
		try {
			mailSession = Session.getDefaultInstance(props);
			//mailSession.setDebug(true);
			
			transport = mailSession.getTransport();
			
			mensagem = createMessage(senha);
			
			message = new MimeMessage(mailSession);
			message.setSubject("Web Data Modeling - Recuperação de Senha");
			message.setContent(mensagem.toString(), TYPE_HTML.getValue());
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

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

	private String createMessage(String senha) {
		StringBuilder message = new StringBuilder();
		
		message.append("<html>");
		message.append("<body>");
		message.append("<h1>Web Data Modeling</h1>");
		message.append("<h2>Recuperação de Senha</h2>");
		message.append("A sua senha é: ");
		message.append(senha);
		message.append("</body>");
		message.append("</html>");
		
		return message.toString();
	}

}
