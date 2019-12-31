package mypage.dao.face;

import user.dto.User_table;

public interface MyPageDao {

	/**
	 * 사용자의 닉네임 수정
	 * 
	 * @param user
	 */
	public void updateUserNick(User_table user);
	
	/**
	 * 사용자 개인정보 수정
	 * 
	 * @param user
	 * @return
	 */
	public User_table selectUserAll(User_table user);

	/**
	 * 사용자 비밀번호 변경을 위한 아이디 확인
	 * 
	 * @param user
	 * @return
	 */
	public User_table selectByUserPw(User_table user);

	/**
	 * 비밀번호가 맞는 지 확인
	 * 
	 * @param pwParam
	 * @return
	 */
	public int selectCntByUserPw(User_table pwParam);

	public void updatePassword(User_table pwParam);

	public int selectComparedPw(String lockPw);

	public int selectUserNick(String usernick);

}
