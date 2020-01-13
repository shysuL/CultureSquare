package mypage.service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import user.dto.User_table;
import util.MyPaging;
import util.Paging;

public interface MyPageService{

	public void modifyUserInfo(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자의 원래 개인정보 불러오기
	 * 
	 * @param user
	 */
	public User_table getUserInfo(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 비밀번호 변경 전 사용자의 현재 비밀번호 
	 * 
	 * @param user
	 */
	public User_table getFindUserPw(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 현재 비밀번호 확인
	 * 
	 * @param model
	 * @return
	 */
	public User_table getCurrentPwParam(Model model);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 비밀번호가 같은지 확인
	 * @param pwParam
	 * @return
	 */
	public boolean equalsPw(User_table pwParam);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 비밀번호 변경
	 * 
	 * @param pwParam
	 */
	public void modifyUserPassword(User_table pwParam);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 현재비밀번호와 변경할 비밀번호가 같은지 확인
	 * 
	 * @param user
	 * @return
	 */
	public boolean comparedPw(User_table user);

	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 사용자 닉네임 변경
	 * 
	 * @param usernick
	 * @return
	 */
	public int userNickCheck(String usernick);
	
	/**
	 * 2019-12
	 * 채해원
	 * 
	 * 회원탈퇴
	 * 
	 * @param user
	 */
	public void deleteUser(User_table user);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 마이페이지 페이징
	 * 
	 * @param paging
	 * @return
	 */
	public MyPaging getPaging(MyPaging paging);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 마이페이지 내가 좋아요한 글 목록
	 * @param result
	 * @return
	 */
	public List getLikeList(MyPaging result);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 마이페이지 내가 쓴 글 목록
	 * @param result
	 * @return
	 */
	public List getWriteList(MyPaging result);

	/**
	 * 2020-01
	 * 채해원
	 * 
	 * 마이페이지 댓글 목록
	 * 
	 * @param result
	 * @return
	 */
	public List getReplyList(MyPaging result);

	/**
	 * 2020-01-09
	 * 채해원
	 * 
	 * 마이페이지 페이징
	 * 
	 * @param paging
	 * @return
	 */
	public MyPaging getLikePaging(MyPaging paging);
	
	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 프로필 사진 파일 삽입
	 * 
	 * @param mFile
	 * @param userno
	 */
	public User_table fileSave(MultipartFile mFile, int userno);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 처음 올리는 이미지인 경우 이미지 업로드
	 * 
	 * @param mFile
	 * @param userno
	 */
	public void firstImageSave(MultipartFile mFile, int userno);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 사용자의 프로필 사진 조회
	 * 
	 * @param userno
	 * @return
	 */
	public User_table getFile(int userno);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 사용자의 프로필 사진이 존재하면 삭제
	 * 
	 * @param userphoto
	 */
	public void fileDelete(User_table userphoto);

	/**
	 * 2020-01-13
	 * 채해원
	 * 
	 * 사용자가 예술인 신청 버튼을 눌렀을 때 관리자의 승인이 있기 전의 상태로 만들기
	 * 
	 * @param user
	 */
	public void userupdate(User_table user);


}
