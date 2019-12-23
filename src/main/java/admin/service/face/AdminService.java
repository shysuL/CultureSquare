package admin.service.face;

import admin.dto.Admin;
import mypage.dto.User_table;

public interface AdminService {

	/**
	 * 채해원
	 * 2019.12.23
	 * 
	 * 관리자 로그인 처리
	 * 세션은 로그인이 실행된 후이므로 매개변수에 세션 안 넣음
	 * 
	 * @param admin - 로그인 아이디, 패스워드 정보 객체
	 * @return true - 로그인 인증성공 / false - 로그인 인증 실패
	 */
	public boolean login(Admin admin);

}
