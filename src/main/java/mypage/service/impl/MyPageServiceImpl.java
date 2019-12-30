package mypage.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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

	@Override
	public User_table getUserInfo(User_table user) {
		
		return mypageDao.selectUserAll(user);
		
	}

	@Override
	public User_table getFindUserPw(User_table user) {
		
		return mypageDao.selectByUserPw(user);
	}

	@Override
	public User_table getCurrentPwParam(Model model) {
		
		User_table user = new User_table();
		
		String param = null;
		
		param = (String) model.getAttribute("userpw");
		
		System.out.println("서비스임플 getCurrentPwParam : " + param);
		
		user.setUserpw(param);
		
		return user;
	}

	@Override
	public boolean equalsPw(User_table pwParam) {
		
		int cnt = 0;
		cnt = mypageDao.selectCntByUserPw(pwParam);
		System.out.println("cnt : " + cnt);
		System.out.println(pwParam);
		if(cnt == 1) {
			return true;
		}
		
		return false;
	}

	@Override
	public void modifyUserPassword(User_table pwParam) {
		System.out.println("서비스 임플에서 pwParam(변경비밀번호가 나와야함 : " + pwParam );
		
		mypageDao.updatePassword(pwParam);
		
		
	}

	@Override
	public boolean comparedPw(User_table user) {
		
		int cnt = 0;
		cnt = mypageDao.selectCntByUserPw(user);
		System.out.println("cnt : " + cnt);
		System.out.println(user);
		if(cnt == 1) {
			return true;
		}
		
		return false;
	}
}
