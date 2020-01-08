package artboard.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import artboard.dto.Board;
import artboard.dto.Donation;
import artboard.dto.PFUpFile;
import artboard.dto.Reply;
import artboard.service.face.PFBoardService;
import prboard.service.face.PRBoardService;
import user.bo.NaverLoginBO;
import user.service.face.KakaoService;

@Controller
public class ArtboardViewController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardViewController.class);
	@Autowired PFBoardService pfboardService;
	@Autowired HttpSession session;
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	
	@Autowired private KakaoService kakaoService;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	/* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;
	

	@RequestMapping(value = "/artboard/view", method = RequestMethod.GET)
	public void pfView(Board bno, Model model, Board LoginUser, HttpSession session) {
		
		
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
		
		// 전달받은 파라미터 (boardno)에 해당하는 게시글 상세보기
		Board viewboard = pfboardService.view(bno);
		
		// 조회된 게시글 모델로 전달
		model.addAttribute("view", viewboard);
//		logger.info(viewboard.toString());
		
		//게시글 첨부파일 조회
		List<PFUpFile> list = pfboardService.getFileList(viewboard.getBoardno());
		
		model.addAttribute("fileList", list);
		
		logger.info("파일 테스트 : " + list);
		
		// 전달받은 파라미터(boardno)에 해당하는 게시글 작성자(userno)로 작성자 정보 조회
		Board userno = new Board();
		userno.setUserno(viewboard.getUserno());
//		System.out.println(userno.getUserno());
		
		Board writer = pfboardService.getWriter(userno);
		
//		System.out.println("test : " + writer.toString());
		
		// 작성자 정보 모델로 전달
		model.addAttribute("writer", writer);
		
		
		// 비로그인 시 댓글 작성자 정보 조회 안함
		if(session.getAttribute("login") != null) {
			LoginUser.setUsernick((String) session.getAttribute("usernick"));
			
//			logger.info("session usernick : " + LoginUser.getUsernick());
			LoginUser.setUserno(pfboardService.getUsernoByUsernick(LoginUser));
//			logger.info("userno : " + LoginUser.getUserno());
			model.addAttribute("LoginUser",LoginUser );
			
		}
		
		//댓글 리스트 전달
		Reply reply = new Reply();
		List<Reply> replyList = pfboardService.getReplyList(bno);
		model.addAttribute("replyList", replyList);
		
		
	}
	
	@RequestMapping(value = "/artboard/donation", method = RequestMethod.GET)
	public String pfDonation(Donation donation, Model model) {
		
		// 1. 회원 번호 구하기
		donation = pfboardService.getUserNoByNick(donation);
		logger.info("유저번호는 뭐냐 ? : " + donation);
		
		// 2. 후원 테이블에 삽입
		pfboardService.insertDonation(donation);
		
		// 3. 해당 글로 다시 이동
		return "redirect:/artboard/view?boardno=" + donation.getBoardno();
	}
	
	@RequestMapping(value = "/artboard/commentList" , method = RequestMethod.POST)
	public ModelAndView commentListPF(Model model, Reply reply, HttpSession session, ModelAndView mav) {
	
		ArrayList<HashMap> reList = new ArrayList<HashMap>();
		
		List<Reply> replyList = pfboardService.getReplyByboardNo(reply);

		if(replyList.size() > 0) {
			for(int i = 0; i<replyList.size(); i++) {
				HashMap hm = new HashMap();
				hm.put("replyno", replyList.get(i).getReplyno());
				hm.put("boardno", replyList.get(i).getBoardno());
				hm.put("recontents", replyList.get(i).getRecontents());
				hm.put("usernick", replyList.get(i).getUsernick());
				hm.put("replydate", replyList.get(i).getReplydate());				
				
				reList.add(hm);
			}
		}
		mav.addObject("reList", reList);
		
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/pfboard/download")
	public ModelAndView download(int fileno, //파일번호 파라미터
			ModelAndView mav) {
		
		logger.info("파일번호 : " + fileno) ;
		
		//파일 번호에 해당하는 파일 정보 가져오기
		PFUpFile file = pfboardService.getFile(fileno);
		
		logger.info("조회된 파일 : " + file);
		
		//파일 정보를 MODEL 값으로 지정하기
		mav.addObject("downFile", file);
		
		//viewName 지정하기
		mav.setViewName("pfdown");
		
		return mav;
	}
	
	@RequestMapping(value = "/artboard/recommend", method = RequestMethod.GET)
	public String recommendPF(Board board, Model model,HttpSession session) {
		
		//보드 번호 저장
		int boardno = board.getBoardno();
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!= null) {
			// 1. 회원 번호 구하기
			board.setBoardno(boardno);
			board.setUserno((int) session.getAttribute("userno"));
			
			int result = pfboardService.recommendCheck(board);
			
			//전에 추천한적이 없다면
			if(result == 0) {
				pfboardService.recommend(board);
			}else {
				pfboardService.recommendCancel(board);
			}
			
			logger.info("버튼 클릭 : " + result);
			logger.info("추천 보드 정보 : " + board);
			
			int recommendCnt = pfboardService.recommendView(board);
			
			// View에 모델 전달
			model.addAttribute("result",result);
			
			model.addAttribute("recommendCnt", recommendCnt);
			
			return "artboard/recommend";
		}
		//로그아웃일 경우 실패를 받을수 있도록 다시 보냄
		else {
			return "/artboard/view?boardno="+boardno;
		}
	}
	
	
}
