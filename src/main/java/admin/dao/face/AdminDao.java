package admin.dao.face;

import java.util.List;

import admin.dto.Admin;
import user.dto.User_table;
import util.Paging;

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

	public int selectUserCnt(User_table user);

	public List<User_table> selectUserList(Paging userpaging);

	public int deleteUser(User_table userlist);

}
