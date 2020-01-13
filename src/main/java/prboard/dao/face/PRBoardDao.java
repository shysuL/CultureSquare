package prboard.dao.face;

import java.util.List;
import java.util.Map;

import prboard.dto.Alram;
import prboard.dto.PRBoard;
import prboard.dto.PRType;
import prboard.dto.Reply;
import prboard.dto.UpFile;
import util.PRPaging;

public interface PRBoardDao {
	

	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PR 게시글 작성
	 * 
	 * @param prBoard - 작성 내용이 담긴 객체
	 */
	public void insertPR(PRBoard prBoard);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * 유저 닉네임을 통한 유저번혹 가져오기
	 * 
	 * @param userNick - 유저 닉네임
	 * @return int - 유저 번호
	 */
	public int selectUserNoByUserNick(String userNick);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PRType 테이블 데이터 삽입
	 * 
	 * @param prType - prType 내용이 담긴 객체
	 */
	public void insertPRType(PRType prType);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * 첨부파일 삽입
	 * 
	 * @param upFile - 첨부파일 데이터가 들어있는 객체
	 */
	public void insertFile(UpFile upFile);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PRWRITEDATE를 현재시간으로 업데이트
	 * 
	 * @param userNo - 유저 번호
	 */
	public void updateWritePrDate(int userNo);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * prwritedate를 유저번호로 가져오기
	 * 
	 * @param userNo - 유저 번호
	 * @return String - prwritedate
	 */
	public String selectWriteDate(int userNo);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * 글 작성시간과 현재시간 차이를 구한다
	 * 
	 * @param writeDate - 사용자가 최근에 작성한 시간
	 * @return int - 현재 시간과의 차이
	 */
	public int selectTimePass(String writeDate);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PR 게시글 리스트를 구한다.
	 * 
	 * @param paging - 페이징 객체
	 * @return List - PR 게시글 리스트
	 */
	public List selectAll(PRPaging paging);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * PR 게시글 갯수를 구한다
	 * 
	 * @param map - 검색 조건 담긴 맵
	 * @return int - PR 게시글 갯수
	 */
	public int selectCntAll(Map<String, String> map);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * 게시글 세부정보 조회
	 * 
	 * @param boardno - 게시글 번호
	 * @return PRBoard - 게시글 세부정보가 담긴 객체
	 */
	public PRBoard selectViewInfo(int boardno);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * 조회수를 1 증가시킨다.
	 * 
	 * @param boardno - 게시글 번호
	 */
	public void hit(int boardno);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * 게시글에 번호에 해당하는 파일 리스트를 가져온다.
	 * 
	 * boardno - 게시글 번호
	 * @return List - 파일 리스트
	 */
	public List<UpFile> selectFileList(int boardno);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * 파일정보를 가져온다.
	 * 
	 * @param fileno - 사용자가 클릭한 파일의 번호
	 * @return UpFile - 파일정보가 담긴 객체
	 */
	public UpFile selectFileByFileno(int fileno);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * PR 게시판 내용을 수정한다
	 * 
	 * @param prBoard - 수정 내용이 담긴 객체
	 */
	public void updatePR(PRBoard prBoard);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * PR 게시판 유형을 수정한다
	 * 
	 * @param prBoard - 수정 내용이 담긴 객체
	 */
	public void updatePRType(PRBoard prBoard);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * PR 게시판 첨부파일을 삭제한다
	 * 
	 * @param boardno - 게시글 번호
	 */
	public void deleteFile(int boardno);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * PR 유형 삭제
	 * 
	 * @param prBoard - 삭제할 게시글 정보가 담긴 객체
	 */
	public void deletePRType(PRBoard prBoard);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * 게시글 삭제
	 * 
	 * @param prBoard - 삭제할 게시글 정보가 담긴 객체
	 */
	public void deletePR(PRBoard prBoard);

	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 유저 번호 조회
	 * 
	 * @param usernick - 유저 닉네임
	 * @return PRBoard -유저 번호가 담긴 객체
	 */
	public PRBoard selectUserNoToLike(String usernick);
	
	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 추천 여부 조회
	 * 
	 * 
	 * @param prBoard - 추천 여부 정보가 담긴 객체
	 * @return int - 추천 여부
	 */
	public int selectRecommend(PRBoard prBoard);

	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 추천테이블에 데이터를 삽입한다.
	 * 
	 * @param prBoard - 추천테이블에 삽입할 데이터가 담긴 객체
	 */
	public void insertRecommend(PRBoard prBoard);
	
	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 추천테이블에서 데이터를 삭제한다.
	 * 
	 * @param prBoard - 추천테이블에서 삭제할 데이터가 담긴 객체
	 */
	public void deleteRecommend(PRBoard prBoard);

	
	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 게시글의 추천 갯수를 센다
	 * 
	 * @param prBoard - 게시글 정보가 담긴 객체
	 * @return int - 추천수
	 */
	public int selectrecommendView(PRBoard prBoard);

	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 좋아요 삭제
	 * 
	 * @param prBoard - 삭제할 게시글 정보가 담긴 객체
	 */
	public void deleteBlike(PRBoard prBoard);

	
	/**
	 * 2020-01-03
	 * 조홍철
	 * 
	 * 유저 번호 조회
	 * 
	 * @param usernick - 유저 닉네임
	 * @return Reply -유저 번호가 담긴 객체
	 */
	public Reply selectUserNoToReply(String usernick);

