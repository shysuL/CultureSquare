package mypage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import mypage.dto.Interest;
import mypage.service.face.MyPageService;
import user.dto.User_table;

@Controller
public class MyInfoModifyController {
	
	@Autowired MyPageService mypageService;
	@Autowired HttpSession session;
	private static final Logger logger = LoggerFactory.getLogger(MyInfoModifyController.class);
	
	@RequestMapping(value="/mypage/updateform", method=RequestMethod.GET)
	public void updateform(User_table user, Model model) {
		
		user.setUserno((Integer) session.getAttribute("userno"));
		
		User_table getUser = mypageService.getUserInfo(user);
		
//--------------------------------------------------------------------	
		//체크박스로 선택한 사용자의 interest 관심분야 
		
		//--------------------------------------------------------------------   
	      
	      List<Interest> list = new ArrayList<Interest>();
	      
	      Interest temp = new Interest();
	      temp.setInterest("버스킹");
	      list.add(temp);
	      temp = new Interest();
	      temp.setInterest("공연/예술");
	      list.add(temp);
	      temp = new Interest();
	      temp.setInterest("기타");
	      list.add(temp);
	      
	      String[] array = getUser.getInterest().split(",");
	      
	      for (int i = 0; i < list.size(); i++) {
	         for (int j = 0; j < array.length; j++) {
	            if (list.get(i).getInterest().equals(array[j])) {
	               list.get(i).setCheck(true);
	            }
	         }
	      }
	      
	      model.addAttribute("list", list);
	      
	     //--------------------------------------------------------------------   
		
		model.addAttribute("getUser", getUser);
		
		logger.info("2 : " + getUser.toString());

		logger.info("사용자 번호 : " + session.getAttribute("userno").toString());

	}
	
	//사용자 개인정보 수정
	@RequestMapping(value="/mypage/updateform", method=RequestMethod.POST)
	public String modifyUserInfo(User_table user) {
		
		logger.info(session.getAttribute("userno").toString());
		
		User_table userinfo = mypageService.getUserInfo(user);
		
		logger.info("사용자 현재 개인정보 : " + userinfo);
		
		//세션에 저장되어있는 사용자의 닉네임 불러오기
		String userNname = userinfo.getUsernick();
		
		//변경할 닉네임과 핸드폰 번호
		Object nick = user.getUsernick();
		Object phone = user.getUserphone();
		
		logger.info("닉네임 : " + userNname);
		logger.info("닉네임1 : " + nick);
		logger.info("핸드폰 : " + phone);

		mypageService.modifyUserInfo(user);
		
		return "redirect:/main/main";
	}
	
	// 닉네임 중복체크
	@RequestMapping(value="/mypage/usernickCheck", method=RequestMethod.POST)
	public ModelAndView nickCheck(@RequestParam("usernick") String usernick, ModelAndView mav) {
		
		mav.addObject("nickCheck", mypageService.userNickCheck(usernick));
		mav.setViewName("jsonView");
		
		logger.info("nickCheck(0-사용가능, 1-중복nick) : " + mav.toString());
		
		return mav;
		
	}


}
