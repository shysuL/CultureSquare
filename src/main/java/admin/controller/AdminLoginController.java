package admin.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import admin.dto.Admin;
import admin.service.face.AdminService;

@Controller
public class AdminLoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminLoginController.class);

	@Autowired private AdminService adminService;
	
	@RequestMapping(value="/admin/login", method=RequestMethod.GET)
	public void login() {
		//로그인 폼만 띄어주는 메소드
	}
	
	@RequestMapping(value="/admin/login", method=RequestMethod.POST)
	public ModelAndView loginProc(Admin admin, HttpSession session, Model model, ModelAndView mav) {
		
		logger.info("관리자 페이지 로그인");
		logger.info(admin.toString());
		
		boolean adminIsLogin = adminService.login(admin);
		
		if(adminIsLogin) {
			session.setAttribute("adminLogin", adminIsLogin);
			session.setAttribute("adminid", admin.getAdminid());
			
		}
		
		
//		logger.info("로그인상태  : " + adminIsLogin);
		
		mav.addObject("adminIsLogin", adminIsLogin);
//		model.addAttribute("login", adminIsLogin);
		
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public void main() {
		//로그인 성공 폼 띄어주는 메소드
	}

} 
