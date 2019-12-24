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
import user.service.face.GoogleService;
import user.service.face.KakaoService;
import user.service.face.NaverService;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Autowired private NaverService naverService;
	@Autowired private KakaoService kakaoService;
	@Autowired private GoogleService googleService;
		
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
	public String kakaoCallback(@RequestParam("code") String code, 
			HttpSession session){

		logger.info("여기는 카카오톡 콜백!");
		
		//카카오 로그인 데이터 파싱 및 설정 위한 서비스 호출
		kakaoService.setKakaoLogin(code, session);

		return "redirect:/main/main";
	}

	//구글 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/googlecallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(String code, HttpSession session) {
		logger.info("여기는여기는 googleCallback");

		try {
			//구글 로그인 데이터 파싱 및 설정 위한 서비스 호출
			googleService.setGoogleLogin(code, session, googleOAuth2Parameters);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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