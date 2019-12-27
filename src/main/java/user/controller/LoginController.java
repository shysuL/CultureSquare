package user.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import user.bo.NaverLoginBO;
import user.dto.User_table;
import user.service.face.GoogleService;
import user.service.face.KakaoService;
import user.service.face.NaverService;
import user.service.face.UserService;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Autowired private NaverService naverService;
	@Autowired private KakaoService kakaoService;
	@Autowired private GoogleService googleService;
	@Autowired private UserService userService;
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	HttpSession mySession;

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
		
		mySession = session;
		
		return "redirect:/main/main";
	}
	
	//소셜로그인 닉네임 변경후 회원정보 넣어주기
	@RequestMapping(value = "/socialinsert", method = { RequestMethod.GET, RequestMethod.POST })
	public String socialInsert(String socialType, String usernick, String username) {

		logger.info("혹시몰라 : " + socialType + usernick + username);
		
		//구글
		if(socialType.equals("Google")) {
			
			//유저 DTO에 소셜 로그인 정보 저장
			User_table user = new User_table();
			user.setUsername(username);
			user.setUsernick(usernick);
			googleService.insertGoogleInfo(user);
			
		}
		
		//네이버
		else if(socialType.equals("Naver")) {
			
			//유저 DTO에 소셜 로그인 정보 저장
			User_table user = new User_table();
			user.setUsername(username);
			user.setUsernick(usernick);
			googleService.insertGoogleInfo(user);
			
			//소셜 로그인 정보 존재 유무 검사
			int socialCnt = naverService.getSocialAccountCnt(user);
			
			if(socialCnt == 0) {
				mySession.setAttribute("socialDouble", false);
				
			}
			else 
				mySession.setAttribute("socialDouble", true);
		}
		
		//카카오
		else if(socialType.equals("Kakao")) {
			
			//유저 DTO에 소셜 로그인 정보 저장
			User_table user = new User_table();
			user.setUsername(username);
			user.setUsernick(usernick);
			googleService.insertGoogleInfo(user);

			//소셜 로그인 정보 존재 유무 검사
			int socialCnt = kakaoService.getSocialAccountCnt(user);
			
			if(socialCnt == 0) {
				mySession.setAttribute("socialDouble", false);
				
			}
			else 
				mySession.setAttribute("socialDouble", true);
			
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
	
	@RequestMapping(value="/login", method= RequestMethod.POST)
	public String loginProc(User_table user, HttpSession session, 
			HttpServletRequest req, HttpServletRequest resp, 
			Model model) {
		
		// userLogin.jsp에서 아이디기억하기 name값 ( remember ) 가져오기
//		String userCheck = req.getParameter("UserIdSave");
			boolean isLogin = userService.loginProc(user); // true 로그인
			
			//세션 정보 불러오기
			User_table userSession = userService.getUserSession(user);
			
			// 결과에 따른 세션관리
			if(isLogin) {
				//세션에 정보 저장하기
				session.setAttribute("login", true);
				session.setAttribute("userid", user.getUserid());
				session.setAttribute("usernick", userSession.getUsernick());
				session.setAttribute("username", userSession.getUsername());
				session.setAttribute("interest", userSession.getInterest());
				logger.info(userSession.getUsernick().toString());
				logger.info(userSession.getUsername().toString());
				logger.info(userSession.getInterest().toString());
				logger.info("로그인 성공하고 세션 저장");
				
			}
		
			return "redirect:/main/main";
		}
		
	}
