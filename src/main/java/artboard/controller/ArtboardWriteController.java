package artboard.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import artboard.dto.Board;
import artboard.service.face.PFBoardService;

@Controller
public class ArtboardWriteController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardWriteController.class);
	@Autowired PFBoardService pfboardService;
	@Autowired HttpSession session;
	

	@RequestMapping(value = "/artboard/write", method=RequestMethod.GET)
	public void write(Board board, Model model) {
		
//		logger.info(session.getAttribute("userno").toString());
		
		// 세션에 저장된 userno를 모델로 전달
		board.setUserno((Integer)session.getAttribute("userno"));
		model.addAttribute("userno",board);
		
		
		
	}

	@RequestMapping(value = "/artboard/write", method=RequestMethod.POST)
	public String writeProc(MultipartHttpServletRequest multi, Board board) {
		
		// 작성 수행
		pfboardService.write(board);
		
		// 리다이렉트 시 게시판 리스트 쿼리스트링 날짜 계산
		// -------------------------------------------------------
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy");
		SimpleDateFormat format2 = new SimpleDateFormat ( "MM");
				
		Date time = new Date();
				
		String nowYear = format1.format(time);
		String nowMonth = format2.format(time);
		// -------------------------------------------------------
		
		//파일 업로드
		//-----------------------------------------------------------
		
		String originName="";
		int i = 1;
		
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
				pfboardService.fileSave(mFile, board.getBoardno());
				
				//.png 파일이거나 .jpg 파일인 경우
				if( "image".equals(mFile.getContentType().split("/")[0]) ) {
					
					
				}
				logger.info(i + ". 실제 파일 이름 : " + originName);
				i++;
			}
		}		
		        
		return "redirect:/artboard/list?bo_table=calendar&cal_year="+nowYear+"&cal_month="+nowMonth;
	}
	
	
	
}
