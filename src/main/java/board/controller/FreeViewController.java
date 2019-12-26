package board.controller;

import javax.servlet.http.HttpSession;

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

@Controller
public class FreeViewController {
	
	@Autowired FreeBoardService freeboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(FreeViewController.class);

	@RequestMapping(value = "/freeboard/view", method = RequestMethod.GET)
	public void freeView(Model model, @RequestParam("boardno") int boardno, HttpSession session) {
		
		//조회수 증가
		freeboardService.increaseViews(boardno);
		
		FreeBoard boardDetail = freeboardService.freeDetail(boardno);
		
//		System.out.println(boardDetail);
		
		logger.info(boardDetail.toString());
		
		model.addAttribute("board", boardDetail);
		
	}

}
