package mypage.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mypage.dao.face.MyPageDao;
import mypage.service.face.MyPageService;
import user.dto.User_table;

@Service
public class MyPageServiceImpl implements MyPageService{
	
	@Autowired MyPageDao mypageDao;

	@Override
	public void modifyUserNick(User_table user) {
		mypageDao.updateUserNick(user);
	}

}
