package user.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.dto.User_table;
import user.service.face.UserSendMailService;
import user.service.face.UserService;

@Controller
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	@Autowired private UserService userService;
	@Autowired private UserSendMailService userSendMailService;
	
	@RequestMapping(value="/user/findId", method=RequestMethod.POST)
	public ModelAndView getSearchId(User_table user,
			ModelAndView mav) {
		
		logger.info("username : " + user.getUsername());
		logger.info("userphone : " + user.getUserphone());
		
		List<User_table> list = userService.getUseridByNamePhone(user);
		
//		List<String> idList = new ArrayList<>();
//		
//		for(int i =0; i< list.size(); i++) {
//			idList.add(list.get(i).getUserid());
//		}
		
		logger.info(list.toString());
		
		mav.addObject("idList", list);
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/user/findPw", method=RequestMethod.POST)
	public ModelAndView getFindPw(@RequestParam("userid")String userid, @RequestParam("username")String username,
			HttpServletRequest req, ModelAndView mav) {
		
		
		int result = userService.userIdNameCheck(userid, username);
		
		logger.info("조회결과 : " + result);
		
		if (result == 1) { // 입력한 아이디, 이름으로 검색한 사용자가 있다면
			userSendMailService.mailSendWithPassword(userid, username, req);	
		} 
		
		mav.addObject("result", result);
		mav.setViewName("jsonView");
		
		return mav;
		
	}	
}
