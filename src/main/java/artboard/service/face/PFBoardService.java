package artboard.service.face;

import java.util.List;

import artboard.dto.Board;
import util.Paging;

public interface PFBoardService {

	
	/**
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * paging 객체를 받아 예술게시판 리스트를 출력
	 * 
	 * @param paging - 게시판 리스트 paging 객체
	 * @return list - 게시판 리스트 반환
	 */
	public List getList(Paging paging);

	/**
	 * 
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * 요청 파라미터 curPage를 파싱한다
	 * board TB와 curPage값을 이용한  Paging객체를 생성하고 반환
	 * 
	 * @param paging - 요청정보객체
	 * @return paging - 페이징 정보
	 */
	public Paging getPaging(Paging paging);

	
	/**
	 * 
	 * 이수현
	 * 2019 - 12 - 26
	 * 
	 * boardno를 파라미터로 받아 해당정보를 불러온다
	 * 
	 * @param bno - 게시글 번호 파라미터
	 * @return board - 게시글 전체 정보
	 */
	public Board view(Board bno);

	
	/**
	 * 이수현
	 * 2019 - 12 - 26
	 * 
	 * 게시글의 작성자의 userno로 회원 정보 조회
	 * 
	 * @param userno - 게시글 작성자의 회원번호
	 * @return board - 게시글 작성자의 회원 정보
	 */
	public Board getWriter(Board userno);

	/**
	 * 이수현
	 * 2019 - 12 - 27
	 * 
	 * 전달받은 게시글 파라미터값을 저장
	 * 
	 * @param board - 게시글 작성 값
	 */
	public void write(Board board);
	
	/**
	 * 이수현
	 * 2019 - 12 - 27
	 *
	 * 특정 날짜에 대하여 요일을 구함(일 ~ 토)
	 * @param date
	 * @param dateType
	 * @return
	 * @throws Exception
	 */
	public String getDateDay(String date, String dateType) throws Exception;



}
