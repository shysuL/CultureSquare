package board.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.dto.FreeBoard;
import board.service.face.FreeBoardService;
import util.Paging;

@Controller
public class FreeListController {
	
	@Autowired FreeBoardService freeboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(FreeListController.class);
	
	@RequestMapping(value = "/freeboard/list", method = RequestMethod.GET)
	public void boardlist(Model model, @RequestParam(defaultValue = "1") int curPage) {
		
//		int listCnt = boardService.getListCnt();
		
		Paging paging = new Paging(freeboardService.getListCnt(), curPage);
				
		model.addAttribute("paging", paging);

		List<FreeBoard> list = freeboardService.getList(paging);
		
//		logger.info(list.toString());
		
		model.addAttribute("boardlist", list);
		
	}

}
