package prboard.controller;

import java.util.Iterator;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import prboard.dto.PRBoard;
import prboard.dto.PRType;
import prboard.service.face.PRBoardService;

@Controller
public class PRWriteController {
	
	private static final Logger logger = LoggerFactory.getLogger(PRWriteController.class);
	@Autowired private PRBoardService prBoardService;
	
	@RequestMapping(value="/prboard/write", method=RequestMethod.GET)
	public void writePR() {}
	
	@RequestMapping(value="/prboard/checkWriteDate", method=RequestMethod.POST)
	public ModelAndView checkWriteDate(HttpSession session, ModelAndView mav) {
		//사용자 번호 구하기
		int userNo = prBoardService.getUserNoByUserNick((String)session.getAttribute("usernick"));
		
		// 사용자의 최근 PR 게시글 작성 시간 구하기
		String writeDate = prBoardService.getWriteDate(userNo);
		
		//작성한적이 없다면
		if(writeDate.equals("0")) {
			mav.addObject("time", true);
			//viewName지정하기
			mav.setViewName("jsonView");
		}
		
		else {
			System.out.println("이게 되면 안됨");

			//하루가 지났는지 비교, (지금은 테스트로 1분 지났는지 비교 할거임)
			int time = prBoardService.getTimePass(writeDate);


			//1분 지났으면
			if(time > 0)
				mav.addObject("time", true);
			else
				mav.addObject("time", false);

			//viewName지정하기
			mav.setViewName("jsonView");
		}
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/prboard/writeProc", method=RequestMethod.POST)
	public String writePR(MultipartHttpServletRequest multi, PRBoard prBoard, PRType prType,HttpSession session) {
		
		String originName="";
		int i = 1;
		
		logger.info("타이틀 ? : " + prBoard.getTitle());
		logger.info("내용 ? : " + prBoard.getContent());
		logger.info("PR 유형 : " + prType.getPrname());
		
		//사용자 번호 구하기
		int userNo = prBoardService.getUserNoByUserNick((String)session.getAttribute("usernick"));
		prBoard.setUserno(userNo);
		
		//1. 게시글 내용 삽입
		prBoardService.writePR(prBoard);
		logger.info("pr보드 테스트 : " + prBoard);
		
		//2. prwritedate 최근시간으로 업데이트
		prBoardService.updatePrWriteDate(userNo);
		
		//3. PR 유형 테이블 삽입
		prType.setBoardno(prBoard.getBoardno());
		logger.info("prType 테스트 : " + prType);
		prBoardService.insertPRType(prType);
		
		//4. 파일 삽입
		
		Iterator<String> files = multi.getFileNames();
		
		while(files.hasNext()) {
			String uploadFile = files.next();
			MultipartFile mFile = multi.getFile(uploadFile);
			originName = mFile.getOriginalFilename();
			//빈파일 처리
			if(originName == null || originName .equals("")) {
				logger.info("빈파일 있음");
			}
			else {
				prBoardService.fileSave(mFile, prBoard.getBoardno());
				logger.info(i + ". 실제 파일 이름 : " + originName);
				i++;
			}
		}
		
		return "redirect:/prboard/prlist";
	}
}
