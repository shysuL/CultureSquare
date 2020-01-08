package prboard.controller;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import prboard.dto.PRBoard;
import prboard.dto.Reply;
import prboard.dto.UpFile;
import prboard.service.face.PRBoardService;
import user.bo.NaverLoginBO;
import user.service.face.KakaoService;

@Controller
public class PRViewController {

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
	
	private static final Logger logger = LoggerFactory.getLogger(PRViewController.class);
	
	@RequestMapping(value="/prboard/view", method=RequestMethod.GET)
	public void viewPR(Model model, PRBoard prboard, HttpSession session) {
		
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
		
		
		//게시글 세부정보 조회
		PRBoard viewBoard = prBoardService.getViewInfo(prboard.getBoardno());
		model.addAttribute("viewBoard", viewBoard);
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(viewBoard.getBoardno());
		
		model.addAttribute("fileList", list);
		
		logger.info("파일 테스트 : " + list);
		
	}
	
	@RequestMapping(value="/prboard/download")
	public ModelAndView download(int fileno, //파일번호 파라미터
			ModelAndView mav) {
		
		logger.info("파일번호 : " + fileno) ;
		
		//파일 번호에 해당하는 파일 정보 가져오기
		UpFile file = prBoardService.getFile(fileno);
		
		logger.info("조회된 파일 : " + file);
		
		//파일 정보를 MODEL 값으로 지정하기
		mav.addObject("downFile", file);
		
		//viewName 지정하기
		mav.setViewName("prdown");
		
		return mav;
	}
	
	@RequestMapping(value="/prboard/modify", method=RequestMethod.GET)
	public void modifyPR(Model model, PRBoard prboard) {
		
		//게시글 세부정보 조회
		PRBoard viewBoard = prBoardService.getViewInfo(prboard.getBoardno());
		model.addAttribute("viewBoard", viewBoard);
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(viewBoard.getBoardno());
		
		model.addAttribute("fileList", list);
		
		logger.info("수정 게시판 : " + viewBoard);
		logger.info("수정 테스트 : " + list);
		
	}
	
	@RequestMapping(value="/prboard/modifyProc", method=RequestMethod.POST)
	public String modifyPRProc(MultipartHttpServletRequest multi, PRBoard prBoard,	HttpSession session) {
		
		String originName="";
		int i = 1;
		boolean firsImage = true;
		
		logger.info("수정 : " + prBoard);
		
		// 1. 게시글 내용 수정
		prBoardService.modifyPR(prBoard);
		
		// 2. 대표 이미지 삭제
		prBoardService.deleteThumbnail(prBoard.getBoardno());
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(prBoard.getBoardno());
		
		logger.info("기존 파일 : " + list);

		//3. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!list.isEmpty()) {
			//서버에 있는 파일 삭제
			prBoardService.deleteServerFile(list);
			
			//DB 파일 삭제
			prBoardService.deleteFile(list);
		}
		
		
		//4. 새 파일 추가
		Iterator<String> files = multi.getFileNames();
		
