package artboard.controller;

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
	

	@RequestMapping(value = "/artboard/write", method=RequestMethod.GET)
	public void write() {}

	@RequestMapping(value = "/artboard/write", method=RequestMethod.POST)
	public String writeProc(Board board) {
		
		pfboardService.write(board);
		
//		logger.info(board.getPerformname());
//		logger.info(board.getPerformdate());
		        
		
		return "redirect:/artboard/list";
	}
}
