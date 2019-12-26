package artboard.dao.face;

import java.util.List;

import artboard.dto.Board;
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

}
