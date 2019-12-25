package board.dao.face;

import java.util.List;

import board.dto.FreeBoard;
import util.Paging;

public interface FreeBoardDao {

	public List<FreeBoard> selectAll(Paging paging);

	public int selectCnt();

	public FreeBoard selectDetail(int boardno);

}
