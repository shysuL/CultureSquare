package user.service.impl;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import user.dao.face.UserDao;
import user.dto.User_table;
import user.service.face.UserService;

@Service
public class UserServiceImpl implements UserService{

	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired UserDao userDao;
	
	// 회원가입 정보 DB 넣기
	@Override
	public int joinProc(User_table user) {

		int resultCnt = 0;
		
		resultCnt = userDao.insertJoin(user);
		
		System.out.println("insertJoin 반환값(0 실패, 1 성공) : " + resultCnt);
		
		return resultCnt;
	}

	@Override
	public int userIdCheck(String userid) {
		
		return userDao.selectCheckId(userid);		
	}


	@Override
	public int userNickCheck(String usernick) {

		return userDao.selectCheckNick(usernick);
	}

	
	@Override
	public int loginProc(User_table user, HttpSession session, String userCheck, HttpServletResponse resp) {
		
		logger.info("UserServiceImpl - loginProc(user) : " + user);
		String userId = user.getUserid();
		String userPw = user.getUserpw();
		
		// 입력받은 유저아이디에 맞는 회원정보 가져오기
		User_table userLogin = userDao.loginUserInfo(userId); 
		logger.info("UserServiceImpl - userLogin : " + userLogin);
		
		// 로그인 결과값
		int result = 0;
		
		// 아이디에 맞는 회원정보가 없을시
		if (userLogin == null) {
			result = 2;
			return result;
		}
		
		// 비밀번호가 다른 경우
		if (!(userLogin.getUserpw().equals(userPw))) {
			result = 3;
			return result;
		}
		
		// 이메일 체크가 되지 않은 사용자
		if (!(userLogin.getEmailcheck().equals("Y"))){ 
			result = 4;
			return result;
		}
		
		// 아이디, 비밀번호가 일치하는 회원정보가 존재할 경우
		if (userLogin.getUserid().equals(userId) && userLogin.getUserpw().equals(userPw)) {
			logger.info("UserServiceImpl에서 userCheck : " + userCheck);
			//세션 정보 불러오기
			User_table userSession = getUserSession(user);
			session.setAttribute("login", true);
			session.setAttribute("userid", user.getUserid());
			session.setAttribute("usernick", userSession.getUsernick());
			session.setAttribute("username", userSession.getUsername());
			session.setAttribute("interest", userSession.getInterest());
			session.setAttribute("userno", userSession.getUserno());
						
//			if(userCheck != null) { // null이랑 equals("on")은 비교할 수 없음
				// 쿠키 체크 검사 
				if (userCheck.equals("on")) { 
					logger.info("쿠키저장 확인");
					Cookie cookie = new Cookie("rememberUser", (String)session.getAttribute("userid"));
					resp.addCookie(cookie);
					logger.info("쿠키 : " + cookie.getName());
					logger.info("쿠키 : " + cookie.getValue());
				}
			
			
			result = 1;
		}
		return result;

	}

	
	@Override
	public User_table getUserSession(User_table user) {
		
		return userDao.selectUserInfoById(user);
		
	}

	@Override
	public List<User_table> getUseridByNamePhone(User_table user) {
		return userDao.selectUserIdByNamePhone(user);
	}




}
