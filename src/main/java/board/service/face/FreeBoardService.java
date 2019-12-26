package board.service.face;

import java.util.List;

import board.dto.FreeBoard;
import util.Paging;

public interface FreeBoardService {
	
	/** 2019 - 12 - 23
	 * 고인호
	 * 
	 * 전체 게시글 개수 구하기
	 * 
	 */
	public int getListCnt();
	
	
	/** 
	 * 2019-12-23
	 * 고인호
	 * 
	 * 자유게시판 전체 게시글 페이징 처리해서 보여주기
	 * 
	 * @param paging - 요청 페이징 정보 객체
	 * @return
	 */
	public List<FreeBoard> getList(Paging paging);

	
	/**
	 * 2019-12-26
	 * 고인호
	 * 
	 * 자유게시판 게시글 상세보기
	 * 
	 * @param boardno - 요청 게시글 정보
	 * @return - 
	 */
	public FreeBoard freeDetail(int boardno);


}
