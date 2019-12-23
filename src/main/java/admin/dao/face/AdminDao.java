package admin.dao.face;

import admin.dto.Admin;

public interface AdminDao {

	/**
	 * 채해원
	 * 2019.12.23
	 * 
	 * 로그인 아이디, 패스워드가 일치하는 사용자 수 구하기
	 * 
	 * @param admin - 로그인 아이디, 패스워드
	 * @return int - 일치하는 유저수
	 */
	public int selectCnt(Admin admin);

}
