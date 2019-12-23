package artboard.service.face;

import java.util.List;

import artboard.dto.PFBoard;
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
	public List<PFBoard> getList(Paging paging);

	/**
	 * 
	 * 이수현
	 * 2019 - 12 - 23
	 * 
	 * paging 객체의 totalPage를 얻는 메소드
	 * 
	 * @return int - totalPage 개수
	 */
	public int getTotalPage();
	
	

}
