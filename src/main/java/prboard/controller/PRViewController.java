package prboard.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import prboard.dto.PRBoard;
import prboard.dto.UpFile;
import prboard.service.face.PRBoardService;

@Controller
public class PRViewController {

	@Autowired private PRBoardService prBoardService;
	
	private static final Logger logger = LoggerFactory.getLogger(PRViewController.class);
	
	@RequestMapping(value="/prboard/view", method=RequestMethod.GET)
	public void viewPR(Model model, PRBoard prboard) {
		
		//게시글 세부정보 조회
		PRBoard viewBoard = prBoardService.getViewInfo(prboard.getBoardno());
		model.addAttribute("viewBoard", viewBoard);
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(viewBoard.getBoardno());
		
		model.addAttribute("fileList", list);
		
	}
}
