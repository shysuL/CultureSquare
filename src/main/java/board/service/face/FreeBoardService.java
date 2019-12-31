package board.service.face;

import java.util.List;

import board.dto.FreeBoard;
import board.dto.UpFile;
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
	 * 
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
	 * 게시글 작성을 위한 유저아이디 조회
	 * 
	 * @param attribute - 로그인한 유정 정보 객체
	 * @return 
	 */
	public User_table getboardWriter(Object attribute);

	/**
	 * 2019-12-26
	 * 고인호
	 * 
	 * 자유게시판 전체 게시글중 조회수 높은 순으로 조회
	 * 
	 * @return List - 조회수 가장 높은 게시글 리스트
	 */
	public List<FreeBoard> getViewsList();

	/**
	 * 2019-12-29
	 * 고인호
	 * 
	 * 자유게시판 게시글 삭제
	 * 
	 * @param boardno - 삭제할 게시글 번호
	 */
	public void freeDelete(int boardno);

	/**
	 * 2019-12-29
	 * 고인호
	 * 
	 * 자유게시판 게시글 수정
	 * 
	 * @param freeboard - 수정에 반영될 게시글 제목, 내용 정보
	 * @return 
	 */
	public void updateFreeBoard(FreeBoard freeboard);

	/**
	 * 2019-12-30
	 * 고인호
	 * 
	 * 자유게시판 게시글에 첨부할 파일
	 * 
	 * @param upfile - 게시글에 첨부할 파일 정보
	 * @param boardno - 첨부파일 정보에 저장할 게시글번호
	 */
	public void filesave(UpFile upfile, int boardno);

	/**
	 * 2019-12-30
	 * 고인호
	 * 
	 * 자유게시판 게시글 첨부파일 정보
	 * 
	 * @param boardno - 첨부파일정보 조회할 게시글 번호
	 * @return - DB에서 조회된 첨부파일 정보 
	 */
	public UpFile getFile(int boardno);

	/**
	 * 2019-12-30
	 * 고인호
	 * 
	 * 자유게시판 게시글 첨부파일 정보
	 * 
	 * @param fileno - 첨부파일정보 조회할 파일번호
	 * @return - DB에서 조회된 첨부파일 정보
	 */
	public UpFile getFileNo(int fileno);

	/**
	 * 2019-12-30
	 * 고인호
	 * 
	 * 자유게시판 게시글 첨부파일 삭제
	 * 
	 * @param fileno - 삭제할 첨부파일번호
	 */
	public void fileDelete(UpFile fileno);


}
