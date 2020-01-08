package user.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.dto.User_table;
import user.service.face.UserService;

@Controller
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	@Autowired private UserService userService;
	
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
	
	
}
