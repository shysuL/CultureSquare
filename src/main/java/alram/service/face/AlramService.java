package alram.service.face;

import java.util.List;

import alram.dto.Alram;
import user.dto.User_table;

public interface AlramService {

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 유저 번호 구하기
	 * 
	 * @param usernick - 로그인한 사용자 닉네임
	 * @return int - 유저번호
	 */
	public int getUserNoByUserNick(String usernick);

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 알람 갯수 얻기
	 * 
	 * @param userno - 로그인한 사용자 번호
	 * @return int - 알람 갯수 
	 */
	public int getAlramCnt(int userno);

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 알람테이블 alramcheck를 1로 업데이트
	 * 
	 * @param alram - 알람 번호를 가진 객체
	 */
	public void readAlram(Alram alram);

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 알람 테이블 리스트를 가져온다.
	 * 
	 * @param userno - 로그인한 유저 번호
	 * @return List - 알람 리스트
	 */
	public List<Alram> getAlramList(int userno);

}
