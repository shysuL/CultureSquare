package prboard.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
		
		logger.info("파일 테스트 : " + list);
		
	}
	
	@RequestMapping(value="/prboard/download")
	public ModelAndView download(int fileno, //파일번호 파라미터
			ModelAndView mav) {
		
		logger.info("파일번호 : " + fileno) ;
		
		//파일 번호에 해당하는 파일 정보 가져오기
		UpFile file = prBoardService.getFile(fileno);
		
		logger.info("조회된 파일 : " + file);
		
		//파일 정보를 MODEL 값으로 지정하기
		mav.addObject("downFile", file);
		
		//viewName 지정하기
		mav.setViewName("prdown");
		
		return mav;
	}
}
