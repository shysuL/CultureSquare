package mypage.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import mypage.service.face.MyPageService;
import user.dto.User_table;

@Controller
public class MyPwModifyController {
	
	@Autowired private MyPageService mypageService;
	
	private static final Logger logger = LoggerFactory.getLogger(MyPwModifyController.class);
	
	@RequestMapping(value="/mypage/updatepw", method=RequestMethod.GET)
	public void modifyUserPwForm(User_table user, HttpSession session, Model model) {
		
		logger.info("나오냐");
		
		user.setUserid(session.getAttribute("userid").toString());
		user.setUserno((int)session.getAttribute("userno"));
		
//		mypageService.getFindUserPw(user);
		
		model.addAttribute("user", user);
		
	}

	@RequestMapping(value="/mypage/updatepw", method=RequestMethod.POST)
	public void modifyUserPw(User_table user, HttpSession session, Model model) {
		
		logger.info("나오냐2");
		
	}
	

}
