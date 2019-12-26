package mypage.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import user.dto.User_table;
import util.Paging;

@Controller
public class MyHistoryController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyHistoryController.class);
	
	@RequestMapping(value="/mypage/likepost", method=RequestMethod.GET)
	public void getLikePost(Paging paging, User_table user) {
		
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
