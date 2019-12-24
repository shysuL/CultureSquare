package user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import mypage.dto.User_table;

@Controller
public class JoinController {

	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);
	
	@RequestMapping(value="/user/joinForm")
	public void joinForm() {
		logger.info("회원가입폼 접속 ! ");
	}
	
	@RequestMapping(value="/user/joinProc", method=RequestMethod.POST)
	public String joinProc(User_table user, Model model) {
		
		logger.info(user.toString());
		
		return "redirect:/main/main";
		
	}
	
}
