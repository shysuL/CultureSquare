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



}
