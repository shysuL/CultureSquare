package user.service.face;

import user.dto.User_table;

public interface UserService {

	/**
	 * 2019-12-25 이빈
	 * 받아온 회원가입 정보 DB에 넣어주기
	 * @param user - 요청으로 받아온 회원가입 정보
	 * @return - int
	 */
	public int joinProc(User_table user);

}
