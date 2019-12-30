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
		
	}
}
