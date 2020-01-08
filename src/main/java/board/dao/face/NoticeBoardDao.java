package board.dao.face;

import java.util.List;
import java.util.Map;

import board.dto.FreeBoard;
import util.Paging;

public interface NoticeBoardDao {

	public List<FreeBoard> selectAll(Paging paging);

	public int selectCnt(Map<String, String> map);

	public FreeBoard selectnoticeDetail(int boardno);

	public void insertnoticeBoard(FreeBoard noticeboard);

	public void updateViews(int boardno);

	public FreeBoard selectByUserNick(Object attribute);

	public List<FreeBoard> selectViewsAll();

}
