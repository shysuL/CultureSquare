package board.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import board.service.face.FreeBoardService;
import user.dto.User_table;
import user.service.face.UserService;


@Controller
public class FreeWriteController {
	
	@Autowired FreeBoardService freeboardService;
	@Autowired UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(FreeWriteController.class);

	@RequestMapping(value = "/freeboard/write", method = RequestMethod.GET)
	public void freeWrite(Model model, HttpSession session) {
		
		System.out.println("요청 확인");

//		User_table user = userService.getMember(session.getAttribute("loginid"));

//		model.addAttribute("member", member);
	}

}
