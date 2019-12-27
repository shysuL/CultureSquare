package user.service.impl;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import user.dao.face.UserDao;
import user.service.face.JoinSendMailService;

@Service
public class JoinSendMailServiceImpl implements JoinSendMailService{

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private UserDao userDao;
	
	private static final Logger logger = LoggerFactory.getLogger(JoinSendMailServiceImpl.class);
	
	@Override
	public void mailSendWithUserKey(String userid, String username, HttpServletRequest req) {
	
	}
	
	

}
