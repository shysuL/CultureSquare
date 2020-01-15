 package mypage.controller;

import java.util.Iterator;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mypage.dao.face.MyPageDao;
import mypage.service.face.MyPageService;
import user.dto.User_table;
import util.PwSha256;

@Controller
public class MypageMainController {
	
	@Autowired private MyPageService mypageService;
	@Autowired MyPageDao mypageDao;
	
	private static final Logger logger = LoggerFactory.getLogger(MypageMainController.class);
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.GET)
	public void mypage(HttpSession session, User_table user, Model model) {
		
		if(session.getAttribute("userid") != null) {
			user.setUserid(session.getAttribute("userid").toString());
		}
		
		user.setUsernick(session.getAttribute("usernick").toString());
		
		if(session.getAttribute("userno") != null) {
			user.setUserno((Integer)session.getAttribute("userno"));
			
		}
		
		User_table getUser = mypageService.getUserInfo(user);
		User_table userInfo = new User_table();
		
		userInfo = mypageService.getFindUserPw(user);

		model.addAttribute("getUser", getUser);
		model.addAttribute("userinfo", userInfo);
	}
	
	@RequestMapping(value="/mypage/main", method=RequestMethod.POST)
	public String mypage(User_table user, Model model, HttpSession session, String changepw) {
		
		//세션에서 로그인한 사용자의 userno와 userid, usernick 가져와서 user객체에 담기
		user.setUserid(session.getAttribute("userid").toString());
		user.setUserno((Integer)session.getAttribute("userno"));
		user.setUsernick(session.getAttribute("usernick").toString());

		//새로운 userInfo객체 생성
		User_table userInfo = new User_table();
		
		//로그인한 사용자의 비밀번호 조회해서 userInfo객체에 담기
		userInfo = mypageService.getFindUserPw(user); // DB에 있는 비밀번호
		
		// 로그인시 입력한 비밀번호를 SHA256으로 암호화
		String encPw = user.getUserpw();
		user.setUserpw(PwSha256.userPwEncSHA256(encPw)); // 현재비밀번호를 암호화 한거
		
		//boolean타입으로 true/false를 이용해서 현재 비밀번호와 사용자가 입력한 비밀번호가 맞는지 확인
		boolean password01 = mypageService.equalsPw(user);
		
		if(password01) { //일치여부가 true이면
			String encPw2 = changepw;
			user.setUserpw(PwSha256.userPwEncSHA256(encPw2));

			mypageService.modifyUserPassword(user);
			
			return "/redirect:/main/main";
			
		} else {
			return "/redirect:/mypage/main";
		}		
	}
	
	@RequestMapping(value="/mypage/changePw", method=RequestMethod.POST)
	public ModelAndView changePw(ModelAndView mav, HttpSession session, String changepw) {
		
		User_table user = new User_table();
		
		//세션에서 로그인한 사용자의 userno와 userid, usernick 가져와서 user객체에 담기
		user.setUserid(session.getAttribute("userid").toString());
		user.setUserno((Integer)session.getAttribute("userno"));
		user.setUsernick(session.getAttribute("usernick").toString());
		
		user.setUserpw(PwSha256.userPwEncSHA256(changepw)); // 현재비밀번호를 암호화 한거

		mypageService.modifyUserPassword(user);
		
		//viewName지정하기
		mav.setViewName("jsonView");
		 
		return mav;
	}
	
	@RequestMapping(value="/mypage/curpwCheck", method=RequestMethod.POST)
	public ModelAndView currentPwCheck(ModelAndView mav, HttpSession session, User_table user) {
		
		//세션에서 로그인한 사용자의 userno와 userid, usernick 가져와서 user객체에 담기
		user.setUserno((Integer)session.getAttribute("userno"));
		
		//암호화
		String encPw = user.getUserpw();
		user.setUserpw(PwSha256.userPwEncSHA256(encPw)); // 현재비밀번호를 암호화 한거
		
		boolean lock = mypageService.comparedPw(user);
		
		mav.addObject("lock", lock);
		//viewName지정하기
		mav.setViewName("jsonView");
		 
		return mav;
	}
	
	@RequestMapping(value="/mypage/main/profile", method=RequestMethod.POST)
	public ModelAndView UserPhoto(ModelAndView mav, MultipartHttpServletRequest multi, User_table user, HttpSession session) {
		
		user.setUserno((Integer)session.getAttribute("userno"));

		// 프로필 사진 변수
		String originName = "";
		String StoredName = "";
		boolean firstImage = true;
		int i = 1;
		Iterator<String> files = multi.getFileNames();
		
		//프로필 사진 변경
		while(files.hasNext()) {
			String uploadFile = files.next();
			MultipartFile mFile = multi.getFile(uploadFile);
			originName = mFile.getOriginalFilename();
			StoredName = mFile.getName();
			
			if(originName == null || originName.equals("") || StoredName == null || StoredName.equals("")) {
				logger.info("빈파일");
			
			} else {
				User_table StoredPhoto = mypageService.fileSave(mFile, user.getUserno());
				
				logger.info("저장이름" + StoredPhoto.getStoredname());
				
				StoredName = StoredPhoto.getStoredname();
				
				mav.addObject("StoredName", StoredName);

				if( "image".equals(mFile.getContentType().split("/")[0]) ) {
					if(firstImage) {
						mypageService.firstImageSave(mFile, user.getUserno());
						firstImage = false;
					}
				}
				
				logger.info(i + " 실제파일이름 : " + originName);
				i++;
			}
			
		}
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/mypage/main/photodelete", method=RequestMethod.POST)
	public ModelAndView UserPhotoDelete(HttpSession session, User_table user, ModelAndView mav) {
		
		user.setUserno((Integer)session.getAttribute("userno"));
		
		mypageService.fileDelete(user);
		
		session.removeAttribute("storedname");
		
		mav.addObject("user", user);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/mypage/main/updateartist", method=RequestMethod.POST)
	public String UpdateArtists(HttpSession session, User_table user) {
		
		logger.info("외않되?");
		
		user.setUserno((Integer)session.getAttribute("userno"));
		
		mypageService.userupdate(user);
		
		logger.info("외않되?");
		
		return "redirect:/mypage/main";
	}
}
