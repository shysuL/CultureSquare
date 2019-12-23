package admin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.face.AdminDao;
import admin.dto.Admin;
import admin.service.face.AdminService;
import mypage.dto.User_table;

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

}
