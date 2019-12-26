package artboard.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import artboard.dto.Board;
import artboard.service.face.PFBoardService;
import util.Paging;


@Controller
public class ArtboardListController {
	
	private static final Logger logger = LoggerFactory.getLogger(ArtboardListController.class);
	@Autowired PFBoardService pfboardService;
	
	@RequestMapping(value = "/artboard/list", method = RequestMethod.GET)
	public void pfList(Model model, Paging paging) {
				
		paging = pfboardService.getPaging(paging);
		
		model.addAttribute("paging",paging);
		
//		logger.info(paging.toString()); 
		
		List<Board> list = pfboardService.getList(paging);
		    		
		model.addAttribute("list", list);
		
//		logger.info(list.toString()); 
		
	}
	
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
	
	@RequestMapping(value = "/artboard/write", method=RequestMethod.GET)
	public void write() {}

}
