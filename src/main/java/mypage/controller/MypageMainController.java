package mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MypageMainController {
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.GET)
	public void mypage() {
		//마이페이지 폼 띄어주는 메소드
	}

}
