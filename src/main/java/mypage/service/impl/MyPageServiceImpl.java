package mypage.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import mypage.dao.face.MyPageDao;
import mypage.service.face.MyPageService;
import user.dto.User_table;
import util.MyPaging;
import util.Paging;

@Service
public class MyPageServiceImpl implements MyPageService{
	
	@Autowired MyPageDao mypageDao;

	@Override
	public void modifyUserInfo(User_table user) {
		mypageDao.updateUserInfo(user);
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

	@Override
	public int userNickCheck(String usernick) {
		return mypageDao.selectUserNick(usernick);
	}

	@Override
	public void deleteUser(User_table user) {
		mypageDao.deleteUserId(user);
	}

	@Override
	public MyPaging getPaging(MyPaging paging) {
		
		int totalCount = mypageDao.selectCntAll(paging);
		
		MyPaging result = new MyPaging(totalCount, paging.getCurPage());
		result.setUserno(paging.getUserno());
		
		return result;
	}
	
	@Override
	public List getLikeList(MyPaging paging) {
		
		return mypageDao.selectLikePost(paging);
	}

	@Override
	public List getWriteList(MyPaging paging) {
		return mypageDao.selectWritePost(paging);
	}
	
	@Override
	public List getReplyList(MyPaging paging) {
		return mypageDao.selectReplyPost(paging);
	}
}
