package admin.service.face;

import java.util.HashMap;
import java.util.List;

import admin.dto.Admin;
import user.dto.User_table;
import util.Paging;

public interface AdminService {

	/**
	 * 2019.12.23
	 * 채해원
	 * 
	 * 관리자 로그인 처리
	 * 세션은 로그인이 실행된 후이므로 매개변수에 세션 안 넣음
	 * 
	 * @param admin - 로그인 아이디, 패스워드 정보 객체
	 * @return true - 로그인 인증성공 / false - 로그인 인증 실패
	 */
	public boolean login(Admin admin);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 수 세기
	 * 
	 * @param user
	 * @return
	 */
	public int getUserCnt(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 목록 가져오기
	 * 
	 * @param userpaging
	 * @return
	 */
	public List<User_table> getUserList(Paging userpaging);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 삭제 
	 * 
	 * @param userlist
	 * @return
	 */
	public boolean userDelete(User_table userlist);

	/**
	 * 2020-01-12
	 * 채해원
	 * 
	 * 사용자 정보 불러오기
	 * 
	 * @param user
	 * @return
	 */
	public User_table getUserInfo(User_table user);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 일반사용자 등급을 예술인 등급으로 등업
	 * 
	 * @param user
	 */
	public void updatepermit(User_table user);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 예술인 등급의 사용자를 일반사용자로 다운
	 * 
	 * @param user
	 */
	public void downpermit(User_table user);

}
