package user.service.face;

import user.dto.User_table;

public interface GoogleService {
	
	/**
	 * 2019-12-24
	 * 조홍철
	 * 
	 * 구글 로그인 아이디가 존재하는지 검사한다.
	 * 
	 * @param user - 소셜로그인 정보가 담긴 객체
	 * @return  int - 소셜로그인 정보 갯수
	 *  	
	 */
	public int getSocialAccountCnt(User_table user);
	
	
	/**
	 * 2019-12-24
	 * 조홍철
	 * 
	 * 구글 로그인 시도시, User테이블에 정보가 없으면 데이터 삽입(회원가입과 유사)
	 * 
	 * @param user - 소셜로그인 정보가 담긴 객체
	 */
	public void insertGoogleInfo(User_table user);
	
}
