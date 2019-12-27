package user.service.impl;

import java.util.Random;

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
	
	// 이메일 인증
	private boolean lowerCheck;
	private int size;

	@Override
	public String init() {
		
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		
		do {
			num = ran.nextInt(75) + 48; 
			if ((num >= 48 && num<=57) || (num >=65 && num <=90) || (num>=97 && num <=122)) {
				sb.append((char) num);
			} else {
				continue;
			}

		} while (sb.length() < size);
		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}

	
	@Override
	public String getKey(boolean lowerCheck, int size) {

		this.lowerCheck = lowerCheck;
		this.size = size;
		
		return init();
	}

	
	@Override
	public void mailSendWithEmailKey(String userid, String username, HttpServletRequest req) {
	
		String key = getKey(false,20);
		userDao.updateEmailKey(userid, key);
		
	}
	
	

}
