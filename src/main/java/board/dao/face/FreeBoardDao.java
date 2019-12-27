package board.dao.face;

import java.util.List;

import board.dto.FreeBoard;
import user.dto.User_table;
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
	
	/**
	 * 2019-12-26
	 * 
	 * 자유게시판 게시글 쓰기
	 * 
	 * @param freeboard - DB에 저장될 게시글 정보 객체
	 */
	public void insertFreeBoard(FreeBoard freeboard);

	/**
	 * 2019-12-26
	 * 
	 * 게시글 상세보기 조회수 증가
	 * 
	 * @param boardno - 상세보기 조회된 게시글 정보 객체
	 */
	public void updateViews(int boardno);
	
	/**
	 * 2019-12-27
	 * 
	 * 게시글 작성을 위한 유저아이디 조회
	 * 
	 * @param attribute - 로그인한 유정 정보 객체
	 * @return User_table - 로그인한 유저 정보와 일치하는 아이디
	 */
	public User_table selectByUserId(Object attribute);


}
