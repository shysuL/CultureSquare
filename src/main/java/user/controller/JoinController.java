package user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.dto.User_table;
import user.service.face.UserSendMailService;
import user.service.face.UserService;
import util.PwSha256;

@Controller
public class JoinController {

	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);
	
	@Autowired UserService userService;
	@Autowired UserSendMailService joinSendMailService;
	
	// 회원가입 폼만 띄우기
	@RequestMapping(value="/user/joinForm")
	public void joinForm() {
//		logger.info("회원가입폼 접속 TEST -완료- ");
	}
	
	
	// 회원가입 입력한 폼 처리
	@RequestMapping(value="/user/joinProc", method=RequestMethod.POST)
	public String joinProc(User_table user, Model model, HttpServletRequest req, HttpSession session) { 
		
//		logger.info(user.toString()); // form 입력 값 잘 받아오는지 -완료-
		
		//비밀번호 확인
//		logger.info("사용자가 입력한  비밀번호 : " + user.getUserpw());
		
		// 비밀번호 암호화 SHA256
		String encPw = PwSha256.userPwEncSHA256(user.getUserpw());
		user.setUserpw(encPw);
		// SHA256암호화 후 비밀번호 확인
//		logger.info("SHA256암호화 후 비밀번호 : " + user.getUserpw());
		
		// 회원가입처리 // usertype = 예술인일 때 permit을 1로 준다.
		if(user.getUsertype()==1) {
			user.setPermit(1);
		}
		userService.joinProc(user);
				
		// 메일 인증 발송
		joinSendMailService.mailSendWithEmailKey(user.getUserid(), user.getUsername(), req);
		
		model.addAttribute("usermailcheck", user);
		session.setAttribute("emailcheck", "N");
		
		return "/main/main";
		
	}
	
	// 이메일 인증 후
	@RequestMapping(value="/user/emailCheckComplete")
	public String emailCheckComplete(@RequestParam("userid") String userid, @RequestParam("emailcheck") String key) {
		
		joinSendMailService.emailCheckComplete(userid, key);
		
		return "/user/emailCheckSuccess";
		
	}
	
	// 아이디(이메일) 중복체크
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	public ModelAndView idCheck(@RequestParam("userid") String userid, ModelAndView mav) {
		
		mav.addObject("idCheck",userService.userIdCheck(userid));
		mav.setViewName("jsonView");
		logger.info("idCheck(0-사용가능, 1-중복id) : " + mav.toString());
		return mav;
	}
	
	// 닉네임 중복체크
	@RequestMapping(value="/user/nickCheck", method=RequestMethod.POST)
	public ModelAndView nickCheck(@RequestParam("usernick") String usernick, ModelAndView mav) {
		
		mav.addObject("nickCheck", userService.userNickCheck(usernick));
		mav.setViewName("jsonView");
		logger.info("nickCheck(0-사용가능, 1-중복nick) : " + mav.toString());
		return mav;
		
	}
	
}
