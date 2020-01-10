package admin.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import artboard.dto.Board;
import artboard.dto.PFUpFile;
import artboard.dto.Reply;
import artboard.service.face.PFBoardService;

@Controller
public class AdminBoardViewController {
	
	@Autowired private PFBoardService pfboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminBoardViewController.class);
	
	@RequestMapping(value="/admin/board/view/pfview", method=RequestMethod.GET)
	public void pfview(Board bno, Model model) {
		
		Board viewPF = pfboardService.view(bno);
		model.addAttribute("viewpf", viewPF);
		
		List<PFUpFile> fileList = pfboardService.getFileList(viewPF.getBoardno());
		
		model.addAttribute("fileList", fileList);
		System.out.println("PF파일" + fileList);
		
		Board userno = new Board();
		userno.setUserno(viewPF.getUserno());
		
		Board writer = pfboardService.getWriter(userno);
		model.addAttribute("writer", writer);
		
		Reply reply = new Reply();
		List<Reply> replyList = pfboardService.getReplyList(bno);
		model.addAttribute("replyList", replyList);
	}
	
	

}
