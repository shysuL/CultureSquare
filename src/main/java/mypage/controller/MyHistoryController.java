package mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import mypage.service.face.MyPageService;
import user.dto.User_table;
import util.Paging;

@Controller
public class MyHistoryController {
	
	@Autowired private MyPageService mypageService;
	
	private static final Logger logger = LoggerFactory.getLogger(MyHistoryController.class);
	
	@RequestMapping(value="/mypage/likepost", method=RequestMethod.GET)
	public void getLikePost(Paging paging, User_table user, HttpSession session, Model model,
							HttpServletRequest req) {
		
		//세션에서 userno 꺼내기
		user.setUserno((Integer)session.getAttribute("userno"));
//		System.out.println(user);
		
		Paging pfpaging = mypageService.getPaging(req, 1); //pr게시판은 1
		Paging prpaging = mypageService.getPaging(req, 2); //공연정보게시판은 2
		Paging freepaging = mypageService.getPaging(req, 3); //자유게시판은 3
		
		model.addAttribute("pfpaging", pfpaging);
		model.addAttribute("prpaging", prpaging);
		model.addAttribute("freepaging", freepaging);
		
		Map<Integer, List> map = new HashMap<Integer, List>();
		
		for(int i = 1; i<=3; i++) {
			
			if(i == 1) {
				map.put(i, mypageService.getLikeList(pfpaging, user, i));
				
			} else if (i == 2) {
				map.put(i, mypageService.getLikeList(prpaging, user, i));
				
			} else if (i == 3) {
				map.put(i, mypageService.getLikeList(freepaging, user, i));
				
			}
			
		}
		
		model.addAttribute("pflist", map.get(1));
		model.addAttribute("prlist", map.get(2));
		model.addAttribute("freelist", map.get(3));
		
	}

	@RequestMapping(value="/mypage/likeartists", method=RequestMethod.GET)
	public void getLikeArtists(Paging paging, User_table user) {
		
	}
	
	@RequestMapping(value="/mypage/writelist", method=RequestMethod.GET)
	public void getUserPostList(Paging paging, User_table user) {
		
	}
	
	@RequestMapping(value="/mypage/writereplylist", method=RequestMethod.GET)
	public void getUserReplyList(Paging paging, User_table user) {
		
	}
	
	@RequestMapping(value="/mypage/permitslist", method=RequestMethod.GET)
	public void getUserPermit(Paging paging, User_table user) {
		
	}
			

}
