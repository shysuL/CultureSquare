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
		
//		logger.info("아트보드");
		
		paging = pfboardService.getPaging(paging);
		
		model.addAttribute("paging",paging);
		
//		logger.info(paging.toString()); 
		
		List<Board> list = pfboardService.getList(paging);
		    		
		model.addAttribute("list", list);
		
		logger.info(list.toString()); 
		
	}

}
