package artboard.dao.face;

import java.util.List;

import util.Paging;

public interface PFBoardDao {

	
	/**
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * paging을 객체로 받아서 게시판 리스트 전체 조회
	 * 
	 * @param paging - paging 객체
	 * @return list - 예술 게시판 리스트
	 */
	public List selectAll(Paging paging);

	
	/**
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * 게시글 전체 개수를 카운트
	 * 
	 * @return int - 게시글 개수 count(*)
	 */
	public int selectCntAll();

}
