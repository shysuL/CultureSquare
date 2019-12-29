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
	 * 네이버 소셜로그인 시도시, 소셜 테이블에 정보가 없으면 데이터 삽입(회원가입과 유사)
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
	
	/**
	 * 2019-12-27
	 * 이빈
	 * 
	 * 로그인 
	 * 
	 * @param user - 로그인폼에서 입력받은 정보
	 * 
	 * @return - boolean ( true : 로그인, false : 실패 )
	 */
	public int selectCnt(User_table user);

	
	/**
	 * 2019-12-27
	 * 이빈
	 * 
	 * 세션에 저장할 usernick, username, interest 가져오기
	 * 
	 * @param user - userid
	 * @return - User_table(usernick, username, interest)
	 */
	public User_table selectUserInfoById(User_table user);
	
	/**
	 * 2019-12-27
	 * 이빈
	 * 
	 * 회원가입 초기 상태인 emailcheck- null을 생성된 난수값으로 update
	 * 
	 * @param userid - 이메일
	 * @param key - 난수키
	 * @return 
	 */
	public int insertEmailKey(String userid, String key);
	
	/**
	 * 2019-12-28
	 * 이빈
	 * 
	 * 이메일에서 인증하기 버튼 누르면 난수값(emailcheck)을 Y값으로 update
	 * 
	 * @param userid - 이메일
	 * @param key - 난수키
	 * @return int - 성공여부 0: 실패, 1: 성공
	 */
	public int updateEmailKey(String userid, String key);
	
	
	/**
	 * 2019-12-29
	 * 조홍철
	 * 
	 * 소셜로그인 시도시, 소셜테이블에 데이터 삽입
	 * 
	 * @param user - 소셜로그인 닉네임이 담긴 유저 객체
	 */
	public void insertSocial(User_table socialuser);
	
	/**
	 * 2019-12-29
	 * 조홍철
	 * 
	 * 소셜로그인 한 사용자의 유저번호를 가져온다
	 * 
	 * @param user - 변경한 닉네임
	 * @return int - 유저 번호
	 */
	public int selectuserNo(String socialnick);
	
	
	/**
	 * 2019-12-29
	 * 조홍철
	 * 
	 * 소셜로그인 한 사용자의 유저번호를 가져온다
	 * 
	 * @param user - 기존 소셜 닉네임
	 * @return int - 유저 번호
	 */
	public int selectSocialuserNo(String socialnick);
	
	/**
	 * 2019-12-29
	 * 조홍철
	 * 
	 * 유저번호를 통해 사용자의 변경된 닉네임을 가져온다.
	 * 
	 * @param userno - 유저 번호
	 * @return String - 변경된 닉네임
	 */
	public String selectUserNick(int userno);

}
