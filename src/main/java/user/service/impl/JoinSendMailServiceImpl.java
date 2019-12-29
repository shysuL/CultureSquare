package user.service.impl;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
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
		userDao.insertEmailKey(userid, key);

		
		logger.info("메일인증 null -> 난수키 : " + key );
		
		MimeMessage mail = mailSender.createMimeMessage();
		
		String htmlStr = "<h2>안녕하세요 CultureSquare 입니다!</h2><br><br>"
				+ "<h3>" + userid + "님</h3>" + "<p>인증하기 버튼을 누르시면 CultureSquare의 서비스를 이용하실 수 있습니다"
				+ "<a href='https://localhost:8443" + req.getContextPath() 
				+ "/user/emailCheck?userid=" + userid + "&emailcheck="+key+"'>인증하기</a></p>";
				
				try {
					mail.setSubject("[본인인증] CultureSquare 인증메일입니다", "utf-8");
					mail.setText(htmlStr, "utf-8", "html");
					mail.addRecipient(RecipientType.TO, new InternetAddress(userid));
					mailSender.send(mail);
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	}


	@Override
	public int emailCheckComplete(String userid, String key) {
		
		logger.info("메일인증 난수키 -> Y로바꿔줄때의 난수키 : " + key );
		
		int resultCnt = 0;
		
		resultCnt = userDao.updateEmailKey(userid, key);
		
		logger.info("메일인증 Y로바꿔주고 결과값 : " + resultCnt);
		
		return resultCnt;
	}
	
	
	

}
