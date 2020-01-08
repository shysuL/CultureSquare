package user.service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.dto.User_table;

public interface UserService {

	/**
	 * 2019-12-25 
	 * 이빈
	 * 받아온 회원가입 정보 DB에 넣어주기
	 * @param user - 요청으로 받아온 회원가입 정보
	 * @return - int
	 */
	public int joinProc(User_table user);

	
	/** 
	 * 2019-12-25
	 * 이빈
	 * 아이디 중복체크 하기(AJAX)
	 * @param userid - 입력한 아이디
	 * @return - int (0 : 사용가능, 1 : 중복닉네임 )
	 */
	public int userIdCheck(String userid);

	/**
	 * 2019-12-26
	 * 이빈
	 * 닉네임 중복체크 하기(AJAX)
	 * @param usernick - 입력한 닉네임
	 * @return - int (0 : 사용가능, 1 : 중복닉네임 )
	 */
	public int userNickCheck(String usernick);

	/** 수정중 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	 * 2019-12-27
	 * 이빈
	 * 로그인
	 * @param user - 입력한 아이디 / 패스워드
	 * @param userCheck - 쿠키 체크 여부
	 * @param session - 세션
	 * @return 0:기본값, 1:로그인성공, 2:입력한아이디가 없을경우, 3:비밀번호가 다른경우, 4:이메일 인증하지 않은 경우
	 */
	public int loginProc(User_table user, HttpSession session, String userCheck, HttpServletResponse resp);

	/**
	 * 2019-12-27
	 * 이빈
	 * 세션저장을 위한 아이디로 사용자 정보 얻기
	 * @param user - id
	 * @return 
	 */
	public User_table getUserSession(User_table user);

	/**
	 * 2020-01-08
	 * 이빈
	 * 이름과 핸드폰번호로 userid 찾기
	 * @param user - username, userphone
	 * @return - List<user_table> 
	 */
	public List<User_table> getUseridByNamePhone(User_table user);

	
}
