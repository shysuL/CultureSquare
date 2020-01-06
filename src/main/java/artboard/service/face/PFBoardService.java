package artboard.service.face;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import artboard.dto.Board;
import artboard.dto.Donation;
import artboard.dto.Reply;

import prboard.dto.UpFile;

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



	/**
	 * 이수현
	 * 2019 - 12 - 31
	 * 
	 * 댓글 삭제
	 * 
	 * @param reply - 삭제할 댓글
	 * @return boolean - 삭제 성공 여부
	 */
	public boolean deleteReply(Reply reply);


	/**
	 * 조홍철
	 * 2020-01-02
	 * 
	 * 후원자 닉네임을 통한 후원자 번호 가져오기
	 * 
	 * @param donation - 후원자 닉네임이 담긴 객체
	 * @return Donation - 후원자 번호가 담긴 객체
	 */
	public Donation getUserNoByNick(Donation donation);


	/**
	 * 조홍철
	 * 2020-01-02
	 * 
	 * 후원테이블에 정보 삽입
	 * 
	 * @param donation - 삽입할 정보가 담긴 객체
	 */
	public void insertDonation(Donation donation);



	/**
	 * 이수현
	 * 2020-01-03
	 * 
	 * 댓글의 답글 입력
	 * 
	 * @param reply - 입력될 댓글
	 */
	public void insertRereply(Reply reply);



	/**
	 * 이수현
	 * 2020-01-06
	 * 
	 * 댓글 리스트 조회
	 * 
	 * @param reply - 게시판 번호가 담긴 객체
	 * @return List - 댓글 리스트
	 */
	public List<Reply> getReplyByboardNo(Reply reply);




	/**
	 * 2020-01-06
	 * 강성일
	 * 
	 * 첨부파일 사입
	 * 
	 * @param mFile - 멀티 파일을 처리해줄 정보가 담긴 객체
	 * @param boardno - 게시판 번호
	 */
	public void fileSave(MultipartFile mFile, int boardno);

	/**
	 * 2020-01-06
	 * 강성일
	 * 
	 * 게시글에 번호에 해당하는 파일 리스트를 가져온다.
	 * 
	 * boardno - 게시글 번호
	 * @return List - 파일 리스트
	 */
	public List<UpFile> getFileList(int boardno);
	
	
	/**
	 * 2020-01-06
	 * 강성일
	 * 
	 * 파일정보를 가져온다.
	 * 
	 * @param fileno - 사용자가 클릭한 파일의 번호
	 * @return UpFile - 파일정보가 담긴 객체
	 */
	public UpFile getFile(int fileno);
	
	
	/**
	 * 2020-01-07
	 * 강성일
	 * 
	 * 서버에 올라간 파일 삭제
	 * 
	 * @param list - 삭제할 파일이 담긴 리스트
	 */
	public void deleteServerFile(List<UpFile> list);
	
	/**
	 * 2020-01-07
	 * 강성일
	 * 
	 * DB에 있는 파일 삭제
	 * 
	 * @param list - 삭제할 파일이 담긴 리스트
	 */
	public void deleteFile(List<UpFile> list);
	
	
	
	


	public List<Board> getselectAll(Paging pfpaging);




	public int getTotalCnt(Board pfboard);




}
