package user.service.face;

import user.dto.User_table;

public interface UserService {

	/**
	 * 2019-12-25 
	 * 이빈
	 * 받아온 회원가입 정보 DB에 넣어주기
	 * @param user - 요청으로 받아온 회원가입 정보
	 * @return - int
	 */
	public int joinProc(User_table user);

	
	/**
	 * 2019-12-25
	 * 이빈
	 * 아이디 중복체크 하기(AJAX)
	 * @param userid - 입력한 아이디
	 * @return - int (0 : 사용가능, 1 : 중복닉네임 )
	 */
	public int userIdCheck(String userid);

	/**
	 * 2019-12-26
	 * 이빈
	 * 닉네임 중복체크 하기(AJAX)
	 * @param usernick - 입력한 닉네임
	 * @return - int (0 : 사용가능, 1 : 중복닉네임 )
	 */
	public int userNickCheck(String usernick);

	/**
	 * 2019-12-27
	 * 이빈
	 * 로그인
	 * @param user - 입력한 아이디 / 패스워드
	 * @return true - 로그인 성공
	 */
	public boolean loginProc(User_table user);

}
