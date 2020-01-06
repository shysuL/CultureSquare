package user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.service.face.UserService;

@Controller
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	@Autowired private UserService userService;
	
	@RequestMapping(value="/user/findId", method=RequestMethod.POST)
	public ModelAndView getSearchId(@RequestParam("idFindByUsername") String userid,
			@RequestParam("idFindByUserphone") String userphone,
			ModelAndView mav) {
		
		logger.info("userid : " + userid);
		logger.info("userphone : " + userphone);
		
		mav.addObject("findId", userid);
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	
}
