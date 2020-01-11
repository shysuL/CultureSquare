package artboard.controller;


import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import artboard.dto.Reply;
import artboard.service.face.PFBoardService;

@Controller
public class ArtboardReplyController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardReplyController.class);
	
	@Autowired PFBoardService pfboardService;
	
	@RequestMapping(value = "/reply/insert", method = RequestMethod.GET)
	public void replyInsert(Reply reply) {	
		replyInsertProc(reply);
		
	}
	
	@RequestMapping(value = "/reply/insert", method = RequestMethod.POST)
	public String replyInsertProc(Reply reply) {
		
//		logger.info(reply.toString());
		// 전달받은 댓글 내용을 입력
		pfboardService.insertReply(reply);
		
		return "redirect:/artboard/view?boardno="+reply.getBoardno();
	}
	
//	@RequestMapping(value = "/reply/delete", method = RequestMethod.GET)
//	public void replyDelete(Reply reply, Writer out) {
//		replyDeleteProc(reply, out);
//	}
	
	
	@RequestMapping(value = "/reply/delete", method = RequestMethod.POST)
	public ModelAndView replyDeleteProc(Model model, Reply reply, HttpSession session, ModelAndView mav) {
		
		logger.info("댓글 삭제 테스트  : " + reply);
		
		// 1.댓글 좋아요 삭제
		
		// 2. 댓글번호로 그룹번호 가져오기
		int groupNo = pfboardService.getGroupNoByReplyNo(reply);
		
		// 3. 삭제할 댓글의 답글 삭제
		
		// 4. 댓글 삭제
		pfboardService.deleteReply(reply);
		
		//viewName지정하기
		mav.setViewName("jsonView");
				
		return mav;
	}
	
	@RequestMapping(value = "/reply/reinsert", method = RequestMethod.GET)
	public void rereplyInsert(Reply reply) {
		
	}
	
	@RequestMapping(value = "/reply/reinsert", method = RequestMethod.POST)
	public String rereplyInsertProc(Reply reply,
			@RequestParam("rerecontents") String rerecontents) {
		
		reply.setRecontents(rerecontents);
		
		logger.info("대댓글 입력 : " +  reply);
		
//		pfboardService.insertRereply(reply);
		
		return "redirect:/artboard/view?boardno="+reply.getBoardno();
	}
	
	
}
