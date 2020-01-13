package artboard.dao.face;

import java.util.List;

import artboard.dto.Board;
import artboard.dto.Donation;
import artboard.dto.PFUpFile;
import artboard.dto.Reply;

import util.Paging;

public interface PFBoardDao {

	
	
	/**
	 * 이수현
	 * 2019 - 12 - 30
	 * 
	 * 연+월에 해당하는 게시글 리스트 조회
	 * 
	 * 
	 * @param searchMonth - 연 + 월 
	 * @return List<Board> - 게시글 리스트
	 */
	public List<Board> selectAll3(Board board);
	
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

	/**
	 * 이수현
	 * 2019 - 12 - 30
	 * 
	 * userno에 해당하는 회원정보 조회
	 * 
	 * @param userno - 로그인 회원의 회원번호
	 * @return Board(User_table) - 회원 정보
	 */
	public Board selectUserByNo(Board userno);

	
	/**
	 * 이수현
	 * 2019 - 12 - 30
	 *
	 * 조회되는 게시글의 조회수 +1
	 * 
	 * @param bno - 조회 대상
	 */
	public void updateViews(Board bno);

	
	/**
	 * 이수현
	 * 2019 - 12 - 30
	 * 
	 * usernick으로 userno 조회
	 * 
	 * 
	 * @param loginUser - usernick
	 * @return int(User_table) - userno
	 */
	public int selectUsernoByUsernick(Board loginUser);

	/**
	 * 조홍철
	 * 2020-01-02
	 * 
	 * 후원자 닉네임을 통한 후원자 번호 조회
	 * 
	 * @param donation - 후원자 닉네임이 담긴 객체
	 * @return int - 후원자 번호
	 */
	public int selectNoForDonation(Donation donation);
	
	/**
	 * 조홍철
	 * 2020-01-02
	 * 
	 * 후원테이블에 정보 삽입
	 * 
	 * @param donation - 삽입할 정보가 담긴 객체
	 */
	public void insertDonation(Donation donation);

	public int selectPfCnt(Board pfboard);

	
	/**
	 * 2020-01-07
	 * 강성일
	 * 
	 * 첨부파일 삽입
	 * 
	 * @param upFile - 첨부파일 데이터가 들어있는 객체
	 */
	public void insertFile(PFUpFile upfile);

	/**
	 * 2020-01-07
	 * 강성일
	 * 
	 * 게시글에 번호에 해당하는 파일 리스트를 가져온다.
	 * 
	 * boardno - 게시글 번호
	 * @return List - 파일 리스트
	 */
	public List<PFUpFile> selectFileList(int boardno);

	/**
	 * 2020-01-07
	 * 강성일
	 * 
	 * 파일정보를 가져온다.
	 * 
	 * @param fileno - 사용자가 클릭한 파일의 번호
	 * @return UpFile - 파일정보가 담긴 객체
	 */
	public PFUpFile selectFileByFileno(int fileno);

	/**
	 * 2020-01-07
	 * 이수현
	 * 
	 * 추천 여부 조회
	 * 
	 * 
	 * @param Board - 추천 여부 정보가 담긴 객체
	 * @return int - 추천 여부
	 */
	public int selectRecommend(Board board);

	/**
	 * 2020-01-07
	 * 이수현
	 * 
	 * 추천테이블에 데이터를 삽입한다.
	 * 
	 * @param Board - 추천테이블에 삽입할 데이터가 담긴 객체
	 */
	public void insertRecommend(Board board);

	/**
	 * 2020-01-07
	 * 이수현
	 * 
	 * 추천테이블에서 데이터를 삭제한다.
	 * 
	 * @param prBoard - 추천테이블에서 삭제할 데이터가 담긴 객체
	 */
	public void deleteRecommend(Board board);

	/**
	 * 2020-01-07
	 * 이수현
	 * 
	 * 게시글의 추천 갯수를 센다
	 * 
	 * @param Board - 게시글 정보가 담긴 객체
	 * @return int - 추천수
	 */
	public int selectrecommendView(Board board);

	/**
	 * 2020-01-08
	 * 이수현
	 * 
	 * 댓글번호를 통해 그룹 번호 가져오기
	 * 
	 * @param reply - 댓글 번호가 담긴 객체
	 * @return int - 그룹번호
	 * 
	 */
	public int selectGroupNo(Reply reply);

	/**
	 * 2020-01-06
	 * 이수현
	 * 
	 * 답글 리스트 조회
	 * 
	 * @param reply - 그룹 번호
	 * @return List - 답글 리스트
	 */
	public List<Reply> selectReReplyList(int groupNo);

	/**
	 * 2020-01-08
	 * 이수현
	 * 
	 * 댓글의 답글 갯수 조회
	 * 
	 * @param groupno - 댓글의 그룹 번호
	 * @return int - 답글 갯수
	 */	
	public int selectREreplyCnt(int groupno);

	/**
	 * 2020-01-08
	 * 이수현
	 * 
	 * 유저 번호 조회
	 * 
	 * @param usernick - 유저 닉네임
	 * @return Reply -유저 번호가 담긴 객체
	 */
	public Reply selectUserNoToReply(String usernick);

	/**
	 * 2020-01-08
	 * 이수현
	 * 
	 * 최대 그룹번호 값을 가져온다.
	 * 
	 * @param reply - 그룹번호가 담긴 객체
	 * @return int - 최대 그룹번호
	 */
	public int selectMaxReplyOrder(Reply reply);

	/**
	 * 2020-01-08
	 * 이수현
	 * 
	 * 답글 삽입
	 * 
	 * @param reply - 삽입할 답글 정보가 담긴 객체
	 */
	public void insertReReply(Reply reply);

	/**
	 * 2020-01-10
	 * 이수현
	 * 
	 * artboard 게시판 내용을 수정한다
	 * 
	 * @param board - 수정 내용이 담긴 객체
	 */
	public void updatePF(Board board);

	/**
	 * 2020-01-10
	 * 이수현
	 * 
	 * artboard게시판 내용을 수정한다
	 * 
	 * @param board - 수정 내용이 담긴 객체
	 */
	public void updatePFAdd(Board board);

	/**
	 * 2020-01-10
	 * 이수현
	 * 
	 * PR 게시판 첨부파일을 삭제한다
	 * 
	 * @param boardno - 게시글 번호
	 */
	public void deleteFile(int boardno);

	/**
	 * 2020-01-10
	 * 이수현
	 * 
	 * 게시글 삭제( 삭제된 게시글로 UPDATE )
	 * 
	 * @param prBoard - 삭제할 게시글 정보가 담긴 객체
	 */	
	public void updatePFbyDelete(Board board);

	/**
	 * 2020-01-11
	 * 이수현
	 * 
	 * 댓글 수정
	 * 
	 * @param reply - 댓글 번호가 담긴 객체
	 */
	public void updateReplyByNo(Reply reply);

	/**
	 * 2020-01-11
	 * 이수현
	 * 
	 * 답글 삭제(댓글 삭제할때)
	 *  
	 * @param groupNo - 삭제될 답글의 그룹 번호
	 */
	public void deleteReReplyByGroupNo(int groupNo);
	
	
}
