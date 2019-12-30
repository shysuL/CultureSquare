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
import util.PwSha256;

@Controller
public class MypageMainController {
	
	@Autowired private MyPageService mypageService;
	
	private static final Logger logger = LoggerFactory.getLogger(MypageMainController.class);
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.GET)
	public void mypage(HttpSession session, User_table user, Model model) {
		
		logger.info("나오냐");
		
		user.setUserid(session.getAttribute("userid").toString());
		user.setUserno((int)session.getAttribute("userno"));
		
		User_table userInfo = new User_table();
		
		userInfo = mypageService.getFindUserPw(user);
		
		model.addAttribute("userinfo", userInfo);
		
		System.out.println(userInfo);
	}
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.POST)
	public String mypage(User_table user, Model model, HttpSession session) {
		
		user.setUserid(session.getAttribute("userid").toString());
		user.setUserno((int)session.getAttribute("userno"));
		
		User_table userInfo = new User_table();
		
		userInfo = mypageService.getFindUserPw(user);

		// 로그인시 입력한 비밀번호를 SHA256으로 암호화
		String encPw = user.getUserpw();
		user.setUserpw(PwSha256.userPwEncSHA256(encPw));
		
		System.out.println("암호화 : " + encPw);
		System.out.println("컨트롤러 : " + userInfo);
		
		//0과 1로 현재 비밀번호와 입력한 현재 비밀번호가 맞는 지 확인
		boolean password01 = mypageService.equalsPw(userInfo);
		System.out.println(password01);
		
		System.out.println(1);
		model.addAttribute("userInfo", userInfo);
		System.out.println(2);
		
		if(password01 == true) {
			System.out.println(3);
			userInfo.setUserpw((String) model.getAttribute("userpw"));
			mypageService.modifyUserPassword(user);
			System.out.println(user.toString());
			return "/redirect:/main/main";
			
		} else {
			System.out.println(4);
			return "/redirect:/mypage/main";
		}
		
	}
}
