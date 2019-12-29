package user.service.impl;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import user.dao.face.UserDao;
import user.dto.User_table;
import user.service.face.NaverService;

@Service
public class NaverServiceImpl implements NaverService{
	
	@Autowired private UserDao userDao;
	
	int naverCnt = 0;
	
	@Override
	public String setApiResult(String apiResult, HttpSession session) {
		
		//1. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj ="";
		try {
			obj = parser.parse(apiResult);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONObject jsonObj = (JSONObject) obj;

		//2. 데이터 파싱 
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		//response의 nickname값 파싱
		
		String nickname = (String)response_obj.get("nickname");
			
		String socialId = (String)response_obj.get("email");
		String name = (String)response_obj.get("name");
		String gender = (String)response_obj.get("gender");
		
		//유저 DTO에 소셜 로그인 정보 저장
		User_table user = new User_table();
		user.setUsernick(nickname);
		user.setUserid(socialId);
		user.setUsername(name);
		user.setUsergender(gender);
		
		
		//소셜 로그인 정보 존재 유무 검사
		int socialCnt = getSocialAccountCnt(user);
		
		if(socialCnt == 0) {
			session.setAttribute("socialDouble", false);
			session.setAttribute("usernick",nickname); 	// 닉네임
		}
		else {
			session.setAttribute("socialDouble", true);
			int userno = userDao.selectSocialuserNo(nickname);
			String usernick = userDao.selectUserNick(userno);
			session.setAttribute("usernick", usernick);
		}
		
		//3.파싱 닉네임 세션으로 저장
		
		session.setAttribute("socialnick", nickname);
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("socialId", socialId);	// 소셜 ID(이메일)
		session.setAttribute("username", name);			// 이름
		session.setAttribute("socialType", "Naver");
	

		return apiResult;
	}

	@Override
	public int getSocialAccountCnt(User_table user) {
			
		return userDao.selectSocialCnt(user);
	}

	@Override
	public void insertNaverInfo(User_table user) {
		userDao.insertNaverLoginInfo(user);
	}

	@Override
	public void insertNaverSocial(User_table socialuser) {
		userDao.insertSocial(socialuser);
	}

	@Override
	public int getUserNo(String socialnick) {
		return userDao.selectuserNo(socialnick);
	}
}
