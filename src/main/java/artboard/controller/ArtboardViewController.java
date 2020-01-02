package artboard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import artboard.dto.Board;
import artboard.dto.Donation;
import artboard.dto.Reply;
import artboard.service.face.PFBoardService;

@Controller
public class ArtboardViewController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardViewController.class);
	@Autowired PFBoardService pfboardService;
	@Autowired HttpSession session;
	

	@RequestMapping(value = "/artboard/view", method = RequestMethod.GET)
	public void pfView(Board bno, Model model, Board LoginUser) {
		
		
		// 전달받은 파라미터 (boardno)에 해당하는 게시글 상세보기
		Board viewboard = pfboardService.view(bno);
		
		// 조회된 게시글 모델로 전달
		model.addAttribute("view", viewboard);
//		logger.info(viewboard.toString());
		
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
}
