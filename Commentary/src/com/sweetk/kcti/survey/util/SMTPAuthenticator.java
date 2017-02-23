package com.sweetk.kcti.survey.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	protected PasswordAuthentication getPasswordAuthentication() {
		String username = "ctgs";
		String password = "gotjftk2001";
//		String password = "tourguide2001";
		return new PasswordAuthentication(username, password);
	}
}
