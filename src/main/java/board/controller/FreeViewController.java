package board.controller;


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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import board.dto.Alram;
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
	
	@RequestMapping(value = "/board/freemodify", method = RequestMethod.GET)
	public void modifyFree(Model model, HttpSession session, @RequestParam("boardno") int boardno) {
		
		FreeBoard boardDetail = freeboardService.freeDetail(boardno);	
		UpFile fileinfo = freeboardService.getFile(boardno);
//		logger.info(fileinfo.toString());
		
		model.addAttribute("board", boardDetail);
		model.addAttribute("file", fileinfo);
	}
	
	@RequestMapping(value = "/board/freemodify", method = RequestMethod.POST)
	public String modifyFree(Model model, HttpSession session, FreeBoard freeboard, UpFile file) {
		
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
		
		//5. 댓글 좋아요 삭제
		//5-1 보드번호를 통한 댓글 리스트들의 댓글 번호 구해 삭제하기 
		Reply reply = new Reply();
		reply.setBoardno(boardno);
		List<Reply> replyVO = freeboardService.getReplyByboardNo(reply);

		logger.info("답 테스트 : "  + replyVO);

		if(replyVO.size() > 0){

			for(int i=0; i<replyVO.size(); i++){
				//5-2댓글 좋아요 데이터 삭제
				freeboardService.deleteReLike(replyVO.get(i).getReplyno());
			}
		}


		//6. 댓글 대댓글 삭제
		freeboardService.deleteReplyToBoard(boardno);
		
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
				
				Alram alram = new Alram();
//				alram.setAlramcontents(reply.getRecontents());
				alram.setAlramsender(freeboardService.getUserNoByNick((String)session.getAttribute("usernick")).getUsernick());
				alram.setUserno(freeboardService.getUserno(freeBoard.getBoardno()).getUserno());
				alram.setBoardno(freeBoard.getBoardno());
				logger.info(alram.toString());
				freeboardService.insertRecommendAlram(alram);
				
				
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
			return "/board/freeview?boardno="+boardno;
		}
		
	}
	
	@RequestMapping(value="/board/recheck", method=RequestMethod.GET)
	public String reCheckFree(FreeBoard freeBoard, Model model, HttpSession session) {
		
		
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
	
	@RequestMapping(value="/board/addComment", method=RequestMethod.POST)
	public ModelAndView addCommentFree(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			logger.info("댓글 등록 테스트  : " + reply);
			//유저 번호 저장
			reply.setUserno(freeboardService.getUserNoByNick((String)session.getAttribute("usernick")).getUserno());
			logger.info("서비스 후  : " + reply);
			
			//댓글 삽입
			freeboardService.insertReply(reply);
			
			Alram alram = new Alram();
			alram.setAlramcontents(reply.getRecontents());
			alram.setAlramsender(freeboardService.getUserNoByNick((String)session.getAttribute("usernick")).getUsernick());
			alram.setUserno(freeboardService.getUserno(reply.getBoardno()).getUserno());
			alram.setBoardno(reply.getBoardno());
			logger.info(alram.toString());
			freeboardService.insertReplyAlram(alram);
			
			mav.addObject("insert", true);
			//viewName지정하기
			mav.setViewName("jsonView");
		}
		else {
			mav.addObject("insert", false);
			//viewName지정하기
			mav.setViewName("jsonView");
		}
		return mav;
	}
	
	@RequestMapping(value="/board/commentList", method=RequestMethod.POST)
	public ModelAndView commentListFree(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		int reReplyCnt = 0;
		
		ArrayList<HashMap> reList = new ArrayList<HashMap>();
		
        // 해당 게시물 댓글 리스트 불러오기
        List<Reply> replyVO = freeboardService.getReplyList(reply.getBoardno());
        
        
        logger.info("답 테스트 : "  + replyVO);
        
        if(replyVO.size() > 0){
        	
        	
            for(int i=0; i<replyVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("replyno", replyVO.get(i).getReplyno());
                hm.put("boardno", replyVO.get(i).getBoardno());
                hm.put("recontents", replyVO.get(i).getRecontents());
                hm.put("usernick", replyVO.get(i).getUsernick());
                hm.put("replydate", replyVO.get(i).getReplydate());
                
                //댓글의 답글 갯수 구하기
                reReplyCnt = freeboardService.getREreplyCnt(replyVO.get(i).getGroupno());
                
                hm.put("replyCnt", reReplyCnt);
                
                reList.add(hm);
            }
        }
        
        logger.info("리스트 테스트 수정: " + reList);
		
		mav.addObject("reList", reList);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/board/deletereReply", method=RequestMethod.POST)
	public ModelAndView deleteReReplyFree(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("답글 삭제 테스트  : " + reply);

		// 1. 댓글 삭제
		freeboardService.deleteReply(reply);

		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/board/deleteComment", method=RequestMethod.POST)
	public ModelAndView deleteCommentFree(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("댓글 삭제 테스트  : " + reply);

		// 1.댓글 좋아요 삭제
		freeboardService.deleteBlike(reply.getReplyno());
		
		// 2. 댓글번호로 그룹번호 가져오기
		int groupNo = freeboardService.getGroupNoByReplyNo(reply);
		
		// 3. 삭제할 댓글의 답글 삭제
//		freeboardService.deleteReReplyByGroupNo(groupNo);
		
		
		// 4.댓글 삭제
		freeboardService.deleteReply(reply);

		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/board/modifyComment", method=RequestMethod.POST)
	public ModelAndView modifyCommentFree(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("댓글 수정 테스트  : " + reply);

		//댓글 수정
		freeboardService.updateReplyByNo(reply);

		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/board/ReReplyList", method=RequestMethod.POST)
	public ModelAndView reReplyListFree(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		int reReplyCnt = 0;
		
		ArrayList<HashMap> reReplyList = new ArrayList<HashMap>();
		
		// 1. 댓글번호로 그룹번호 가져오기
		int groupNo = freeboardService.getGroupNoByReplyNo(reply);
		
        // 해당 댓글 답글리스트 불러오기
        List<Reply> replyVO = freeboardService.getReReplyByNo(groupNo);
        
        if(replyVO.size() > 0){
            for(int i=0; i<replyVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("replyno", replyVO.get(i).getReplyno());
                hm.put("boardno", replyVO.get(i).getBoardno());
                hm.put("recontents", replyVO.get(i).getRecontents());
                hm.put("usernick", replyVO.get(i).getUsernick());
                hm.put("replydate", replyVO.get(i).getReplydate());
                
                //답글 갯수 구하기
                reReplyCnt = freeboardService.getREreplyCnt(replyVO.get(i).getGroupno());
                
                hm.put("replyCnt", reReplyCnt);
                
                reReplyList.add(hm);
            }
        }
        
        logger.info("답글 테스트 : " + reReplyList);
		
        
		mav.addObject("reReplyList", reReplyList);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/board/addReReply", method=RequestMethod.POST)
	public ModelAndView addReReplyFree(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			// 1. 유저 번호 저장
			reply.setUserno(freeboardService.getUserNoByNick((String)session.getAttribute("usernick")).getUserno());

			// 2. 댓글번호를 이용해 그룹 번호 담기
			reply.setGroupno(freeboardService.getGroupNoByReplyNo(reply));
			
			// 3. 그룹번호를 이용한 댓글 그룹의 최대 ReplyOrder + 1을 객체에 담기
			reply.setMaxreplyorder(freeboardService.getMaxReplyOrder(reply) + 1);
			
			logger.info("답글 컨트롤러 테스트 : " + reply);
			
			
			//답글 삽입
			freeboardService.addReReply(reply);
			
			mav.addObject("insert", true);
			//viewName지정하기
			mav.setViewName("jsonView");
		}
		else {
			mav.addObject("insert", false);
			//viewName지정하기
			mav.setViewName("jsonView");
		}
		return mav;
	}
	
	@RequestMapping(value="/board/replycheck", method=RequestMethod.GET)
	public String replyCheckFree(Reply reply, Model model, HttpSession session) {
		
		
		//댓글 번호 저장
		int replyno = reply.getReplyno();
		
		// 1. 회원 번호 구하기
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			reply = freeboardService.getUserNoForReplyLike((String)session.getAttribute("usernick"));
		}
		
		reply.setReplyno(replyno);
		
		logger.info("댓글 좋아요 테스트 : " + reply.toString());
		
		int result = freeboardService.replyRecommendCheck(reply);
		
		logger.info("요건 댓글 첨에 : " + result);
//		
		int replyRecommendCnt = freeboardService.replyRecommendView(reply);
//		
		//	VIEW에 모델(MODEL)값 전달하기
		model.addAttribute("result", result);
		
		model.addAttribute("replyno", replyno);
		
		model.addAttribute("replyRecommendCnt", replyRecommendCnt);
		return "board/replycheck";
	}
	
	@RequestMapping(value="/board/replyrecommend", method=RequestMethod.GET)
	public String replyrecommendPR(Reply reply, Model model, HttpSession session, String boardno) {
		
		//댓글 번호 저장
		int replyno = reply.getReplyno();
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			// 1. 회원 번호 구하기
			reply = freeboardService.getUserNoForReplyLike((String)session.getAttribute("usernick"));
			reply.setReplyno(replyno);

			int result = freeboardService.replyRecommendCheck(reply);

			logger.info("댓글 추천 동작 테ㅡ트 : " + reply);

			
			//전에 추천한적이 없다면
			if(result == 0) {
				freeboardService.replyRecommend(reply);
			}
			else {
				freeboardService.replyRecommendCancal(reply);
			}

			int replyRecommendCnt = freeboardService.replyRecommendView(reply);

			//	VIEW에 모델(MODEL)값 전달하기
			model.addAttribute("result", result);

			model.addAttribute("replyRecommendCnt", replyRecommendCnt);
			return "prboard/replyrecommend";
		}
		//로그아웃일 경우 실패를 받을수 있도록 다시 보냄
		else {
			return "/board/freeview?boardno="+boardno;
		}
		
	}
	
	@RequestMapping(value="/board/bestcommentList", method=RequestMethod.POST)
	public ModelAndView bestcommentListPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		int reReplyCnt = 0;
		
		ArrayList<HashMap> reList = new ArrayList<HashMap>();
		
        // 해당 게시물 댓글 리스트 불러오기
        List<Reply> replyVO = freeboardService.getBestReplyByboardNo(reply);
        
        
        logger.info("답 테스트 : "  + replyVO);
        
        if(replyVO.size() > 0){
        	
        	
            for(int i=0; i<replyVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("replyno", replyVO.get(i).getReplyno());
                hm.put("boardno", replyVO.get(i).getBoardno());
                hm.put("recontents", replyVO.get(i).getRecontents());
                hm.put("usernick", replyVO.get(i).getUsernick());
                hm.put("replydate", replyVO.get(i).getReplydate());
                
                //댓글의 답글 갯수 구하기
                reReplyCnt = freeboardService.getREreplyCnt(replyVO.get(i).getGroupno());
                
                hm.put("replyCnt", reReplyCnt);
                
                reList.add(hm);
            }
        }
        
        logger.info("베스트 리스트 수정: " + reList);
		
		mav.addObject("reList", reList);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/board/remostcommentList", method=RequestMethod.POST)
	public ModelAndView remostcommentListPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		int reReplyCnt = 0;
		
		ArrayList<HashMap> reList = new ArrayList<HashMap>();
		
        // 해당 게시물 댓글 리스트 불러오기
        List<Reply> replyVO = freeboardService.getMostReplyByboardNo(reply);
        
        
        logger.info("답 테스트 : "  + replyVO);
        
        if(replyVO.size() > 0){
        	
        	
            for(int i=0; i<replyVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("replyno", replyVO.get(i).getReplyno());
                hm.put("boardno", replyVO.get(i).getBoardno());
                hm.put("recontents", replyVO.get(i).getRecontents());
                hm.put("usernick", replyVO.get(i).getUsernick());
                hm.put("replydate", replyVO.get(i).getReplydate());
                
                //댓글의 답글 갯수 구하기
                reReplyCnt = freeboardService.getREreplyCnt(replyVO.get(i).getGroupno());
                
                hm.put("replyCnt", reReplyCnt);
                
                reList.add(hm);
            }
        }
        
        logger.info("답글 순 리스트 수정: " + reList);
		
		mav.addObject("reList", reList);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}

}
