package board.dao.face;

import java.util.List;

import board.dto.FreeBoard;
import util.Paging;

public interface FreeBoardDao {
	
	/** 
	 * 2019-12-25
	 * 고인호
	 * 
	 * 자유게시판 전체 게시글 페이징 처리해서 보여주기
	 * 
	 * @param paging - 요청 페이징 정보 객체
	 * @return
	 */
	public List<FreeBoard> selectAll(Paging paging);

	public int selectCnt();

	
	/**
	 * 2019-12-26
	 * 고인호
	 * 
	 * 자유게시판 게시글 상세보기
	 * 
	 * @param boardno - 요청 게시글 정보
	 * @return - 
	 */
	public FreeBoard selectFreeDetail(int boardno);


}
