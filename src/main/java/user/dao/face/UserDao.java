package user.dao.face;

import user.dto.User_table;

public interface UserDao {

	/**
	 * 2019-12-24
	 * 조홍철
	 * 
	 * 소셜로그인 시도한 사용자의 테이블에서의 cnt 수 구하기
	 * 
	 * @param user - 소셜로그인 시도한 사용자의 객체
	 * @return int - 일치하는 유저 수
	 */
	public int selectSocialCnt(User_table user);
	
	/**
	 * 2019-12-24
	 * 조홍철
	 * 
	 * 소셜로그인 시도시, User테이블에 정보가 없으면 데이터 삽입(회원가입과 유사)
	 * 
	 * @param user - 소셜로그인 정보가 담긴 객체
	 */
	public void insertNaverLoginInfo(User_table user);
}
