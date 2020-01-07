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
public class MyIdDeleteController {
	
	@Autowired private MyPageService mypageService;
	
	private static final Logger logger = LoggerFactory.getLogger(MyIdDeleteController.class);
	
	@RequestMapping(value="/mypage/deleteuser", method=RequestMethod.GET)
	public void deleteuser(User_table user, HttpSession session, Model model) {
		
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
	}
	
	@RequestMapping(value="/mypage/deleteuser", method=RequestMethod.POST)
	public String deleteuser(HttpSession session, User_table user) {
		
		user.setUserid(session.getAttribute("userid").toString());
		user.setUserno((Integer)session.getAttribute("userno"));
//		user.setOriginname(session.getAttribute("originname").toString()); //사진 원본
//		user.setStoredname(session.getAttribute("storedname").toString()); //사진 저장본
		
		//새로운 userInfo객체 생성
		User_table userInfo = new User_table();
		
		//로그인한 사용자의 비밀번호 조회해서 userInfo객체에 담기
//		System.out.println(user);
		userInfo = mypageService.getFindUserPw(user); // DB에 있는 비밀번호
		System.out.println(userInfo);
		System.out.println("디비에 있는 암호화된 비밀번호 : " + userInfo.getUserpw());
		
		// 로그인시 입력한 비밀번호를 SHA256으로 암호화
//		System.out.println(user);
		String encPw = user.getUserpw();
		System.out.println("로그인 시 입력한 암호화된 비밀번호1 : " + user.getUserpw());
		user.setUserpw(PwSha256.userPwEncSHA256(encPw)); // 현재비밀번호를 암호화 한거
		System.out.println("로그인 시 입력한 암호화된 비밀번호2 : " + user.getUserpw());
		
		//boolean타입으로 true/false를 이용해서 현재 비밀번호와 사용자가 입력한 비밀번호가 맞는지 확인
		boolean password01 = mypageService.equalsPw(user);
		System.out.println("비밀번호 일치여부(true/false): " + password01);
		
		if(password01) {
			if( user.getStoredname() != null) {
				//사용자의 프로필 사진이 있으면 삭제
				
				mypageService.deleteUser(user);
				session.invalidate();
				
			} else {
				mypageService.deleteUser(user);
				session.invalidate();
			}
		}
		
		
		return "/redirect:/main/main";
		
	}

}
