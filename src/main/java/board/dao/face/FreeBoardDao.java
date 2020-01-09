package board.dao.face;

import java.util.List;
import java.util.Map;

import board.dto.FreeBoard;
import board.dto.Reply;
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
	
	
	/**
	 * 2019-12-25
	 * 고인호
	 * 
	 * 자유게시판 게시글 전체 개수
	 * 
	 * @param searchtarget - 검색어
	 * @param searchcategory - 검색조건
	 * @return
	 */
	public int selectCnt(Map<String, String> map);

	
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
	 * @return FreeBoard - 로그인한 유저 정보와 일치하는 닉네임
	 */
	public FreeBoard selectByUserNick(Object attribute);

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

	/**
	 * 2020-01-03
	 * 고인호
	 * 
	 * 추천 여부 조회
	 * 
	 * @param prBoard - 추천 여부 정보가 담긴 객체
	 * @return int - 추천 여부
	 */
	public int selectRecommend(FreeBoard freeBoard);

	/**
	 * 2020-01-03
	 * 고인호
	 * 
	 * 추천테이블에 데이터를 삽입한다.
	 * 
	 * @param prBoard - 추천테이블에 삽입할 데이터가 담긴 객체
	 */
	public void insertRecommend(FreeBoard freeBoard);

	/**
	 * 2020-01-03
	 * 고인호
	 * 
	 * 추천테이블에서 데이터를 삭제한다.
	 * 
	 * @param prBoard - 추천테이블에서 삭제할 데이터가 담긴 객체
	 */
	public void deleteRecommend(FreeBoard freeBoard);

	/**
	 * 2020-01-03
	 * 고인호
	 * 
	 * 게시글의 추천 갯수를 센다
	 * 
	 * @param prBoard - 게시글 정보가 담긴 객체
	 * @return int - 추천수
	 */
	public int selectrecommendView(FreeBoard freeBoard);

	/**
	 * 2020-01-03
	 * 고인호
	 * 
	 * 좋아요 삭제
	 * 
	 * @param boardno - 삭제할 게시글 번호가 담긴 객체
	 */
	public void deleteBlike(int boardno);

	/**
	 * 2019-01-03
	 * 고인호
	 * 
	 * 댓글 입력
	 * 
	 * @param reply - 입력될 댓글
	 */
	public void insertReply(Reply reply);

	/**
	 * 2019-01-03
	 * 고인호
	 * 
	 * 댓글 리스트
	 * 
	 * @param boardno - 댓글 리스트 조회할 게시글번호
	 * @return - 조회된 게시글 댓글 리스트
	 */
	public List<Reply> selectReply(int boardno);

	/**
	 * 2020 - 01 - 09
	 * 고인호
	 * 
	 * 댓글 삭제
	 * 
	 * @param reply - 삭제할 댓글
	 * @return boolean - 삭제 성공 여부
	 */
	public void deleteReply(Reply reply);

	/**
	 * 2020 - 01 - 09
	 * 고인호
	 * 
	 * 댓글 카운트 - 댓글 존재 여부 확인
	 * 
	 * @param reply - 존재 여부 체크 대상 댓글
	 * @return int - 댓글 갯수
	 */
	public int countReply(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 댓글의 답글 갯수 조회
	 * 
	 * @param groupno - 댓글의 그룹 번호
	 * @return int - 답글 갯수
	 */
	public int selectREreplyCnt(int groupno);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 댓글번호를 통해 그룹 번호 가져오기
	 * 
	 * @param reply - 댓글 번호가 담긴 객체
	 * @return int - 그룹번호
	 * 
	 */
	public int selectGroupNo(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 댓글 수정
	 * 
	 * @param reply - 댓글 번호가 담긴 객체
	 */
	public void updateReplyByNo(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 답글 리스트 조회
	 * 
	 * @param reply - 그룹 번호
	 * @return List - 답글 리스트
	 */
	public List<Reply> selectReReplyList(int groupNo);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 최대 그룹번호 값을 가져온다.
	 * 
	 * @param reply - 그룹번호가 담긴 객체
	 * @return int - 최대 그룹번호
	 */
	public int selectMaxReplyOrder(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 답글 삽입
	 * 
	 * @param reply - 삽입할 답글 정보가 담긴 객체
	 */
	public void insertReReply(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 댓글 좋아요를 위한 유저번호 조회
	 * 
	 * @param usernick - 유저 닉네임
	 * @return Reply - 유저번호가 담긴 댓글 객체
	 */
	public Reply selectUserNoToReplyLike(String usernick);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 추천 여부 조회
	 * 
	 * 
	 * @param reply - 추천 여부 정보가 담긴 객체
	 * @return int - 추천 여부
	 */
	public int selectReplyRecommend(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 댓글의 추천 갯수를 센다
	 * 
	 * @param prBoard - 댓글 정보가 담긴 객체
	 * @return int - 추천수
	 */
	public int selectReplyRecommendView(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 댓글 추천을 한다.
	 * 
	 * @param reply - 댓글 추천 테이블에 삽입할 데이터 객체
	 */
	public void insertReplyRecommend(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 댓글 추천 취소를 한다.
	 * 
	 * @param reply - 댓글 추천 테이블에 삭제할 데이터 객체
	 */
	public void deleteReLike(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 베스트 댓글 리스트 조회
	 * 
	 * @param reply - 댓글 정보 객체
	 * @return List - 답글 리스트
	 */
	public List<Reply> selectBestReplyList(Reply reply);

	/**
	 * 2020-01-09
	 * 고인호
	 * 
	 * 답글 많은 순 댓글 리스트 조회
	 * 
	 * @param reply - 댓글 정보 객체
	 * @return List - 답글 리스트
	 */
	public List<Reply> selectMostReplyList(Reply reply);

}
