package main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import board.dto.FreeBoard;
import board.service.face.FreeBoardService;
import board.service.face.NoticeBoardService;
import main.dto.Weather;
import main.service.face.WeatherService;
import prboard.service.face.PRBoardService;
import user.bo.NaverLoginBO;
import user.dto.User_table;
import user.service.face.KakaoService;
import util.PRPaging;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	
	@Autowired private KakaoService kakaoService;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	@Autowired NoticeBoardService noticeboardService;
	@Autowired FreeBoardService freeboardService;
	@Autowired private PRBoardService prBoardService;
	@Autowired private WeatherService weatherService;
	
	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@RequestMapping(value="/main/main")
	public void main(Model model, HttpSession session, String searchType, String search, PRPaging paging) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		
		//카카오 인증 URL 생성
		String kakaoUrl = kakaoService.getAuthorizationUrl(session);
		
		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String googleUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		
		logger.info("네이버 URL : " + naverAuthUrl);
		logger.info("카카오 URL: " + kakaoUrl);
		logger.info("구글 URL: " + googleUrl);
		
		//네이버 
		model.addAttribute("naver_url", naverAuthUrl);
		
		//카카오
		model.addAttribute("kakao_url", kakaoUrl);
		
		//구글
		model.addAttribute("google_url", googleUrl);
		

//		Weather weather = weatherService.setTime();
//		
//		//날씨
//		model.addAttribute("weather", weather);
//		
//		System.out.println(weather);

		//PR게시판 자료 가져오기
		Map<String, String> map = new HashMap<String, String>();
		logger.info("여긴ㅅ ㅣㄹ행 되나");
		
		
		if(searchType!=null && !"".equals(searchType)) {
			map.put("searchType",searchType);
		}

		if(search!=null && !"".equals(search)) {
			map.put("search", search);
		}
		
		int totalCount = prBoardService.getCntAll(map);
		
		
		PRPaging paging2 = new PRPaging(totalCount, paging.getCurPage());
		
		paging2.setsearch2(map);
		
		logger.info("맵 : " + map.toString());
		
		logger.info("paging2 : " + paging2.toString());
		
		model.addAttribute("paging", paging2);
		List list = prBoardService.getList(paging2);
		model.addAttribute("list",list);
		
		//정렬 타입을 최신순으로
		model.addAttribute("sort", "new");
		
		//자유게시판 최신글 불러오기
		List<FreeBoard> viewsList = freeboardService.getViewsList();
		logger.info(viewsList.toString());
		
		model.addAttribute("viewslist", viewsList);
		
		//공자사항 최신글 불러오기
		List<FreeBoard> viewsList1 = noticeboardService.getViewsList();
		logger.info(viewsList.toString());
		
		model.addAttribute("viewslist1", viewsList1);
		
	}
	
	@RequestMapping(value="/main/showweather")
	public ModelAndView showweather(ModelAndView mav) {
		
		Weather weather = weatherService.setTime();
		
		mav.addObject("weather", weather);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/layout/fotter/service")
	public void service() { }
	@RequestMapping(value="/layout/fotter/clause")
	public void clause() { }
	@RequestMapping(value="/layout/fotter/personal")
	public void personal() { }
	@RequestMapping(value="/layout/fotter/cheongsonyeon")
	public void commercial() { }
	@RequestMapping(value="/layout/fotter/customer")
	public void customer() { }
	
}
