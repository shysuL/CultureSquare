package admin.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.face.AdminDao;
import admin.dto.Admin;
import admin.service.face.AdminService;
import user.dto.User_table;
import util.Paging;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired private AdminDao adminDao;

	@Override
	public boolean login(Admin admin) {
		
		if(adminDao.selectCnt(admin) == 1) {
			return true;
		} //selectCnt가 1이면 true반환, 로그인 인증 성공
		
		return false; //아니면 false반환, 로그인 인증 실패
	}

	@Override
	public int getUserCnt(User_table user) {
		return adminDao.selectUserCnt(user);
	}

	@Override
	public List<User_table> getUserList(Paging userpaging) {
		return adminDao.selectUserList(userpaging);
	}

	@Override
	public boolean userDelete(User_table userlist) {
		
		int result = adminDao.deleteUser(userlist);
		
		if(result == 1) {
			return true;
			
		} else {
			return false;
		}
	}

	@Override
	public User_table getUserInfo(User_table user) {
		return adminDao.selectUserInfo(user);
	}
	
	@Override
	public void updatepermit(User_table user) {
		adminDao.updatePermit(user);
	}

	@Override
	public void downpermit(User_table user) {
		adminDao.downPermit(user);
	}
}
