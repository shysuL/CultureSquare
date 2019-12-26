package mypage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import user.dto.User_table;

@Controller
public class MyPwModifyController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyPwModifyController.class);
	
	@RequestMapping(value="/mypage/updatepw", method=RequestMethod.GET)
	public void getUserPw(User_table user) {
		
	}
	
	@RequestMapping(value="/mypage/updatepw", method=RequestMethod.GET)
	public void getCurrentUserPw(Model model) {
		
	}

	@RequestMapping(value="/mypage/updatepw", method=RequestMethod.GET)
	public void equalsPw(User_table user) {
		
	}
	
	
	@RequestMapping(value="/mypage/updatepw", method=RequestMethod.GET)
	public void modifyUserPw(User_table user) {
		
	}
	

}
