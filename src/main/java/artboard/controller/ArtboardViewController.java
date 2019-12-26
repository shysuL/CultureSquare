package artboard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import artboard.dto.Board;
import artboard.service.face.PFBoardService;

@Controller
public class ArtboardViewController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardViewController.class);
	@Autowired PFBoardService pfboardService;
	

	@RequestMapping(value = "/artboard/view", method = RequestMethod.GET)
	public void pfView(Board bno, Model model) {
		
		Board viewboard = pfboardService.view(bno);
		
		logger.info(viewboard.toString());
		model.addAttribute("view", viewboard);
		
		Board userno = new Board();
		userno.setUserno(viewboard.getUserno());
//		System.out.println(userno.getUserno());
		
		Board writer = pfboardService.getWriter(userno);
		
//		System.out.println("test : " + writer.toString());
		
		model.addAttribute("writer", writer);
		
	}
}
