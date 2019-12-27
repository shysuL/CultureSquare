package prboard.dao.face;

import org.springframework.scheduling.annotation.Scheduled;

import prboard.dto.PRBoard;

public interface PRBoardDao {
	
	/**
	 * 조홍철
	 * 2019-12-27
	 * 
	 * 하루가 지나면 prCnt를 0으로 초기화 (지금은 30초로 테스트)
	 * 
	 * @param userId - 사용자 닉네임
	 */
	public void updatePRCnt(String usernick);
}
