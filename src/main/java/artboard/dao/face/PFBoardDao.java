package artboard.dao.face;

import java.util.List;

import artboard.dto.Board;
import util.Paging;

public interface PFBoardDao {

	
	public List<Board> selectAll3(String searchMonth);
	public List<Board> selectAll2(String searchMonth);

	/**
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * paging을 객체로 받아서 게시판 리스트 전체 조회
	 * 
	 * @param paging - paging 객체
	 * @return list - 예술 게시판 리스트
	 */
	public List<Board> selectAll(Paging paging);

	
	/**
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * 게시글 전체 개수를 카운트
	 * 
	 * @return int - 게시글 개수 count(*)
	 */
	public int selectCntAll();


	/**
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * boardno 에 해당하는 게시글 전체 정보
	 * 
	 * @param bno - 게시글번호
	 * @return board - 게시글 상세내용
	 */
	public Board view(Board bno);


	/**
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * boardno로 게시글의 작성자 정보 조회
	 * 
	 * @param userno - 작성자 회원번호
	 * @return board - 작성자 회원 정보
	 */
	public Board selectWriter(Board userno);

	/**
	 * 이수현
	 * 2019 - 12 - 27
	 * 
	 * 전달받은 게시글 내용을 입력
	 * 
	 * @param board - 전달받은 게시글 내용
	 */
	public void insertBoard(Board board);


	/**
	 * 이수현
	 * 2019 - 12 - 27
	 * 
	 * 전달받은 예술정보 내용을 입력
	 * 
	 * @param board - 전달받은 예술정보 내용
	 */
	public void insertPerform(Board board);
	
	
	/**
	 * 이수현
	 * 2019 - 12 - 27
	 * 
	 * 게시판 번호 다음 시퀀스를 반환
	 * 
	 * @return int - board_seq.nextval
	 */
	public int selectSeqNextval();

}
