package user.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;

import user.bo.NaverLoginBO;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;


	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {

		logger.info("여기는 네이버 콜백!");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		//1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터


		/** apiResult json 구조
		{"resultcode":"00",
		 "message":"success",
		 "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/

		logger.info("api 결과 값 : " + apiResult.toString());

		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		//3. 데이터 파싱 
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		//response의 nickname값 파싱
		String nickname = (String)response_obj.get("nickname");
		String socialId = (String)response_obj.get("email");

		logger.info("닉네임 : " + nickname);
		logger.info("소셜아이디(이메일) : " + socialId);

		//4.파싱 닉네임 세션으로 저장
		session.setAttribute("nickname",nickname); 	// 세션 생성
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("socialId", socialId);	// 소셜 ID(이메일)


		model.addAttribute("result", apiResult);

		return "redirect:/main/main";
	}


	//카카오 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "kakaocallback", produces="application/json", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView kakaoCallback(@RequestParam("code") String code, HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) throws IOException, ParseException {
		ModelAndView mav = new ModelAndView();
		String kemail = null;
		String kname = null;
		String kgender = null;
		String kbirthday = null;
		String kage = null;
		String kimage = null;

		logger.info("여기는 카카오 콜백!");

		//결과값을 node에 담음
		JsonNode node = KakaoController.getAccessToken(code);
		//accessToken에 로그인한 사용자의 정보 저장
		JsonNode accessToken = node.get("access_token");

		logger.info("카카오 정보 : " + accessToken);

		//사용자의 정보
		JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);

		//유저 정보를 카카오 API에서 가져오기
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");
		kemail = kakao_account.path("email").asText();
		kname = properties.path("nickname").asText();
		kimage = properties.path("profile_image").asText();
		kgender = kakao_account.path("gender").asText();
		kbirthday = kakao_account.path("birthday").asText();
		kage = kakao_account.path("age_range").asText();

		//4.파싱 닉네임 세션으로 저장
		session.setAttribute("kemail",kemail); 	
		session.setAttribute("nickname",kname); 	
		session.setAttribute("kimage",kimage); 	
		session.setAttribute("kgender",kgender); 	
		session.setAttribute("kbirthday",kbirthday); 	
		session.setAttribute("kage",kage); 	
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("socialType", "kakao");
		session.setAttribute("token", accessToken);
		
		mav.setViewName("/main/main");
		return mav;
	}

	//일반, 네이버 로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session)throws IOException {
		logger.info("여기는 일반,네이버 로그아웃!");
		session.invalidate();

		return "redirect:/main/main";
	}
	
	
	//카카오 로그아웃
	@RequestMapping(value = "/kakaoLogout", produces = "application/json")
	public String Logout(HttpSession session) {
		logger.info("카카오 로그아웃 되나연!");
		
		//kakao restapi 객체 선언
		KakaoController kr = new KakaoController();
		//노드에 로그아웃한 결과값음 담아줌 매개변수는 세션에 잇는 token을 가져와 문자열로 변환
		JsonNode node = kr.Logout(session.getAttribute("token").toString());

		session.removeAttribute("token");	//토큰 제거
		session.removeAttribute("kemail");	//이메일 제거
		session.invalidate();				//세션 제거
		return "redirect:/main/main";
	}    
}