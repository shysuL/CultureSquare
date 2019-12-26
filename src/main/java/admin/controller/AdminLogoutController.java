package admin.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminLogoutController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminLogoutController.class);
	
	@RequestMapping(value="/admin/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		
		session.invalidate();

		logger.info("로그아웃 성공");
		
		return "redirect:/admin/login";
	}

}
