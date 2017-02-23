package com.sweetk.kcti.survey.util;

import java.util.Date;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SendEmail{
	
	public boolean isEmail(String email) {
        if (email==null) return false;
        boolean b = Pattern.matches("[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+",email.trim());
        return b;
    }
	
	public void Email (String From, String To, String Subject, String Content){
		
		try{
			String from = From;
			String to = To;
			String subject = Subject;
			String content = Content;
			
			Properties props = new Properties();
			props.put("mail.transport.protocol", "smtp"); 
			props.put("mail.smtp.host", "smtp.daum.net"); 
//			props.put("mail.smtp.host", "wmail.kcti.re.kr"); 
//			props.put("mail.smtp.port", "25");
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.starttls.enable", "true");
//			props.put("mail.smtp.starttls.required", "true");
			
			props.put("mail.smtp.ssl.enable", "true");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.socketFactory.port", "465");
	        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        props.put("mail.smtp.socketFactory.fallback","false");
	
			SMTPAuthenticator auth = new SMTPAuthenticator(); // 계정 정보
			Session mailSession = Session.getInstance(props, auth); // (gmail
			mailSession.setDebug(true);
			
			Message msg = new MimeMessage(mailSession); // 메일 메시지 정보 및 내용을 담음
			InternetAddress fr = new InternetAddress(from,"문화관광해설사 관리자", "euc-kr");
			msg.setFrom(fr);
			
			msg.setHeader("content-type", "text/html;charset=utf-8");
	        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
	        msg.setSubject(subject);
	        msg.setSentDate(new Date());
	        
	        MimeMultipart mp = new MimeMultipart();
	        mp.setSubType("related");
	
	        String html_body = "";
	        MimeBodyPart mbp1= new MimeBodyPart();
	        html_body = content;
	        mbp1.setContent(html_body, "text/html;charset=utf-8");
	        
	        mp.addBodyPart(mbp1);
	
	        msg.setContent(mp);
			Transport.send(msg);
			 
			/*Transport transport = mailSession.getTransport("smtp");

	         transport.connect("wmail.kcti.re.kr", "ctgs", "tourguide2001");
	         transport.sendMessage(msg, msg.getAllRecipients());
	         transport.close();
*/
		} catch (Exception e) {
			System.out.println("e : " + e);
		}
		return;
	}
}
