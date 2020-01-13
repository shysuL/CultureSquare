package admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import board.dto.FreeBoard;
import board.service.face.NoticeBoardService;

@Controller
public class AdminWriteController {

	@Autowired private NoticeBoardService noticeboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminWriteController.class);
	
	@RequestMapping(value="/admin/board/noticewrite", method=RequestMethod.GET)
	public void noticeWrite() {
		
		System.out.println("공지사항 작성 나와라");
		
	}

	@RequestMapping(value="/admin/board/noticewrite", method=RequestMethod.POST)
	public String noticeWrite(Model model, FreeBoard noticeboard) {
		
		noticeboardService.writeNotice(noticeboard);
		
		return "redirect:/admin/main";
	}
}
