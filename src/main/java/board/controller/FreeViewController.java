package board.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import board.dto.FreeBoard;
import board.dto.UpFile;
import board.service.face.FreeBoardService;
import prboard.service.face.PRBoardService;
import user.bo.NaverLoginBO;
import user.service.face.KakaoService;

@Controller
public class FreeViewController {
	
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
	
	@Autowired FreeBoardService freeboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(FreeViewController.class);

	@RequestMapping(value = "/board/freeview", method = RequestMethod.GET)
	public void freeDetail(Model model, @RequestParam("boardno") int boardno, HttpSession session) {
		
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
		
		//조회수 증가
		freeboardService.increaseViews(boardno);
		
		FreeBoard boardDetail = freeboardService.freeDetail(boardno);
		UpFile fileinfo = freeboardService.getFile(boardno);
		
//		System.out.println(boardDetail);
		
		logger.info(boardDetail.toString());
		
		model.addAttribute("board", boardDetail);
		model.addAttribute("file", fileinfo);
		
	}
	
	@RequestMapping(value = "/board/freemodifiy", method = RequestMethod.GET)
	public void modifiyFree(Model model, HttpSession session, @RequestParam("boardno") int boardno) {
		
		FreeBoard boardDetail = freeboardService.freeDetail(boardno);	
		UpFile fileinfo = freeboardService.getFile(boardno);
//		logger.info(fileinfo.toString());
		
		model.addAttribute("board", boardDetail);
		model.addAttribute("file", fileinfo);
	}
	
	@RequestMapping(value = "/board/freemodifiy", method = RequestMethod.POST)
	public String modifiyFree(Model model, HttpSession session, FreeBoard freeboard, UpFile file) {
		
		logger.info(freeboard.toString());
		
		UpFile fileinfo = freeboardService.getFile(freeboard.getBoardno());
		
		logger.info(file.toString());
		
		
		if( fileinfo == null ) {
			
			if(file.getFile().isEmpty()) {
				
//				logger.info("확인");
				
				freeboardService.updateFreeBoard(freeboard);
			
			} else {
			
				freeboardService.updateFreeBoard(freeboard);
			
				freeboardService.filesave(file, freeboard.getBoardno());
			
			}
		

		}else {
			
			if(!file.getFile().isEmpty()) {
				
				freeboardService.fileDelete(fileinfo);
				
				freeboardService.filesave(file, freeboard.getBoardno());
				
			}
			
			freeboardService.updateFreeBoard(freeboard);
		}
		
		return "redirect:/board/freelist";
		
	}
	
	@RequestMapping(value = "/board/freedelete", method = RequestMethod.GET)
	public String deleteFreeProc(@RequestParam("boardno") int boardno, HttpSession session, UpFile file) {			
		
		logger.info(file.toString());
		
		//게시글 첨부파일 조회
		UpFile fileinfo = freeboardService.getFile(boardno);
		
		if( file.getFileno() != 0 ) {
		
			freeboardService.fileDelete(fileinfo);
			
			freeboardService.freeDelete(boardno);
			
		}else {
			
			freeboardService.freeDelete(boardno);
		
		}
		
		return "redirect:/board/freelist";
	}
	
	@RequestMapping(value = "/board/download")
	public ModelAndView download(int fileno, ModelAndView mav) {
		
		//파일번호에 해당하는 파일 정보 가져오기
		UpFile file = freeboardService.getFileNo(fileno);
		
		logger.info(file.toString());

		//파일정보를 MODEL 값으로 지정하기
		mav.addObject("downFile", file);

		//viewName 지정하기
		mav.setViewName("down");

		return mav;

	}

}
