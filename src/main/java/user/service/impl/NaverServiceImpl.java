package user.service.impl;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import user.service.face.NaverService;

@Service
public class NaverServiceImpl implements NaverService{
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

		//3.파싱 닉네임 세션으로 저장
		session.setAttribute("nickname",nickname); 	// 세션 생성
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("socialId", socialId);	// 소셜 ID(이메일)
		session.setAttribute("name", name);			// 이름

		return apiResult;
	}
}
