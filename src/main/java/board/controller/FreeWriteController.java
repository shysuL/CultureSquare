package board.controller;

import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import board.dto.FreeBoard;
import board.dto.UpFile;
import board.service.face.FreeBoardService;
import user.dto.User_table;
import user.service.face.UserService;


@Controller
public class FreeWriteController {
	
	@Autowired ServletContext context;
	@Autowired FreeBoardService freeboardService;
	@Autowired UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(FreeWriteController.class);

	@RequestMapping(value = "/board/freewrite", method = RequestMethod.GET)
	public void freeWrite(Model model, HttpSession session) {
		
		System.out.println("요청 확인");

	}
	
	@RequestMapping(value = "/board/freewrite", method = RequestMethod.POST)
	public String freeWrite(Model model, FreeBoard freeboard, HttpSession session, UpFile upfile) {
		
		logger.info(upfile.toString());
		logger.info(freeboard.toString());
		
		//로그인한 유저 정보 조회 
		FreeBoard user = freeboardService.getUserNoByNick(session.getAttribute("usernick"));
		
		freeboard.setUsernick(user.getUsernick());
		freeboard.setUserno(user.getUserno());
//		logger.info(user.toString());
		
		//게시글 작성 날짜
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd");
		String formatTime = format.format (System.currentTimeMillis());
		
		freeboard.setWrittendate(formatTime);
		
		logger.info(freeboard.toString());
		
		logger.info(upfile.toString());
		
		if(upfile.getFile().isEmpty()) {
			
			freeboardService.writeFree(freeboard);
			
		} else {
			
			freeboardService.writeFree(freeboard);
			
			logger.info(freeboard.toString());
			
			freeboardService.filesave(upfile, freeboard.getBoardno());
			
		}
		
		return "redirect:/board/freelist";
		
	}

}
