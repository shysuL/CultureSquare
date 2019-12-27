package mypage.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.dto.User_table;

@Controller
public class MypageMainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MypageMainController.class);
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.GET)
	public void mypage(HttpSession session) {
		//마이페이지 폼 띄어주는 메소드
		
	}
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.POST)
	public void mypageInfo(HttpSession session, Model model, User_table user) {
		
	}

}
