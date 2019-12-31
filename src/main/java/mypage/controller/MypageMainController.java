 package mypage.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
		user.setUsernick(session.getAttribute("usernick").toString());
		
		if(session.getAttribute("userno") != null) {

			user.setUserno((Integer)session.getAttribute("userno"));
			
		}
		
		User_table getUser = mypageService.getUserInfo(user);
		
		model.addAttribute("getUser", getUser);
		
		User_table userInfo = new User_table();
		
		userInfo = mypageService.getFindUserPw(user);
		
		model.addAttribute("userinfo", userInfo);
		
		System.out.println(userInfo);
	}
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.POST)
	public String mypage(User_table user, Model model, HttpSession session, String changepw) {
		
		//세션에서 로그인한 사용자의 userno와 userid, usernick 가져와서 user객체에 담기
		user.setUserid(session.getAttribute("userid").toString());
		user.setUserno((Integer)session.getAttribute("userno"));
		user.setUsernick(session.getAttribute("usernick").toString());
		
		//새로운 userInfo객체 생성
		User_table userInfo = new User_table();
		
		//로그인한 사용자의 비밀번호 조회해서 userInfo객체에 담기
		System.out.println(user);
		userInfo = mypageService.getFindUserPw(user); // DB에 있는 비밀번호
		System.out.println(user);
		System.out.println("디비에 있는 암호화된 비밀번호 : " + userInfo.getUserpw());
		
		// 로그인시 입력한 비밀번호를 SHA256으로 암호화
		System.out.println(user);
		String encPw = user.getUserpw();
		user.setUserpw(PwSha256.userPwEncSHA256(encPw)); // 현재비밀번호를 암호화 한거
		System.out.println("로그인 시 입력한 암호화된 비밀번호 : " + user.getUserpw());
		
		//boolean타입으로 true/false를 이용해서 현재 비밀번호와 사용자가 입력한 비밀번호가 맞는지 확인
		boolean password01 = mypageService.equalsPw(user);
		System.out.println("비밀번호 일치여부(true/false): " + password01);
		
		if(password01) { //일치여부가 true이면
			
			String encPw2 = changepw;
			user.setUserpw(PwSha256.userPwEncSHA256(encPw2));
//			
			System.out.println("변경되니?" + changepw);
			
//			mypageService.modifyUserPassword(changepw);
			mypageService.modifyUserPassword(user);
			

			return "/redirect:/main/main";
			
		} else {
			return "/redirect:/mypage/main";
		}		
		
	}
	
	@RequestMapping(value="/mypage/curpwCheck", method=RequestMethod.POST)
	public ModelAndView currentPwCheck(ModelAndView mav, HttpSession session, User_table user) {
		
		//세션에서 로그인한 사용자의 userno와 userid, usernick 가져와서 user객체에 담기
		user.setUserno((Integer)session.getAttribute("userno"));
		
		//암호화
		String encPw = user.getUserpw();
		user.setUserpw(PwSha256.userPwEncSHA256(encPw)); // 현재비밀번호를 암호화 한거
		System.out.println("로그인 시 입력한 암호화된 비밀번호 : " + user.getUserpw());
		
		boolean lock = mypageService.comparedPw(user);
		
		mav.addObject("lock", lock);
		
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
}
