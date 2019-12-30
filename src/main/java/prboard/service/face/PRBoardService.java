package prboard.service.face;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import prboard.dto.PRBoard;
import prboard.dto.PRType;

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

}
