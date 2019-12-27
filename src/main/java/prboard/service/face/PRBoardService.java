package prboard.service.face;

import user.dto.User_table;

public interface PRBoardService {

	/**
	 * 조홍철
	 * 2019-12-27
	 * 
	 * 세션값으로 닉네임을 얻는다.(스케줄러는 매개변수를 못받기 때문 ㅠ, 전역변수 선언해 넣어줄거임)
	 * 
	 * @param usernick - 세션에 저장된 닉네임
	 */
	public void getNickName(String usernick);
	
	
	/**
	 * 조홍철
	 * 2019-12-27
	 * 
	 * 닉네임으로  하루 작성한 pr 게시글 수를 얻는다.(스케줄러는 매개변수를 못받기 때문 ㅠ, 전역변수 선언해 넣어줄거임)
	 * 
	 * @param usernick - 세션에 저장된 닉네임
	 * @return int - 하루 작성한 pr 게시글 수
	 */
	public int getprCntByNickName(String usernick);
	
	
	/**
	 * 조홍철
	 * 2019-12-27
	 * 
	 * 하루가 지나면 prCnt를 0으로 초기화, 스케줄러 사용함 (지금은 30초로 테스트)
	 * 
	 */
	public void prCntReset();
		
}
