package user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class JoinController {

	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);
	
	@RequestMapping(value="/user/joinForm")
	public void joinForm() {
		logger.info("회원가입폼 접속 ! ");
	}
	
	@RequestMapping(value="/user/joinForm", method=RequestMethod.POST)
	public String joinProc() {
		
		
		
		return "redirect:/main/main";
		
	}
	
}