	/**
	 * 2020-01-03
	 * 조홍철
	 * 
	 * 댓글 리스트 조회
	 * 
	 * @param reply - 게시판 번호가 담긴 객체
	 * @return List - 댓글 리스트
	 */
	public List<Reply> selectReplyList(Reply reply);

	/**
	 * 2020-01-03
	 * 조홍철
	 * 
	 * 댓글 삭제(게시판 삭제될때)
	 * 
	 * @param prBoard - 게시판 번호
	 */
	public void deleteReplyToBoard(PRBoard prBoard);

	/**
	 * 2020-01-03
	 * 조홍철
	 * 
	 * 댓글 삽입
	 * 
	 * @param reply - 삽입될 댓글 정보가 저장된 객체
	 */
	public void insertReply(Reply reply);

	/**
	 * 2020-01-04
	 * 조홍철
	 * 
	 * 댓글 삭제(댓글 삭제 버튼 눌렀을때)
	 * 
	 * @param reply - 댓글 번호가 담긴 객체
	 */
	public void deleteReplyByNo(Reply reply);

	/**
	 * 2020-01-04
	 * 조홍철
	 * 
	 * 댓글 수정
	 * 
	 * @param reply - 댓글 번호가 담긴 객체
	 */
	public void updateReplyByNo(Reply reply);

	/**
	 * 2020-01-06
	 * 조홍철
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
	 * 조홍철
	 * 
	 * 답글 리스트 조회
	 * 
	 * @param reply - 그룹 번호
	 * @return List - 답글 리스트
	 */
	public List<Reply> selectReReplyList(int groupNo);

	/**
	 * 2020-01-06
	 * 조홍철
	 * 
	 * 댓글의 답글 갯수 조회
	 * 
	 * @param groupno - 댓글의 그룹 번호
	 * @return int - 답글 갯수
	 */
	public int selectREreplyCnt(int groupno);

	/**
	 * 2020-01-07
	 * 조홍철
	 * 
	 * 답글 삭제(댓글 삭제할때)
	 *  
	 * @param groupNo - 삭제될 답글의 그룹 번호
	 */
	public void deleteReReplyByGroupNo(int groupNo);

