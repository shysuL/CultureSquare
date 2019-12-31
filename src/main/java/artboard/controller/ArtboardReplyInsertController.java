package artboard.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import artboard.dto.Reply;
import artboard.service.face.PFBoardService;

@Controller
public class ArtboardReplyInsertController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardReplyInsertController.class);
	
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
}
