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
public class MyInfoModifyController {
	
	@Autowired MyPageService mypageService;
	
	private static final Logger logger = LoggerFactory.getLogger(MyInfoModifyController.class);
	
	@RequestMapping(value="/mypage/updateform", method=RequestMethod.GET)
	public void updateform() {
		//개인정보 수정 폼을 보여주는 메소드
	}
	
	//사용자 개인정보 수정
	@RequestMapping(value="/mypage/updateform", method=RequestMethod.POST)
	public void modifyUserInfo(User_table user, HttpSession session) {
		
		mypageService.getUserInfo(user);
		
		logger.info("사용자 현재 개인정보 : " + mypageService.getUserInfo(user));
		
		//세션에 저장되어있는 사용자의 닉네임 불러오기
		Object obj = session.getAttribute("usernick");
		
		//변경할 닉네임
		Object obj1 = user.getUsernick();
		
		logger.info("닉네임 : " + obj);
		logger.info("닉네임1 : " + obj1);

		mypageService.modifyUserNick(user);
		
	}


}
