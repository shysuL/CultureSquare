package alram.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import alram.dto.Alram;
import alram.service.face.AlramService;
import user.dto.User_table;

@Controller
public class AlramController {
	
	@Autowired private AlramService alramService;
	
	@RequestMapping(value="/alram/alarmcnt")
	public ModelAndView alarmcnt(ModelAndView mav, User_table user) {
		
		//1. 사용자 번호 구하기
		user.setUserno(alramService.getUserNoByUserNick(user.getUsernick()));
		
		//2. 알람 갯수 구하기
		int alramCnt = alramService.getAlramCnt(user.getUserno());
		
		mav.addObject("alramCnt", alramCnt);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/alram/readalram")
	public ModelAndView readalram(ModelAndView mav, User_table user) {
		
		//1. 사용자 번호 구하기
		user.setUserno(alramService.getUserNoByUserNick(user.getUsernick()));
		
		//2. 알림 읽음 표시 1로 업데이트
		alramService.readAlram(user.getUserno());
		
		mav.addObject("update", true);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
}
