package board.controller;


import java.io.IOException;
import java.io.Writer;
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
import board.dto.Reply;
import board.dto.UpFile;
import board.service.face.FreeBoardService;
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
		
		if(session.getAttribute("usernick") != null) {
			// 세션에 저장된 usernick를 모델로 전달
			FreeBoard user = new FreeBoard();
			Object usernick = session.getAttribute("usernick");
			user = freeboardService.getUserNoByNick(usernick);		
			
			// 조회된 회원정보를 모델로 전달
			model.addAttribute("LoginUser", user);
		}
		
		
		
//		System.out.println(boardDetail);
		
		logger.info(boardDetail.toString());
		model.addAttribute("board", boardDetail);
		model.addAttribute("file", fileinfo);
		
		//댓글 리스트 전달
		Reply reply = new Reply();
		List<Reply> replyList = freeboardService.getReplyList(boardno);
		model.addAttribute("replyList", replyList);
		
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
			
		}
		
		freeboardService.deleteBlike(boardno);
		
		freeboardService.freeDelete(boardno);
		
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
	
	@RequestMapping(value="/board/recommend", method=RequestMethod.GET)
	public String recommendFree(FreeBoard freeBoard, Model model, HttpSession session) {
		
		//보드 번호 저장
		int boardno = freeBoard.getBoardno();
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			// 1. 회원 번호 구하기
			freeBoard = freeboardService.getUserNoByNick((String)session.getAttribute("usernick"));
			freeBoard.setBoardno(boardno);

			int result = freeboardService.recommendCheck(freeBoard);


			//전에 추천한적이 없다면
			if(result == 0) {
				freeboardService.recommend(freeBoard);
			}
			else {
				freeboardService.recommendCancal(freeBoard);
			}

			logger.info("버튼 클릭 : " + result);
			logger.info("추천 보드 정보 : " + freeBoard);

			int recommendCnt = freeboardService.recommendView(freeBoard);

			//	VIEW에 모델(MODEL)값 전달하기
			model.addAttribute("result", result);

			model.addAttribute("recommendCnt", recommendCnt);
			return "board/recommend";
		}
		//로그아웃일 경우 실패를 받을수 있도록 다시 보냄
		else {
			return "/board/view?boardno="+boardno;
		}
		
	}
	
	@RequestMapping(value="/board/recheck", method=RequestMethod.GET)
	public String reCheckPR(FreeBoard freeBoard, Model model, HttpSession session) {
		
		
		//보드 번호 저장
		int boardno = freeBoard.getBoardno();
		
		// 1. 회원 번호 구하기
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			freeBoard = freeboardService.getUserNoByNick((String)session.getAttribute("usernick"));
		}
		
		freeBoard.setBoardno(boardno);
		
		logger.info(freeBoard.toString());
		
		int result = freeboardService.recommendCheck(freeBoard);
		
		logger.info("요건 첨에 나올 : " + result);
		
		int recommendCnt = freeboardService.recommendView(freeBoard);
		
		//	VIEW에 모델(MODEL)값 전달하기
		model.addAttribute("result", result);
		
		model.addAttribute("recommendCnt", recommendCnt);
		return "/board/recheck";
	}
	
	@RequestMapping(value = "/freereply/insert", method = RequestMethod.GET)
	public void replyInsert(Reply reply) {	
		replyInsertProc(reply);
	
	}
	
	@RequestMapping(value = "/freereply/insert", method = RequestMethod.POST)
	public String replyInsertProc(Reply reply) {
		
		logger.info(reply.toString());
		// 전달받은 댓글 내용을 입력
		freeboardService.insertReply(reply);
		
		return "redirect:/board/freeview?boardno="+reply.getBoardno();
	}
	
	@RequestMapping(value = "/freereply/delete", method = RequestMethod.GET)
	public void replyDelete(Reply reply, Writer out) {
		replyDeleteProc(reply, out);
	}
	
	
	@RequestMapping(value = "/freereply/delete", method = RequestMethod.POST)
	public void replyDeleteProc(Reply reply, Writer out) {
		
		boolean success = freeboardService.deleteReply(reply);
		
		
		try {
			out.write("{\"success\":"+success+"}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
