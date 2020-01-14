package admin.dao.face;

import java.util.HashMap;
import java.util.List;

import admin.dto.Admin;
import artboard.dto.Board;
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

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 수 카운트
	 * 
	 * @param user
	 * @return
	 */
	public int selectUserCnt(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 목록 불러오기(페이징)
	 * 
	 * @param userpaging
	 * @return
	 */
	public List<User_table> selectUserList(Paging userpaging);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 삭제
	 * 
	 * @param userlist
	 * @return
	 */
	public int deleteUser(User_table userlist);

	/**
	 * 2020-01-12
	 * 채해원
	 * 
	 * 사용자의 정보 가져오기.
	 * 
	 * @param user
	 * @return
	 */
	public User_table selectUserInfo(User_table user);

	/**
	 * 2020-01-13 
	 * 채해원
	 * 
	 * 관리자의 승인을 받아 사용자를 예술인으로 등업.
	 * 
	 * @param user
	 */
	public void updatePermit(User_table user);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 관리자의 자격으로 예술인을 일반사용자로 강등
	 * 
	 * @param user
	 */
	public void downPermit(User_table user);
	
	/**
	 * 2020-01-14
	 * 채해원
	 * 
	 * 공지사항의 상세보기를 위한 정보 가져오기
	 * 
	 * @param board
	 * @return
	 */
	public Board selectNotice(Board board);

}
