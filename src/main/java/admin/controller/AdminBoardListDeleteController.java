package admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import admin.service.face.AdminService;
import artboard.dto.Board;
import artboard.service.face.PFBoardService;
import user.dto.User_table;

@Controller
public class AdminBoardListDeleteController {
	
	@Autowired private AdminService adminService;
	@Autowired private PFBoardService pfboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminBoardListDeleteController.class);
	
	@RequestMapping(value="/admin/user/delete", method=RequestMethod.GET)
	public void userdelete(HttpServletRequest req) {
		
		String[] strings = req.getParameterValues("checkRow");
		User_table userlist = new User_table();
		
		for(String string : strings) {
			userlist.setUserno(Integer.parseInt(string));
			adminService.userDelete(userlist);
		}
				
	}
	
	@RequestMapping(value="/admin/pfboard/delete", method=RequestMethod.GET)
	public void pfdelete(HttpServletRequest req) {
		
		String[] strings = req.getParameterValues("checkRow");
		Board checkboard = new Board();
//		Board board = pfboardService.getParam(req);
		
		System.out.println(strings);
		
		if(strings != null) {
			for(String string : strings) {
				checkboard.setBoardno(Integer.parseInt(string));
				pfboardService.deletePF(checkboard);
//				pfboardService.deleteFile(checkboard.getBoardno());
			}
		
		} else {
//			pfboardService.deletePF(board);
		}
		
		
		
	}

}
