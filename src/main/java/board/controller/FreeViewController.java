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
import org.springframework.web.servlet.ModelAndView;

import board.dto.FreeBoard;
import board.dto.UpFile;
import board.service.face.FreeBoardService;

@Controller
public class FreeViewController {
	
	@Autowired FreeBoardService freeboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(FreeViewController.class);

	@RequestMapping(value = "/board/freeview", method = RequestMethod.GET)
	public void freeDetail(Model model, @RequestParam("boardno") int boardno, HttpSession session) {
		
		//조회수 증가
		freeboardService.increaseViews(boardno);
		
		FreeBoard boardDetail = freeboardService.freeDetail(boardno);
		UpFile fileinfo = freeboardService.getFile(boardno);
		
//		System.out.println(boardDetail);
		
		logger.info(boardDetail.toString());
		
		model.addAttribute("board", boardDetail);
		model.addAttribute("file", fileinfo);
		
	}
	
	@RequestMapping(value = "/board/freemodifiy")
	public void modifiyFree(Model model, HttpSession session, @RequestParam("boardno") int boardno) {
		
		FreeBoard boardDetail = freeboardService.freeDetail(boardno);	
		UpFile fileinfo = freeboardService.getFile(boardno);
		
		model.addAttribute("board", boardDetail);
		model.addAttribute("file", fileinfo);
	}
	
	@RequestMapping(value = "/board/freemodifiy", method = RequestMethod.POST)
	public String modifiyFree(Model model, HttpSession session, FreeBoard freeboard) {
		
		logger.info(freeboard.toString());
		
		freeboardService.updateFreeBoard(freeboard);
		
		return "redirect:/board/freelist";
		
	}
	
	@RequestMapping(value = "/board/freedelete", method = RequestMethod.GET)
	public String deleteFreeProc(@RequestParam("boardno") int boardno, HttpSession session, int fileno) {
		
		if(fileno != 0) {
		
			freeboardService.freeDelete(boardno);
			
			freeboardService.fileDelete(fileno);
			
		}else {
			
			freeboardService.freeDelete(boardno);
		
		}
		
		return "redirect:/board/freelist";
	}
	
	@RequestMapping(value = "/board/download")
	public ModelAndView download(int fileno, ModelAndView mav) {
		
		//파일번호에 해당하는 파일 정보 가져오기
		UpFile file = freeboardService.getFileNo(fileno);
		
		logger.info(file.toString());

		//파일정보를 MODEL 값으로 지정하기
		mav.addObject("downFile", file);

		//viewName 지정하기
		mav.setViewName("down");

		return mav;

	}

}
