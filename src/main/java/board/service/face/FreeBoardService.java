package board.service.face;

import java.util.List;

import board.dto.FreeBoard;
import util.Paging;

public interface FreeBoardService {
	
	/** 2019 - 12 - 23
	 * 게시판 리스트 총 개수
	 * 
	 */
	public int getListCnt();
	
	
	/** 2019 - 12 - 23
	 * 게시판 리스트 페이징
	 * 
	 * @param paging
	 * @return
	 */
	public List<FreeBoard> getList(Paging paging);

	FreeBoard getView(int boardno);

}
