package artboard.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import artboard.dto.Board;
import artboard.service.face.PFBoardService;

@Controller
public class ArtboardWriteController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardWriteController.class);
	@Autowired PFBoardService pfboardService;
	@Autowired HttpSession session;
	

	@RequestMapping(value = "/artboard/write", method=RequestMethod.GET)
	public void write(Board board) {
		
		logger.info(session.getAttribute("userno").toString());
		
//		board.setUserno((int) session.getAttribute("userno"));
		
//		System.out.println("userno : " + board.getUserno());
		
	}

	@RequestMapping(value = "/artboard/write", method=RequestMethod.POST)
	public String writeProc(Board board) {
		
		board.setUserno((int) session.getAttribute("userno")); 
		System.out.println(board.toString());
		pfboardService.write(board);
		
//		logger.info(board.getPerformname());
//		logger.info(board.getPerformdate());
		        
		
		return "redirect:/artboard/list";
	}
}
