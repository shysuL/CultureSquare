package user.service.face;

import javax.servlet.http.HttpSession;

import user.dto.User_table;


public interface NaverService {
	/**
	 * 2019-12-23
	 * 조홍철
	 * 
	 * apiResult 결과값을 셋팅한다.
	 * 
	 * @param apiResult -  셋팅할 apiResult
	 * @param session -  셋팅할 세션
	 * @return String - 셋팅한 결과 apiResult
	 */
	public String setApiResult(String apiResult, HttpSession session);
	
	/**
	 * 2019-12-24
	 * 조홍철
	 * 
	 * 소셜 로그인 아이디가 존재하는지 검사한다.
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
	 * 소셜로그인 시도시, User테이블에 정보가 없으면 데이터 삽입(회원가입과 유사)
	 * 
	 * @param user - 소셜로그인 정보가 담긴 객체
	 */
	public void insertNaverInfo(User_table user);
	
	/**
	 * 2019-12-29
	 * 조홍철
	 * 
	 * 네이버 로그인 시도시, 소셜 테이블에 데이터 삽입
	 * 
	 * @param user - 소셜로그인 닉네임이 담긴 유저 객체
	 */
	public void insertNaverSocial(User_table socialuser);
	
	/**
	 * 2019-12-29
	 * 조홍철
	 * 
	 * 소셜로그인 한 사용자의 유저번호를 가져온다
	 * 
	 * @param user - 소셜로그인 닉네임
	 * @return int - 유저 번호
	 */
	public int getUserNo(String socialnick);
}
