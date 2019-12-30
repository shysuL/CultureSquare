package prboard.dao.face;

import java.util.Map;

public interface PRBoardDao {
	
	/**
	 * 2019-12-26
	 * 조홍철
	 * 
	 * 게시글 작성
	 * 
	 * 
	 * @param map - 게시글 입력 정보가 담긴 맵
	 * 
	 */
	public void insertPR(Map<String, Object> map);
	
	/**
	 * 2019-12-26
	 * 조홍철
	 * 
	 * 첨부파일 삽입
	 * 
	 * 
	 * @param map - 파일 정보가 담긴 맵
	 * 
	 */
	public void insertFile(Map<String, Object> map);
}
