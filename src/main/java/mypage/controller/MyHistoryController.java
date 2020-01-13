package mypage.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;

import mypage.service.face.MyPageService;
import user.dto.User_table;
import util.MyPaging;

@Controller
public class MyHistoryController {
	
	@Autowired private MyPageService mypageService;
	
	private static final Logger logger = LoggerFactory.getLogger(MyHistoryController.class);
	
	//사용자가 좋아요한 글
	@RequestMapping(value="/mypage/likepost", method=RequestMethod.GET)
	public void getLikePost(HttpServletRequest req, MyPaging paging, HttpSession session, Model model) {
		
		//세션에서 userno 꺼내기
		paging.setUserno((Integer)session.getAttribute("userno"));
		
		MyPaging result = mypageService.getLikePaging(paging);
		
		List<HashMap<String, Object>> likelist = new ArrayList<HashMap<String, Object>>();
		
		System.out.println("좋아요한 글" + result);

		likelist = mypageService.getLikeList(result);
		
		model.addAttribute("url", req.getRequestURI());
		model.addAttribute("paging", result);
		model.addAttribute("likelist", likelist);
	}

//	@RequestMapping(value="/mypage/likeartists", method=RequestMethod.GET)
//	public void getLikeArtists(Paging paging, User_table user) {
//		
//	}

	//사용자가 작성한 글
	@RequestMapping(value="/mypage/writelist", method=RequestMethod.GET)
	public void getUserPostList(HttpServletRequest req, MyPaging paging, HttpSession session, Model model) {
		
		paging.setUserno((Integer)session.getAttribute("userno"));
		
		MyPaging result = mypageService.getPaging(paging);
		
		List<HashMap<String, Object>> writelist = new ArrayList<HashMap<String, Object>>();
		
		System.out.println("작성한 글" + result);
		
		writelist = mypageService.getWriteList(result);
		
		model.addAttribute("url", req.getRequestURI());
		model.addAttribute("paging", result);
		model.addAttribute("writelist", writelist);
		
	}
	
	//사용자가 작성한 댓글
	@RequestMapping(value="/mypage/replylist", method=RequestMethod.GET)
	public void getUserReplyList(HttpServletRequest req, MyPaging paging, HttpSession session, Model model) {
		
		paging.setUserno((Integer)session.getAttribute("userno"));
		
		MyPaging result = mypageService.getPaging(paging);
		
		List<HashMap<String, Object>> replylist = new ArrayList<HashMap<String, Object>>();
		
		replylist = mypageService.getReplyList(result);
		
		model.addAttribute("url", req.getRequestURI());
		model.addAttribute("paging", result);
		model.addAttribute("replylist", replylist);
		
	}
	
//	@RequestMapping(value="/mypage/permitslist", method=RequestMethod.GET)
//	public void getUserPermit(Paging paging, User_table user) {
//		
//	}
			

}
