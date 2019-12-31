package prboard.dao.face;

import java.util.List;
import java.util.Map;

import prboard.dto.PRBoard;
import prboard.dto.PRType;
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
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PR 게시글 갯수를 구한다
	 * 
	 * @param map - 검색 조건 담긴 맵
	 * @return int - PR 게시글 갯수
	 */
	public int selectCntAll(Map<String, String> map);
}
