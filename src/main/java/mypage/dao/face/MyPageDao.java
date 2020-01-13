package mypage.dao.face;

import java.util.HashMap;
import java.util.List;

import user.dto.User_table;
import util.MyPaging;
import util.Paging;

public interface MyPageDao {

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자의 닉네임 수정
	 * 
	 * @param user
	 */
	public void updateUserInfo(User_table user);
	
	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 개인정보 수정
	 * 
	 * @param user
	 * @return
	 */
	public User_table selectUserAll(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 비밀번호 변경을 위한 아이디 확인
	 * 
	 * @param user
	 * @return
	 */
	public User_table selectByUserPw(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 비밀번호가 맞는 지 확인
	 * 
	 * @param pwParam
	 * @return
	 */
	public int selectCntByUserPw(User_table pwParam);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 변경한 비밀번호로 비밀번호 변경
	 * 
	 * @param pwParam
	 */
	public void updatePassword(User_table pwParam);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 현재비밀번호와 변경할 비밀번호가 동등한지 확인
	 * 
	 * @param lockPw
	 * @return
	 */
	public int selectComparedPw(String lockPw);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자의 닉네임 불러오기
	 * 
	 * @param usernick
	 * @return
	 */
	public int selectUserNick(String usernick);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 회원탈퇴
	 * 
	 * @param user
	 */
	public void deleteUserId(User_table user);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 마이페이지 페이징을 위한 게시글 개수
	 * 
	 * @param paging
	 * @return
	 */
	public int selectCntAll(MyPaging paging);
	
	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 마이페이지 내가 좋아요한 개수의 페이징을 위한 게시글 개수
	 * @param paging
	 * @return
	 */
	public int selectLikeCntAll(MyPaging paging);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 사용자가 좋아요한 게시글 불러오기
	 * 
	 * @param paging
	 * @return
	 */
	public List<HashMap<String, Object>> selectLikePost(MyPaging paging);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 사용자가 작성한 게시글 불러오기
	 * 
	 * @param paging
	 * @return
	 */
	public List<HashMap<String, Object>> selectWritePost(MyPaging paging);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 사용자가 작성한 댓글 불러오기
	 * 
	 * @param paging
	 * @return
	 */
	public List<HashMap<String, Object>> selectReplyPost(MyPaging paging);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 사용자의 프로필 사진 등록
	 * 
	 * @param user
	 * @return
	 */
	public void insertPhoto(User_table user);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 사용자의 프로필 사진 조회
	 * 
	 * @param userno
	 * @return
	 */
	public User_table selectFile(int userno);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 사용자의 프로필 사진 삭제
	 * 
	 * @param userphoto
	 */
	public void deleteFile(User_table userphoto);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 사용자가 신청한 예술인등업의 관리자 승인전 단계로
	 * permit을 1로 업데이트함.
	 * 
	 * @param user
	 */
	public void updateUserPermit(User_table user);

}
