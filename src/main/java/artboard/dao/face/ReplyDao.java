package artboard.dao.face;

import java.util.List;

import artboard.dto.Board;
import artboard.dto.Reply;

public interface ReplyDao {

	/**
	 * 이수현
	 * 2019 - 12 - 31
	 * 
	 * 댓글 INSERT
	 * 
	 * @param comment - 입력될 댓글
	 */
	public void insert(Reply reply);

	/**
	 * 이수현
	 * 2019 - 12 - 31
	 * 
	 * 댓글 리스트 조회 - 코멘트 번호를 rnum을 통해 같이 조회
	 * 
	 * @param bno - 댓글이 조회될 게시글
	 * @return List - 조회된 댓글 리스트
	 */
	public List<Reply> selectReply(Board bno);

	
	/**
	 * 이수현
	 * 2019 - 12 - 31
	 * 
	 * 댓글 삭제하기
	 * 
	 * @param reply 삭제할 댓글
	 */
	public void deleteReply(Reply reply);

	
	/**
	 * 이수현
	 * 2019 - 12 - 31
	 * 
	 * 댓글 카운트 - 댓글 존재 여부 확인
	 * 
	 * @param reply - 존재 여부 체크 대상 댓글
	 * @return int - 댓글 갯수
	 */
	public int countReply(Reply reply);

}
