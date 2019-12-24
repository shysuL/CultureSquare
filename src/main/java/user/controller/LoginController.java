package user.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonNode;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import user.bo.NaverLoginBO;
import user.dto.User_table;
import user.service.face.KakaoService;
import user.service.face.NaverService;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Autowired private NaverService naverService;
	@Autowired private KakaoService kakaoService;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;


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

		logger.info("api 결과 값은? : " + apiResult.toString());

		//2. 데이터 파싱 위한 서비스 호출
		naverService.setApiResult(apiResult, session);

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
		JsonNode node = kakaoService.getAccessToken(code);
		//accessToken에 로그인한 사용자의 정보 저장
		JsonNode accessToken = node.get("access_token");

		logger.info("카카오 정보 : " + accessToken);

		//사용자의 정보
		JsonNode userInfo = kakaoService.getKakaoUserInfo(accessToken);

		//유저 정보를 카카오 API에서 가져오기
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");
		kname = properties.path("nickname").asText();

		
		//파싱 닉네임 세션으로 저장
		session.setAttribute("name",kname); 		//이름 	 동일
		session.setAttribute("nickname",kname); 	//닉네임 동일
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("socialType", "kakao");
		session.setAttribute("token", accessToken);
		
		//유저 DTO에 소셜 로그인 정보 저장
		User_table user = new User_table();
		user.setUsernick(kname);
		user.setUsername(kname);
		
		//소셜 로그인 정보 존재 유무 검사
		int socialCnt = kakaoService.getSocialAccountCnt(user);
		
		
		//소셜로그인 정보가 회원정보에 담겨 있지 않으면 UserTable에 소셜로그인 데이터 삽입
		if(socialCnt == 0) {
			kakaoService.insertKakaoInfo(user);
		}

		mav.setViewName("/main/main");
		return mav;
	}

	//구글 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/googlecallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(Model model, HttpSession session, HttpServletRequest request) throws IOException {
		logger.info("여기는 googleCallback");

		String code = request.getParameter("code");

		//RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("code", code);
		parameters.add("client_id", "455988852585-f3r7dkn0se2ao5jjomake0usgfoccj1v.apps.googleusercontent.com");
		parameters.add("client_secret", "FmIfUs1Yfw3dKiHCemsSCHiT");
		parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
		parameters.add("grant_type", "authorization_code");

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(parameters, headers);
		ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token", HttpMethod.POST, requestEntity, Map.class);
		Map<String, Object> responseMap = responseEntity.getBody();

		// id_token 라는 키에 사용자가 정보가 존재한다.
		// 받아온 결과는 JWT (Json Web Token) 형식으로 받아온다. 콤마 단위로 끊어서 첫 번째는 현 토큰에 대한 메타 정보, 두 번째는 우리가 필요한 내용이 존재한다.
		// 세번째 부분에는 위변조를 방지하기 위한 특정 알고리즘으로 암호화되어 사이닝에 사용한다.
		//Base 64로 인코딩 되어 있으므로 디코딩한다.

		String[] tokens = ((String)responseMap.get("id_token")).split("\\.");
		Base64 base64 = new Base64(true);
		String body = new String(base64.decode(tokens[1]));

		String tokenInfo = new String(Base64.decodeBase64(tokens[1]), "utf-8");

		//Jackson을 사용한 JSON을 자바 Map 형식으로 변환
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> result = mapper.readValue(body, Map.class);

		logger.info("이름 : " + result.get("name"));
		logger.info("닉넴 : " + result.get("given_name"));

		// 파싱 데이터로 세션 저장
		session.setAttribute("nickname",result.get("given_name")); 	// 닉네임
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("name", result.get("name"));			// 이름

		
		return "redirect:/main/main";
	}

	//로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session)throws IOException {
		logger.info("로그아웃!");
		session.invalidate();

		return "redirect:/main/main";
	}
}