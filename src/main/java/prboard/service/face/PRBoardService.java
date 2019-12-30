package prboard.service.face;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import prboard.dto.PRBoard;
import prboard.dto.PRType;
import util.PRPaging;

public interface PRBoardService {
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PR 게시글 삽입
	 * 
	 * @param prBoard - 작성 내용이 담긴 객체
	 */
	public void writePR(PRBoard prBoard);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * 유저 닉네임을 통한 유저번혹 가져오기
	 * 
	 * @param userNick - 유저 닉네임
	 * @return int - 유저 번호
	 */
	public int getUserNoByUserNick(String userNick);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PRType 테이블 데이터 삽입
	 * 
	 * @param prType - prType 정보 데이터
	 */
	public void insertPRType(PRType prType);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * 첨부파일 삽입
	 * 
	 * @param mFile - 멀티 파일 처리해줄 정보가 담긴 객체
	 * @param boardNo - 게시판 번호
	 */
	public void fileSave(MultipartFile mFile, int boardNo);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * prwritedate를 현재 시간으로 업데이트
	 * 
	 * @param userNo - 유저 번호
	 */
	public void updatePrWriteDate(int userNo);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * prwritedate를 유저번호로 가져오기
	 * 
	 * @param userNo - 유저 번호
	 * @return String - prwritedate
	 */
	public String getWriteDate(int userNo);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * 글 작성시간과 현재시간 차이를 구한다
	 * 
	 * @param writeDate - 사용자가 최근에 작성한 시간
	 * @return int - 현재 시간과의 차이
	 */
	public int getTimePass(String writeDate);

	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * PR 게시글 전체 갯수를 구한다.
	 * 
	 * @return - PR 전체 개시글 갯수
	 */
	public int getCntAll();
	
	/**
	 * 2019-12-30
	 * 조홍철 
	 * 
	 * PR 게시판 리스트를 가져온다.
	 * 
	 * @param paging - 페이징 객체
	 * @return List - PR 게시글 리스트
	 */
	public List getList(PRPaging paging);
	
}
