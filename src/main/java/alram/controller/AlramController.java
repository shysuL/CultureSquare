package alram.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.dto.User_table;

@Controller
public class AlramController {
	@RequestMapping(value="/alram/alarmcnt")
	public ModelAndView alarmcnt(ModelAndView mav, User_table user) {
		
		System.out.println("알림 유저 테스트 : " + user);
		
		mav.addObject("hi", "hi");
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
}
