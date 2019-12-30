package mypage.controller;

import java.util.ArrayList;
import java.util.List;

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
	@Autowired HttpSession session;
	private static final Logger logger = LoggerFactory.getLogger(MyInfoModifyController.class);
	
	@RequestMapping(value="/mypage/updateform", method=RequestMethod.GET)
	public void updateform(User_table user, Model model) {
		
		user.setUserno((int) session.getAttribute("userno"));
		
		User_table getUser = mypageService.getUserInfo(user);
		
//--------------------------------------------------------------------	
		//체크박스로 선택한 사용자의 interest 관심분야 
//		String[] checkInterest = null;
//		
//		for(int i = 0; i<getUser.getInterest().length(); i++) {
//			checkInterest = getUser.getInterest().split(",");   
//			
//		}
//		
//		for (String string : checkInterest) {
//			System.out.println("1 : " + string);
//		}
//		
//		List checkList = new ArrayList();
//		
//		for(int i = 0 ; i<checkInterest.length; i++) {
//			checkList.add(checkInterest[i]);
//		}
//		
//		System.out.println(checkList);
//		getUser.setInterest(checkInterest);
		
//		model.addAttribute("checkList", checkList);
		model.addAttribute("checkList", getUser.getInterest().split(","));
		
//--------------------------------------------------------------------	
		
		model.addAttribute("getUser", getUser);
		
		logger.info("2 : " + getUser.toString());

		logger.info("사용자 번호 : " + session.getAttribute("userno").toString());

	}
	
	//사용자 개인정보 수정
	@RequestMapping(value="/mypage/updateform", method=RequestMethod.POST)
	public void modifyUserInfo(User_table user) {
		
		logger.info(session.getAttribute("userno").toString());
		
		mypageService.getUserInfo(user);
		
		logger.info("사용자 현재 개인정보 : " + mypageService.getUserInfo(user));
		
		//세션에 저장되어있는 사용자의 닉네임 불러오기
		Object obj = session.getAttribute("usernick");
//		
//		//변경할 닉네임
		Object obj1 = user.getUsernick();
//		
		logger.info("닉네임 : " + obj);
		logger.info("닉네임1 : " + obj1);
//
		mypageService.modifyUserNick(user);
		
	}


}
