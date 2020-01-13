package artboard.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import artboard.dto.Board;
import artboard.dto.Donation;
import artboard.dto.PFUpFile;
import artboard.dto.Reply;
import artboard.service.face.PFBoardService;
import prboard.dto.UpFile;
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
		Board viewBoard = pfboardService.view(bno);

		// 조회된 게시글 모델로 전달
		model.addAttribute("view", viewBoard);
		//		logger.info(viewboard.toString());

		//게시글 첨부파일 조회
		List<PFUpFile> list = pfboardService.getFileList(viewBoard.getBoardno());

		model.addAttribute("fileList", list);

		logger.info("파일 테스트 : " + list);

		// 전달받은 파라미터(boardno)에 해당하는 게시글 작성자(userno)로 작성자 정보 조회
		Board userno = new Board();
		userno.setUserno(viewBoard.getUserno());
		//		System.out.println(userno.getUserno());

		Board writer = pfboardService.getWriter(userno);
		
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
		logger.info(" 댓글 리스트 테스트*** : " + reList.toString());
		logger.info("리스트 크기*** : " + reList.size());
		
		mav.addObject("reList", reList);

		mav.setViewName("jsonView");

		return mav;

	}

	@RequestMapping(value="/artboard/ReReplyList", method=RequestMethod.POST)
	public ModelAndView reReplyListPF(Model model, Reply reply, HttpSession session, ModelAndView mav) {

		int reReplyCnt = 0;

		ArrayList<HashMap> reReplyList = new ArrayList<HashMap>();

		// 1. 댓글번호로 그룹번호 가져오기
		int groupNo = pfboardService.getGroupNoByReplyNo(reply);
		
		// 해당 댓글 답글리스트 불러오기
		List<Reply> replyVO = pfboardService.getReReplyByNo(groupNo);
		
		if(replyVO.size() > 0){
            for(int i=0; i<replyVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("replyno", replyVO.get(i).getReplyno());
                hm.put("boardno", replyVO.get(i).getBoardno());
                hm.put("recontents", replyVO.get(i).getRecontents());
                hm.put("usernick", replyVO.get(i).getUsernick());
                hm.put("replydate", replyVO.get(i).getReplydate());
         
                //답글 갯수 구하기
                reReplyCnt = pfboardService.getREreplyCnt(replyVO.get(i).getGroupno());
                
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

	@RequestMapping(value = "/artboard/addReReply", method = RequestMethod.POST)
	public ModelAndView addReReplyPR(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!=null ) {
			// 1. 유저 번호 저장
			reply.setUserno(pfboardService.getUserNoForReply((String)session.getAttribute("usernick")).getUserno());
			
			// 2. 댓글번호를 이용해 그룹 번호 담기
			reply.setGroupno(pfboardService.getGroupNoByReplyNo(reply));
			
			// 3. 그룹번호를 이용한 댓글 그룹의 최대 ReplyOrder + 1을 객체에 담기
			reply.setMaxreplyorder(pfboardService.getMaxReplyOrder(reply) + 1);
			
			pfboardService.addReReply(reply);

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
	

	@RequestMapping(value="/pfboard/download")
	public ModelAndView download(int fileno, //파일번호 파라미터
			ModelAndView mav) {

		logger.info("파일번호 : " + fileno) ;

		//파일 번호에 해당하는 파일 정보 가져오기
		PFUpFile file = pfboardService.getFile(fileno);

		logger.info("조회된 파일 : " + file);
		//파일 정보를 MODEL 값으로 지정하기
		mav.addObject("downFile", file);

		logger.info("1");
		//viewName 지정하기
		mav.setViewName("pfdown");
		logger.info("2");

		return mav;
	}

	@RequestMapping(value = "/artboard/recommend", method = RequestMethod.GET)
	public String recommendPF(Board board, Model model,HttpSession session) {

		//보드 번호 저장
		int boardno = board.getBoardno();
		Board loginUser = new Board();
		
		loginUser.setUsernick((String)session.getAttribute("usernick"));
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!= null) {
			// 1. 회원 번호 구하기
			board.setBoardno(boardno);
			board.setUserno(pfboardService.getUsernoByUsernick(loginUser));


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
	
	@RequestMapping(value = "/artboard/recheck", method = RequestMethod.GET)
	public String reCheckPF(Board board, Model model, HttpSession session) {
		
		//보드 번호 저장
		int boardno = board.getBoardno();
		Board loginUser = new Board();
		loginUser.setUsernick((String)session.getAttribute("usernick"));
		
		if((String)session.getAttribute("usernick")!=null) {
			int userno = pfboardService.getUsernoByUsernick(loginUser);
			
			board.setUserno(userno);
		}
		
		board.setBoardno(boardno);
		
		logger.info("recheck +++ : " + board.toString());
		
		int result = pfboardService.recommendCheck(board);
		
		logger.info("요건 첨에 나올 : " + result);
		
		int recommendCnt = pfboardService.recommendView(board);
		
		//	VIEW에 모델(MODEL)값 전달하기
		model.addAttribute("result", result);	
		
		model.addAttribute("recommendCnt", recommendCnt);
		return "artboard/recheck";
	}
	
	
	@RequestMapping(value = "/artboard/modify", method = RequestMethod.GET)
	public void modifyPF(Model model, Board bno) {
		
		//게시글 세부정보 조회
		Board viewBoard = pfboardService.view(bno);
		model.addAttribute("view",viewBoard);
		
		//게시글 첨부파일 조회
		List<PFUpFile> list = pfboardService.getFileList(viewBoard.getBoardno());
		model.addAttribute("fileList", list);

		logger.info("수정 게시판 : " + viewBoard);
		logger.info("수정 테스트 : " + list);
	}

	@RequestMapping(value = "/artboard/modifyProc", method = RequestMethod.POST)
	public String modifyPFProc(MultipartHttpServletRequest multi, Board board,	HttpSession session) {
		
		// 리다이렉트 시 게시판 리스트 쿼리스트링 날짜 계산
		// -------------------------------------------------------
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy");
		SimpleDateFormat format2 = new SimpleDateFormat ( "MM");
				
		Date time = new Date();
				
		String nowYear = format1.format(time);
		String nowMonth = format2.format(time);
		// -------------------------------------------------------
		
		String originName="";
		int i = 1;
		boolean firsImage = true;
		
		logger.info("수정 : " + board);
		
		// 1. 게시글 내용 수정
		pfboardService.modifyPF(board);
		
		// 2. 대표 이미지 삭제
		pfboardService.deleteThumbnail(board.getBoardno());
		
		//게시글 첨부파일 조회
		List<PFUpFile> list = pfboardService.getFileList(board.getBoardno());
		
		logger.info("기존 파일 : " + list);
		
		//3. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!list.isEmpty()) {
			//서버에 있는 파일 삭제
			pfboardService.deleteServerFile(list);

			//DB 파일 삭제
			pfboardService.deleteFile(list);
		}
		
		Iterator<String> files = multi.getFileNames();
		
		while(files.hasNext()) {
			String uploadFile = files.next();
			MultipartFile mFile = multi.getFile(uploadFile);
			originName = mFile.getOriginalFilename();
			// 빈파일 처리
			if(originName == null || originName.equals("")) {
				logger.info("빈파일있음");
			}else {
				pfboardService.fileSave(mFile, board.getBoardno());
				
				if( "image".equals(mFile.getContentType().split("/")[0]) ) {
					
					//처음 이미지인 경우 이미지 파일에 업로드
					if(firsImage) {
						pfboardService.firstImageSave(mFile, board.getBoardno());
						firsImage = false;
					}
				}
				logger.info(i + ". 실제 파일 이름 : " + originName);
				i++;
			}
			
		}
		return "redirect:/artboard/list?bo_table=calendar&cal_year="+nowYear+"&cal_month="+nowMonth;
	}
	
	@RequestMapping(value = "/artboard/delete", method = RequestMethod.GET)
	public String deletePF(Board board, HttpSession session) {
		
		// 리다이렉트 시 게시판 리스트 쿼리스트링 날짜 계산
		// -------------------------------------------------------
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy");
		SimpleDateFormat format2 = new SimpleDateFormat ( "MM");
				
		Date time = new Date();
				
		String nowYear = format1.format(time);
		String nowMonth = format2.format(time);
		// -------------------------------------------------------
		
		// 1. 대표 이미지 삭제
		pfboardService.deleteThumbnail(board.getBoardno());
		
		//게시글 첨부파일 조회
		List<PFUpFile> list = pfboardService.getFileList(board.getBoardno());
		
		logger.info("기존 파일 : " + list);

		//2. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!list.isEmpty()) {
			//서버에 있는 파일 삭제
			pfboardService.deleteServerFile(list);

			//DB 파일 삭제
			pfboardService.deleteFile(list);
		}
		
		
		// 게시글 삭제( 삭제된 게시글로 UPDATE ) 
		pfboardService.deletePF(board);
		
		return "redirect:/artboard/list?bo_table=calendar&cal_year="+nowYear+"&cal_month="+nowMonth;
	}
	
	@RequestMapping(value = "/artboard/modifyComment", method = RequestMethod.POST)
	public ModelAndView modifyCommentPF(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("댓글 수정 테스트  : " + reply);

		//댓글 수정
		pfboardService.updateReplyByNo(reply);
		
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
	}

	
	@RequestMapping(value = "/artboard/follow", method = RequestMethod.GET)
	public String followPF(Board board, @RequestParam("userno") int userno,Model model,HttpSession session) {

		//보드 번호 저장
		int boardno = board.getBoardno();
		
		//로그인 상태인 경우만 처리
		if((String)session.getAttribute("usernick")!= null) {
			
			board.setUsernick((String)session.getAttribute("usernick"));
			board.setUserno(userno);
			
			int result = pfboardService.followCheck(board);
			
			//전에 추천한적이 없다면
			if(result == 0) {
				pfboardService.follow(board);
			}else {
				pfboardService.followCancel(board);
			}

			logger.info("버튼 클릭 : " + result);
			logger.info("추천 보드 정보 : " + board);

			int followCnt = pfboardService.followView(board);

			// View에 모델 전달
			model.addAttribute("result",result);

			model.addAttribute("followCnt", followCnt);

			return "artboard/follow";
		}
		//로그아웃일 경우 실패를 받을수 있도록 다시 보냄
		else {
			return "/artboard/view?boardno="+boardno;
		}
	}
	
	@RequestMapping(value = "/artboard/followchk", method = RequestMethod.GET)
	public String followchkPF(Board board,@RequestParam("userno") int userno, Model model, HttpSession session) {
		
		//보드 번호 저장
		int boardno = board.getBoardno();
		
		if((String)session.getAttribute("usernick")!=null) {
			board.setUsernick((String)session.getAttribute("usernick"));
			board.setUserno(userno);
		}
		
		board.setBoardno(boardno);
		
		logger.info("followchk +++ : " + board.toString());
		
		int result = pfboardService.followCheck(board);
		
		logger.info("요건 첨에 나올 : " + result);
		
		int followCnt = pfboardService.followView(board);
		
		//	VIEW에 모델(MODEL)값 전달하기
		model.addAttribute("result", result);	
		
		model.addAttribute("followCnt", followCnt);
		return "artboard/followchk";
	}
}
