package artboard.service.face;

import java.util.List;

import artboard.dto.Board;
import artboard.dto.Reply;
import util.Paging;

public interface PFBoardService {

	
	/**
	 * 이수현
	 * 2019 - 12 - 30
	 * 
	 * 전달받은 파라미터(연도, 날짜)에 해당하는 게시글 리스트 조회
	 * 
	 * @param searchMonth - 연도 + 월  파라미터 값
	 * @return List<Board> - artboardlist
	 */
	public List<Board> getList(String searchMonth);

	

	
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
	public String getDateDay(String date, String dateType);




	/**
	 * 이수현
	 * 2019 - 12 - 30
	 * 
	 * 세션에 저장된(로그인한) 회원의 정보를 조회하여 예술인인지 구분(게시글 작성 제한)
	 * 
	 * 
	 * @param userno - 세션에 저장된 회원 번호
	 * @return Board(User_table) - 회원번호에 해당하는 회원정보
	 */
	public Board getUserByNo(Board userno);




	/**
	 * 이수현
	 * 2019 - 12 - 30
	 * 
	 * 댓글 입력
	 * 
	 * @param reply - 입력될 댓글
	 */
	public void insertReply(Reply reply) ;




	/**
	 * 
	 * 이수현
	 * 2019 - 12 - 30
	 * 
	 * 세션에 저장된 닉네임으로 회원번호 조회( 소셜로그인 회원 userno 조회)
	 * 
	 * @param loginUser - 세션의 usernick
	 * @return int(User_table) - userno
	 */
	public int getUsernoByUsernick(Board loginUser);




	/**
	 * 이수현
	 * 2019 - 12 - 31
	 * 
	 * 댓글 리스트
	 * 
	 * @param bno - 해당 게시글의 boardno
	 * @return List - 댓글리스트
	 */
	public List<Reply> getReplyList(Board bno);



}
