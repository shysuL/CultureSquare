package board.dao.face;

import java.util.List;

import board.dto.FreeBoard;
import board.dto.UpFile;
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
	 * 게시글 작성을 위한 유저닉네임 조회
	 * 
	 * @param attribute - 로그인한 유정 정보 객체
	 * @return User_table - 로그인한 유저 정보와 일치하는 닉네임
	 */
	public User_table selectByUserNick(Object attribute);

	/**
	 * 2019-12-27
	 * 고인호
	 * 
	 * 자유게시판 전체 게시글중 조회수 높은 순으로 조회
	 * 
	 * @return List - 조회수 가장 높은 게시글 리스트
	 */
	public List<FreeBoard> selectViewsAll();

	/**
	 * 2019-12-29
	 * 고인호
	 * 
	 * 자유게시판 게시글 삭제
	 * 
	 * @param boardno - 삭제할 게시글 번호
	 */
	public void deleteFreeBoard(int boardno);
	
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
	 * @param upfile - DB에 저장할 파일 정보
	 */
	public void insertFile(UpFile upfile);
	
	/**
	 * 2019-12-30
	 * 고인호
	 * 
	 * 자유게시판 게시글 첨부파일 정보
	 * 
	 * @param boardno - 첨부파일정보 조회할 게시글 번호
	 * @return - DB에서 조회된 첨부파일 정보 
	 */
	public UpFile selectFile(int boardno);

	/**
	 * 2019-12-30
	 * 고인호
	 * 
	 * 자유게시판 게시글 첨부파일 정보
	 * 
	 * @param fileno - 첨부파일정보 조회할 파일번호
	 * @return - DB에서 조회된 첨부파일 정보
	 */
	public UpFile selectFileNo(int fileno);

	/**
	 * 2019-12-31
	 * 고인호
	 * 
	 * 자유게시판 게시글 첨부파일 삭제
	 * 
	 * @param fileno - 삭제할 첨부파일 번호
	 */
	public void deleteFile(UpFile fileno);


}
