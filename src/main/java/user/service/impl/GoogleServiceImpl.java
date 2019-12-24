package user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import user.dao.face.UserDao;
import user.dto.User_table;
import user.service.face.GoogleService;

@Service
public class GoogleServiceImpl implements GoogleService {

	@Autowired private UserDao userDao;
	
	@Override
	public int getSocialAccountCnt(User_table user) {
		return userDao.selectSocialCnt(user);
	}

	@Override
	public void insertGoogleInfo(User_table user) {

		userDao.insertGoogleLoginInfo(user);
	}
	

}
