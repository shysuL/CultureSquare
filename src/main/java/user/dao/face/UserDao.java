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
	 * 네이버 소셜로그인 시도시, User테이블에 정보가 없으면 데이터 삽입(회원가입과 유사)
	 * 
	 * @param user - 소셜로그인 정보가 담긴 객체
	 */
	public void insertNaverLoginInfo(User_table user);
	
	/**
	 * 2019-12-24
	 * 조홍철
	 * 
	 * 카카오 소셜로그인 시도시, User테이블에 정보가 없으면 데이터 삽입(회원가입과 유사)
	 * 
	 * @param user - 소셜로그인 정보가 담긴 객체
	 */
	public void insertKakaoLoginInfo(User_table user);
	
	/**
	 * 2019-12-24
	 * 조홍철
	 * 
	 * 구글 소셜로그인 시도시, User테이블에 정보가 없으면 데이터 삽입(회원가입과 유사)
	 * 
	 * @param user - 소셜로그인 정보가 담긴 객체
	 */
	public void insertGoogleLoginInfo(User_table user);

	
	/**
	 * 2019-12-25
	 * 이빈
	 * 
	 * 회원가입 정보 DB에 넣어 주기
	 * 
	 * @param user - 요청받은 회원가입 정보가 담긴 객체
	 * @return - int ( 1 = 회원가입 성공, 0 = 회원가입 실패 )
	 */
	public int insertJoin(User_table user);

	/**
	 * 2019-12-25
	 * 이빈
	 * 
	 * 아이디 중복체크 검사 ( AJAX )
	 * 
	 * @param userid - 입력받은 아이디
	 * 
	 * @return - int (0 : 사용가능, 1 : 중복닉네임 )
	 */
	public int selectCheckId(String userid);

	/**
	 * 2019-12-26
	 * 이빈
	 * 
	 * 닉네임 중복체크 검사 ( AJAX ) 
	 * 
	 * @param usernick - 입력받은 닉네임
	 * 
	 * @return - int (0 : 사용가능, 1 : 중복닉네임 )
	 */
	public int selectCheckNick(String usernick);


}
