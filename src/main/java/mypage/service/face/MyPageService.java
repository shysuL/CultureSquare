package mypage.service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import user.dto.User_table;
import util.Paging;

public interface MyPageService{

	public void modifyUserInfo(User_table user);

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

	public User_table getCurrentPwParam(Model model);

	public boolean equalsPw(User_table pwParam);

	public void modifyUserPassword(User_table pwParam);

	public boolean comparedPw(User_table user);

	public int userNickCheck(String usernick);
	
	public void deleteUser(User_table user);

	public Paging getPaging(HttpServletRequest req, int i);

	public List getLikeList(Paging paging, User_table user, int i);

}
