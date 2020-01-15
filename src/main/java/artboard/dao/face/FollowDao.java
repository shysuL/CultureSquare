package artboard.dao.face;

import artboard.dto.Board;

public interface FollowDao {

	/**
	 * 2020-01-13
	 * 이수현
	 * 
	 * 팔로우
	 *  
	 * @param board - 팔로우테이블에 들어갈 객체
	 */
	public void insertFollow(Board board);

	/**
	 * 2020-01-13
	 * 이수현
	 * 
	 * 팔로우 취소
	 *  
	 * @param board - 팔로우테이블에 들어갈 객체
	 */
	public void deleteFollow(Board board);

	/**
	 * 2020-01-13
	 * 이수현
	 * 
	 * 게시글의 추천 갯수를 센다
	 * 
	 * @param Board - 게시글 정보가 담긴 객체
	 * @return int - 팔로우 수
	 */
	public int selectFollowView(Board board);

	/**
	 * 2020-01-13
	 * 이수현
	 * 
	 * 팔로우 여부 조회
	 * 
	 * @param Board - 팔로우 여부 조회할 정보가 담긴 객체
	 * @return int - 팔로우 여부
	 */
	public int selectFollow(Board board);

}
