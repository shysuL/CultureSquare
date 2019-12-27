package mypage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import user.dto.User_table;

@Controller
public class MyInfoModifyController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyInfoModifyController.class);
	
	@RequestMapping(value="/mypage/updateform", method=RequestMethod.GET)
	public void updateform() {
		//개인정보 수정 폼을 보여주는 메소드
	}
	
	@RequestMapping(value="/mypage/updatephoto", method=RequestMethod.GET)
	public void modifyProfilePhoto(Model model) {
		
	}
	
	@RequestMapping(value="/mypage/updatenick", method=RequestMethod.GET)
	public void modifyUserNick() {
		
	}
	
	@RequestMapping(value="/mypage/phone", method=RequestMethod.GET)
	public void modifyUserPhone(User_table user) {
		
	}
	
	@RequestMapping(value="/mypage/interest", method=RequestMethod.GET)
	public void modifyInterest() {
		
	}

}
