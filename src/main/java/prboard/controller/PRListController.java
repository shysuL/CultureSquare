package prboard.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;

import prboard.service.face.PRBoardService;
import user.bo.NaverLoginBO;
import user.service.face.KakaoService;
import util.PRPaging;

@Controller
public class PRListController {
	private static final Logger logger = LoggerFactory.getLogger(PRListController.class);

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	
	@Autowired private KakaoService kakaoService;
	
	@Autowired private PRBoardService prBoardService;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	
	@RequestMapping(value="/prboard/prlist", method=RequestMethod.GET)
	public void prList(Model model, String searchType, String search, PRPaging paging, HttpSession session) {
		logger.info("pr리스트 출력");
		
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
		
		Map<String, String> map = new HashMap<String, String>();
		logger.info("여긴ㅅ ㅣㄹ행 되나");
		
		
		if(searchType!=null && !"".equals(searchType)) {
			map.put("searchType",searchType);
		}

		if(search!=null && !"".equals(search)) {
			map.put("search", search);
		}
		
		int totalCount = prBoardService.getCntAll(map);
		
		logger.info("토탈 갯수 : " + totalCount);
		
		PRPaging paging2 = new PRPaging(totalCount, paging.getCurPage());
		
		paging2.setsearch2(map);
		
		logger.info("맵 : " + map.toString());
		
		logger.info("paging2 : " + paging2.toString());
		
		model.addAttribute("paging", paging2);
		List list = prBoardService.getList(paging2);
		model.addAttribute("list",list);
		
		//정렬 타입을 최신순으로
		model.addAttribute("sort", "new");
		
		
		logger.info("보드 리스트 겟 테스트 : " + list);
	
	}
	
	
	@RequestMapping(value="/prboard/prmorelist", method=RequestMethod.GET)
	public void prmorelist(Model model, String searchType, String search, PRPaging paging, HttpSession session) {
		logger.info("pr more 리스트 출력");
		
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
		
		Map<String, String> map = new HashMap<String, String>();
		logger.info("여긴ㅅ ㅣㄹ행 되나");
		
		
		if(searchType!=null && !"".equals(searchType)) {
			map.put("searchType",searchType);
		}

		if(search!=null && !"".equals(search)) {
			map.put("search", search);
		}
		
		int totalCount = prBoardService.getCntAll(map);
		
		logger.info("토탈 갯수 : " + totalCount);
		
		PRPaging paging2 = new PRPaging(totalCount, paging.getCurPage());
		
		paging2.setsearch2(map);
		
		logger.info("맵 : " + map.toString());
		
		logger.info("paging2 : " + paging2.toString());
		
		model.addAttribute("paging", paging2);
		List list = prBoardService.getMoreList(paging2);
		model.addAttribute("list",list);
		
		
		logger.info("more 리스트 겟 테스트 : " + list);
	}
	
	@RequestMapping(value="/prboard/prlikelist", method=RequestMethod.GET)
	public void prlikelist(Model model, String searchType, String search, PRPaging paging, HttpSession session) {
		logger.info("pr like 리스트 출력");
		
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
		
		Map<String, String> map = new HashMap<String, String>();
		logger.info("여긴ㅅ ㅣㄹ행 되나");
		
		
		if(searchType!=null && !"".equals(searchType)) {
			map.put("searchType",searchType);
		}

		if(search!=null && !"".equals(search)) {
			map.put("search", search);
		}
		
		int totalCount = prBoardService.getCntAll(map);
		
		logger.info("토탈 갯수 : " + totalCount);
		
		PRPaging paging2 = new PRPaging(totalCount, paging.getCurPage());
		
		paging2.setsearch2(map);
		
		logger.info("맵 : " + map.toString());
		
		logger.info("paging2 : " + paging2.toString());
		
		model.addAttribute("paging", paging2);
		List list = prBoardService.getLikeList(paging2);
		model.addAttribute("list",list);
		
		
		logger.info("Like 리스트 겟 테스트 : " + list);
	}
}