		while(files.hasNext()) {
			String uploadFile = files.next();
			MultipartFile mFile = multi.getFile(uploadFile);
			originName = mFile.getOriginalFilename();
			//빈파일 처리
			if(originName == null || originName .equals("")) {
				logger.info("빈파일 있음");
			}
			else {
				prBoardService.fileSave(mFile, prBoard.getBoardno());
				
				//.png 파일이거나 .jpg 파일인 경우
				if( "image".equals(mFile.getContentType().split("/")[0]) ) {
					
					//처음 이미지인 경우 이미지 파일에 업로드
					if(firsImage) {
						prBoardService.firstImageSave(mFile, prBoard.getBoardno());
						firsImage = false;
					}
				}
				logger.info(i + ". 실제 파일 이름 : " + originName);
				i++;
			}
		}
		return "redirect:/prboard/prlist";
	}
	
	@RequestMapping(value="/prboard/delete", method=RequestMethod.GET)
	public String deletePR(PRBoard prBoard,	HttpSession session) {
		
		
		logger.info("수정 : " + prBoard);
		
		// 1. 대표 이미지 삭제
		prBoardService.deleteThumbnail(prBoard.getBoardno());
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(prBoard.getBoardno());
		
		logger.info("기존 파일 : " + list);

		//2. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!list.isEmpty()) {
			//서버에 있는 파일 삭제
			prBoardService.deleteServerFile(list);
			
			//DB 파일 삭제
			prBoardService.deleteFile(list);
		}
		
		//3. PR 타입 삭제
		prBoardService.deletePRType(prBoard);
		
		//4.  좋아요 삭제
		prBoardService.deleteBlike(prBoard);
		
		//5. 댓글 대댓글 삭제
		prBoardService.deleteReplyToBoard(prBoard);
		
		//6. PR 게시글 삭제
		prBoardService.deletePR(prBoard);

		return "redirect:/prboard/prlist";
	}
	
	@RequestMapping(value="/prboard/recommend", method=RequestMethod.GET)
	public String recommendPR(PRBoard prBoard, Model model, HttpSession session) {
		
		//보드 번호 저장
		int boardno = prBoard.getBoardno();
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			// 1. 회원 번호 구하기
			prBoard = prBoardService.getUserNoByNick((String)session.getAttribute("usernick"));
			prBoard.setBoardno(boardno);

			int result = prBoardService.recommendCheck(prBoard);


			//전에 추천한적이 없다면
			if(result == 0) {
				prBoardService.recommend(prBoard);
			}
			else {
				prBoardService.recommendCancal(prBoard);
			}

			logger.info("버튼 클릭 : " + result);
			logger.info("추천 보드 정보 : " + prBoard);

			int recommendCnt = prBoardService.recommendView(prBoard);

			//	VIEW에 모델(MODEL)값 전달하기
			model.addAttribute("result", result);

			model.addAttribute("recommendCnt", recommendCnt);
			return "prboard/recommend";
		}
		//로그아웃일 경우 실패를 받을수 있도록 다시 보냄
		else {
			return "/prboard/view?boardno="+boardno;
		}
		
	}
	
	@RequestMapping(value="/prboard/recheck", method=RequestMethod.GET)
	public String reCheckPR(PRBoard prBoard, Model model, HttpSession session) {
		
		
		//보드 번호 저장
		int boardno = prBoard.getBoardno();
		
		// 1. 회원 번호 구하기
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			prBoard = prBoardService.getUserNoByNick((String)session.getAttribute("usernick"));
		}
		
		prBoard.setBoardno(boardno);
		
		logger.info(prBoard.toString());
		
		int result = prBoardService.recommendCheck(prBoard);
		
		logger.info("요건 첨에 나올 : " + result);
		
		int recommendCnt = prBoardService.recommendView(prBoard);
		
		//	VIEW에 모델(MODEL)값 전달하기
		model.addAttribute("result", result);
		
		model.addAttribute("recommendCnt", recommendCnt);
		return "prboard/recheck";
	}
	
	
	@RequestMapping(value="/prboard/addComment", method=RequestMethod.POST)
	public ModelAndView addCommentPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			logger.info("댓글 등록 테스트  : " + reply);
			//유저 번호 저장
			reply.setUserno(prBoardService.getUserNoForReply((String)session.getAttribute("usernick")).getUserno());
			logger.info("서비스 후  : " + reply);
			
			//댓글 삽입
			prBoardService.addReply(reply);
			
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
	
	@RequestMapping(value="/prboard/commentList", method=RequestMethod.POST)
	public ModelAndView commentListPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		int reReplyCnt = 0;
		
		ArrayList<HashMap> reList = new ArrayList<HashMap>();
		
        // 해당 게시물 댓글 리스트 불러오기
        List<Reply> replyVO = prBoardService.getReplyByboardNo(reply);
        
        
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
                reReplyCnt = prBoardService.getREreplyCnt(replyVO.get(i).getGroupno());
                
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
	
	@RequestMapping(value="/prboard/deletereReply", method=RequestMethod.POST)
	public ModelAndView deleteReReplyPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("답글 삭제 테스트  : " + reply);

		// 댓글 삭제
		prBoardService.deleteReplyByNo(reply);

		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/prboard/deleteComment", method=RequestMethod.POST)
	public ModelAndView deleteCommentPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("댓글 삭제 테스트  : " + reply);

		// 1. 댓글번호로 그룹번호 가져오기
		int groupNo = prBoardService.getGroupNoByReplyNo(reply);
		
		// 2. 삭제할 댓글의 답글 삭제
		prBoardService.deleteReReplyByGroupNo(groupNo);
		
		// 3.댓글 삭제
		prBoardService.deleteReplyByNo(reply);

		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/prboard/modifyComment", method=RequestMethod.POST)
	public ModelAndView modifyCommentPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("댓글 수정 테스트  : " + reply);

		//댓글 수정
		prBoardService.updateReplyByNo(reply);

		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/prboard/ReReplyList", method=RequestMethod.POST)
	public ModelAndView reReplyListPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		int reReplyCnt = 0;
		
		ArrayList<HashMap> reReplyList = new ArrayList<HashMap>();
		
		// 1. 댓글번호로 그룹번호 가져오기
		int groupNo = prBoardService.getGroupNoByReplyNo(reply);
		
        // 해당 댓글 답글리스트 불러오기
        List<Reply> replyVO = prBoardService.getReReplyByNo(groupNo);
        
        if(replyVO.size() > 0){
            for(int i=0; i<replyVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("replyno", replyVO.get(i).getReplyno());
                hm.put("boardno", replyVO.get(i).getBoardno());
                hm.put("recontents", replyVO.get(i).getRecontents());
                hm.put("usernick", replyVO.get(i).getUsernick());
                hm.put("replydate", replyVO.get(i).getReplydate());
                
                //답글 갯수 구하기
                reReplyCnt = prBoardService.getREreplyCnt(replyVO.get(i).getGroupno());
                
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
	
	@RequestMapping(value="/prboard/addReReply", method=RequestMethod.POST)
	public ModelAndView addReReplyPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			// 1. 유저 번호 저장
			reply.setUserno(prBoardService.getUserNoForReply((String)session.getAttribute("usernick")).getUserno());

			// 2. 댓글번호를 이용해 그룹 번호 담기
			reply.setGroupno(prBoardService.getGroupNoByReplyNo(reply));
			
			// 3. 그룹번호를 이용한 댓글 그룹의 최대 ReplyOrder + 1을 객체에 담기
			reply.setMaxreplyorder(prBoardService.getMaxReplyOrder(reply) + 1);
			
			logger.info("답글 컨트롤러 테스트 : " + reply);
			
			
			//답글 삽입
			prBoardService.addReReply(reply);
			
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
	
	@RequestMapping(value="/prboard/replycheck", method=RequestMethod.GET)
	public String replyCheckPR(Reply reply, Model model, HttpSession session) {
		
		
		//댓글 번호 저장
		int replyno = reply.getReplyno();
		
		// 1. 회원 번호 구하기
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null) {
			reply = prBoardService.getUserNoForReplyLike((String)session.getAttribute("usernick"));
		}
		
		reply.setReplyno(replyno);
		
		logger.info("댓글 좋아요 테스트 : " + reply.toString());
		
		int result = prBoardService.replyRecommendCheck(reply);
		
		logger.info("요건 댓글 첨에 : " + result);
//		
		int replyRecommendCnt = prBoardService.replyRecommendView(reply);
//		
		//	VIEW에 모델(MODEL)값 전달하기
		model.addAttribute("result", result);
		
		model.addAttribute("replyno", replyno);
		
		model.addAttribute("replyRecommendCnt", replyRecommendCnt);
		return "prboard/replycheck";
	}
	
}
	
	
