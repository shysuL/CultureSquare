package admin.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String loginProc(Admin admin, HttpSession session) {
		
		logger.info("관리자 페이지 로그인");
		logger.info(admin.toString());
		
		boolean adminIsLogin = adminService.login(admin);
		
		if(adminIsLogin) {
			session.setAttribute("adminLogin", adminIsLogin);
			session.setAttribute("adminid", admin.getAdminid());
		}
		
		return "redirect:/admin/main";
		
	}
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public void main() {
		//로그인 성공 폼 띄어주는 메소드
	}

} 
