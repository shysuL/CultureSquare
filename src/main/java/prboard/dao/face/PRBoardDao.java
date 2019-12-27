package prboard.dao.face;

import user.dto.User_table;

public interface PRBoardDao {
	
	/**
	 * 조홍철
	 * 2019-12-27
	 * 
	 * 하루가 지나면 prCnt를 0으로 초기화 (지금은 30초로 테스트)
	 * 
	 * @param usernick - 사용자 닉네임
	 */
	public void updatePRCnt(String usernick);
	
	/**
	 * 조홍철
	 * 2019-12-27
	 * 
	 * 로그인 한 사용자의 현재 prCnt 갯수 구하기
	 * 
	 * @param nickName - 사용자 닉네임
	 * @return
	 */
	public User_table selectprCnt(String usernick);
}
