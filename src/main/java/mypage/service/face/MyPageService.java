package mypage.service.face;

import user.dto.User_table;

public interface MyPageService{

	public void modifyUserNick(User_table user);

	/**
	 * 사용자의 원래 개인정보 불러오기
	 * 
	 * @param user
	 */
	public User_table getUserInfo(User_table user);

	/**
	 * 비밀번호 변경 전 사용자의 현재 비밀번호 
	 * 
	 * @param user
	 */
	public User_table getFindUserPw(User_table user);

}
