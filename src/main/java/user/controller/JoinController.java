package user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import user.dto.User_table;
import user.service.face.UserService;

@Controller
public class JoinController {

	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);
	
	@Autowired UserService userService;
	
	
	// 회원가입 폼만 띄우기
	@RequestMapping(value="/user/joinForm")
	public void joinForm() {
//		logger.info("회원가입폼 접속 TEST -완료- ");
	}
	
	
	// 회원가입 입력한 폼 처리
	@RequestMapping(value="/user/joinProc", method=RequestMethod.POST)
	public String joinProc(User_table user, Model model) {
		
//		logger.info(user.toString()); // form 입력 값 잘 받아오는지 -완료-
		
		userService.joinProc(user);
		
		return "redirect:/main/main";
		
	}
	
	
	// id 중복체크
	@RequestMapping(value="/user/idCheck", method=RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("userid") String userid) {
		
		return userService.userIdCheck(userid);
		
	}
	
}
