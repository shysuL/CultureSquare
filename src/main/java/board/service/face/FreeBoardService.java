package board.service.face;

import java.util.List;

import board.dto.FreeBoard;
import user.dto.User_table;
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
	 * @param boardno - 요청 게시글번호 정보 객체
	 * @return - 
	 */
	public FreeBoard freeDetail(int boardno);

	/**
	 * 2019-12-26
	 * 고인호
	 * 
	 * 자유게시판 게시글 쓰기
	 * @param freeboard - DB에 저장될 게시글 정보 객체
	 */
	public void writeFree(FreeBoard freeboard);

	/**
	 * 2019-12-26
	 * 고인호
	 * 
	 * 게시글 상세보기 조회수 증가
	 * 
	 * @param boardDetail- 상세보기 조회된 게시글 정보 객체
	 */
	public void increaseViews(int boardno);

	/**
	 * 2019-12-26
	 * 고인호
	 * 
	 * 게시글 작성을 위한 유저넘버 조회
	 * 
	 * @param attribute - 로그인한 유정 정보 객체
	 * @return 
	 */
	public User_table getboardWriter(Object attribute);


}
