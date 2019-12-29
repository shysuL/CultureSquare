package mypage.dao.face;

import user.dto.User_table;

public interface MyPageDao {

	public void updateUserNick(User_table user);

	public User_table selectUserAll(User_table user);

}
