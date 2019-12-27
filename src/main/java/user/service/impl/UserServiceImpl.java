package user.service.impl;


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
	public boolean loginProc(User_table user) {
		logger.info("서비스임플에서 입력받은 로그인 정보 : " + user);
		if (userDao.selectCnt(user) == 1 ) {
			return true; // 로그인 성공
		}
		
		return false; // 로그인 실패
	}



}
