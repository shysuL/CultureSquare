package prboard.controller;

import java.io.File;
import java.util.Iterator;
import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import prboard.dto.PRBoard;
import prboard.dto.PRType;
import prboard.dto.UpFile;
import prboard.service.face.PRBoardService;

@Controller
public class PRViewController {

	@Autowired private PRBoardService prBoardService;
	
	private static final Logger logger = LoggerFactory.getLogger(PRViewController.class);
	
	@RequestMapping(value="/prboard/view", method=RequestMethod.GET)
	public void viewPR(Model model, PRBoard prboard) {
		
		//게시글 세부정보 조회
		PRBoard viewBoard = prBoardService.getViewInfo(prboard.getBoardno());
		model.addAttribute("viewBoard", viewBoard);
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(viewBoard.getBoardno());
		
		model.addAttribute("fileList", list);
		
		logger.info("파일 테스트 : " + list);
		
	}
	
	@RequestMapping(value="/prboard/download")
	public ModelAndView download(int fileno, //파일번호 파라미터
			ModelAndView mav) {
		
		logger.info("파일번호 : " + fileno) ;
		
		//파일 번호에 해당하는 파일 정보 가져오기
		UpFile file = prBoardService.getFile(fileno);
		
		logger.info("조회된 파일 : " + file);
		
		//파일 정보를 MODEL 값으로 지정하기
		mav.addObject("downFile", file);
		
		//viewName 지정하기
		mav.setViewName("prdown");
		
		return mav;
	}
	
	@RequestMapping(value="/prboard/modify", method=RequestMethod.GET)
	public void modifyPR(Model model, PRBoard prboard) {
		
		//게시글 세부정보 조회
		PRBoard viewBoard = prBoardService.getViewInfo(prboard.getBoardno());
		model.addAttribute("viewBoard", viewBoard);
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(viewBoard.getBoardno());
		
		model.addAttribute("fileList", list);
		
		logger.info("수정 게시판 : " + viewBoard);
		logger.info("수정 테스트 : " + list);
		
	}
	
	@RequestMapping(value="/prboard/modifyProc", method=RequestMethod.POST)
	public String modifyPRProc(MultipartHttpServletRequest multi, PRBoard prBoard,	HttpSession session) {
		
		String originName="";
		int i = 1;
		boolean firsImage = true;
		
		logger.info("수정 : " + prBoard);
		
		// 1. 게시글 내용 수정
		prBoardService.modifyPR(prBoard);
		
		// 2. 대표 이미지 삭제
		prBoardService.deleteThumbnail(prBoard.getBoardno());
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(prBoard.getBoardno());
		
		logger.info("기존 파일 : " + list);

		//3. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!list.isEmpty()) {
			//서버에 있는 파일 삭제
			prBoardService.deleteServerFile(list);
			
			//DB 파일 삭제
			prBoardService.deleteFile(list);
		}
		
		
		//4. 새 파일 추가
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
				
				//.png 파일이거나 .jpg 파일인 경우
				if( "image".equals(mFile.getContentType().split("/")[0]) ) {
					
					//처음 이미지인 경우 이미지 파일에 업로드
					if(firsImage) {
						prBoardService.firstImageSave(mFile, prBoard.getBoardno());
						firsImage = false;
					}
				}
				logger.info(i + ". 실제 파일 이름 : " + originName);
				i++;
			}
		}
		return "redirect:/prboard/prlist";
	}
	
	@RequestMapping(value="/prboard/delete", method=RequestMethod.GET)
	public String deletePR(PRBoard prBoard,	HttpSession session) {
		
		
		logger.info("수정 : " + prBoard);
		
		// 1. 대표 이미지 삭제
		prBoardService.deleteThumbnail(prBoard.getBoardno());
		
		//게시글 첨부파일 조회
		List<UpFile> list = prBoardService.getFileList(prBoard.getBoardno());
		
		logger.info("기존 파일 : " + list);

		//2. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!list.isEmpty()) {
			//서버에 있는 파일 삭제
			prBoardService.deleteServerFile(list);
			
			//DB 파일 삭제
			prBoardService.deleteFile(list);
		}
		
		//3. PR 타입 삭제
		prBoardService.deletePRType(prBoard);
		
		//4. PR 게시글 삭제
		prBoardService.deletePR(prBoard);

		return "redirect:/prboard/prlist";
	}
}
	
	
