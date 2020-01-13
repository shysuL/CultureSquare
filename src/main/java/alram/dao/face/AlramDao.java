package alram.dao.face;

import user.dto.User_table;

public interface AlramDao {

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 유저 번호 구하기
	 *  
	 * @param usernick - 로그인한 사용자 닉네임
	 * @return int - 유저번호
	 */
	public int selectUserNo(String usernick);

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 알람 갯수 얻기
	 * 
	 * @param userno - 로그인한 사용자 번호
	 * @return int - 알람 갯수 
	 */
	public int selectAlramCnt(int userno);

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 알람테이블 alramcheck를 1로 업데이트
	 * 
	 * @param userno - 유저 번호
	 */
	public void updateAlramCheck(int userno);

}
