package prboard.service.face;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import prboard.dto.PRBoard;
import prboard.dto.PRType;
import prboard.dto.UpFile;
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
	 * 2019-12-31
	 * 조홍철
	 * 
	 * PR 게시글 전체 갯수를 구한다.
	 * 
	 * @param map - 검색 조건 담긴 맵
	 * @return  int - PR 전체 개시글 갯수
	 */
	public int getCntAll(Map<String, String> map);
	
	/**
	 * 2019-12-31
	 * 조홍철 
	 * 
	 * PR 게시판 리스트를 가져온다.
	 * 
	 * @param paging - 페이징 객체
	 * @return List - PR 게시글 리스트
	 */
	public List getList(PRPaging paging);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * PR 게시글 세부정보를 가져온다.
	 * 
	 * @param boardno - 게시글 번호
	 * @return PRBoard - 게시글 세부정보가 담긴 객체
	 */
	public PRBoard getViewInfo(int boardno);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * 게시글에 번호에 해당하는 파일 리스트를 가져온다.
	 * 
	 * boardno - 게시글 번호
	 * @return List - 파일 리스트
	 */
	public List<UpFile> getFileList(int boardno);
	
	/**
	 * 2019-12-31
	 * 조홍철
	 * 
	 * 파일정보를 가져온다.
	 * 
	 * @param fileno - 사용자가 클릭한 파일의 번호
	 * @return UpFile - 파일정보가 담긴 객체
	 */
	public UpFile getFile(int fileno);
	
	/**
	 * 2019-12-30
	 * 조홍철
	 * 
	 * 처음 올리는 이미지인 경우 이미지 업로드
	 * 
	 * @param mFile - 멀티 파일 처리해줄 정보가 담긴 객체
	 * @param boardno - 게시판 번호
	 */
	public void firstImageSave(MultipartFile mFile, int boardno);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * 게시글 내용 수정
	 * 
	 * @param prBoard - 게시글 내용이 담긴 객체
	 */
	public void modifyPR(PRBoard prBoard);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * 대표 이미지 삭제
	 * 
	 * @param boardno - 게시글 번호
	 */
	public void deleteThumbnail(int boardno);
	
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * 서버에 올라간 파일 삭제
	 * 
	 * @param list - 삭제할 파일이 담긴 리스트
	 */
	public void deleteServerFile(List<UpFile> list);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * DB에 있는 파일 삭제
	 * 
	 * @param list - 삭제할 파일이 담긴 리스트
	 */
	public void deleteFile(List<UpFile> list);
	
	/**
	 * 2020-01-01
	 * 조홍철
	 * 
	 * PR 유형 테이블 삭제
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
	 * 202-01-02
	 * 조홍철
	 * 
	 * 유저 번호 조회
	 * 
	 * @param usernick - 유저 닉네임
	 * @return PRBoard - 유저 번호가 담긴 객체
	 */
	public PRBoard getUserNoByNick(String usernick);
	
	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 추천 여부 조회
	 * 
	 * @param prBoard - 추천 여부 조회할 정보가 담긴 객체
	 * @return int - 추천 여부
	 */
	public int recommendCheck(PRBoard prBoard);

	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 추천을 한다.
	 * 
	 * @param prBoard - 추천 테이블에 삽입할 데이터 객체
	 */
	public void recommend(PRBoard prBoard);

	
	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 추천 취소를 한다..
	 * 
	 * @param prBoard - 추천 테이블에서 삭제할 데이터 객체
	 */
	public void recommendCancal(PRBoard prBoard);

	/**
	 * 2020-01-02
	 * 조홍철
	 * 
	 * 게시글의 추천 갯수를 센다
	 * 
	 * @param prBoard - 게시글 정보가 담긴 객체
	 * @return int - 추천수
	 */
	
	public int recommendView(PRBoard prBoard);

	/**
	 * 2020-01-03
	 * 조홍철
	 * 
	 * 좋아요 테이블 삭제
	 * @param prBoard - 삭제할 게시글 정보가 담긴 객체
	 */
	public void deleteBlike(PRBoard prBoard);

}
