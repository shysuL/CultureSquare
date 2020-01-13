package artboard.dao.face;

import artboard.dto.Board;

public interface FollowDao {

	public void insertFollow(Board board);

	public void deleteFollow(Board board);

	public int selectFollowView(Board board);

	public int selectFollow(Board board);

}