	/**
	 * 2020-01-07
	 * 조홍철
	 * 
	 * 최대 그룹번호 값을 가져온다.
	 * 
	 * @param reply - 그룹번호가 담긴 객체
	 * @return int - 최대 그룹번호
	 */
	public int selectMaxReplyOrder(Reply reply);

	/**
	 * 2020-01-07
	 * 조홍철
	 * 
	 * 답글 삽입
	 * 
	 * @param reply - 삽입할 답글 정보가 담긴 객체
	 */
	public void insertReReply(Reply reply);

	/**
	 * 2020-01-07
	 * 조홍철
	 * 
	 * 댓글 좋아요를 위한 유저번호 조회
	 * 
	 * @param usernick - 유저 닉네임
	 * @return Reply - 유저번호가 담긴 댓글 객체
	 */
	public Reply selectUserNoToReplyLike(String usernick);

	/**
	 * 2020-01-07
	 * 조홍철
	 * 
	 * 추천 여부 조회
	 * 
	 * 
	 * @param reply - 추천 여부 정보가 담긴 객체
	 * @return int - 추천 여부
	 */
	public int selectReplyRecommend(Reply reply);

	/**
	 * 2020-01-07
	 * 조홍철
	 * 
	 * 댓글의 추천 갯수를 센다
	 * 
	 * @param prBoard - 댓글 정보가 담긴 객체
	 * @return int - 추천수
	 */
	public int selectReplyRecommendView(Reply reply);

	/**
	 * 2020-01-08
	 * 조홍철
	 * 
	 * 댓글 추천을 한다.
	 * 
	 * @param reply - 댓글 추천 테이블에 삽입할 데이터 객체
	 */
	public void insertReplyRecommend(Reply reply);

	/**
	 * 2020-01-08
	 * 조홍철
	 * 
	 * 댓글 추천 취소를 한다.
	 * 
	 * @param reply - 댓글 추천 테이블에 삭제할 데이터 객체
	 */
	public void deleteReLike(Reply reply);

	/**
	 * 2020-01-08
	 * 조홍철
	 * 
	 * 댓글 좋아요 삭제
	 * 
	 * @param replyno - 삭제할 댓글 번호
	 */
	public void deleteReLikeForBoard(int replyno);

	/**
	 * 2020-01-08
	 * 조홍철
	 * 
	 * 베스트 댓글 리스트 조회
	 * 
	 * @param reply - 댓글 정보 객체
	 * @return List - 답글 리스트
	 */
	public List<Reply> selectBestReplyList(Reply reply);

	/**
	 * 2020-01-08
	 * 조홍철
	 * 
	 * 답글 많은 순 댓글 리스트 조회
	 * 
	 * @param reply - 댓글 정보 객체
	 * @return List - 답글 리스트
	 */
	public List<Reply> selectMostReplyList(Reply reply);

	/**
	 * 2019-01-09
	 * 조홍철
	 * 
	 * PR 게시글 리스트를 조회수로 정렬해서 구한다.
	 * 
	 * @param paging - 페이징 객체
	 * @return List - 조회수로 정렬 된 PR 게시글 리스트
	 */
	public List selectAllByViews(PRPaging paging);

	/**
	 * 2019-01-09
	 * 조홍철
	 * 
	 * PR 게시글 리스트를 좋아요로 정렬해서 구한다.
	 * 
	 * @param paging - 페이징 객체
	 * @return List - 좋아요로 정렬 된 PR 게시글 리스트
	 */
	public List selectAllByLike(PRPaging paging);

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 댓글 알림 삽입을 위해 글 작성자 번호를 가져온다.
	 * 
	 * @param boardno -게시판 번호
	 * @return int - 글 작성자 번호
	 */
	public int selectUserNoByBoardNo(int boardno);

	/**
	 * 2020-01-13
	 * 조홍철
	 * 
	 * 댓글 알림 삽입
	 * 
	 * @param alram - 삽입할 알림 정보가 담긴 객체
	 */
	public void insertReplyAlram(Alram alram);
}
