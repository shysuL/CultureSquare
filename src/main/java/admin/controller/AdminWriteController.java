package admin.controller;

import java.util.Iterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import board.dto.FreeBoard;
import board.service.face.NoticeBoardService;

@Controller
public class AdminWriteController {

	@Autowired private NoticeBoardService noticeboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminWriteController.class);
	
	@RequestMapping(value="/admin/board/noticewrite", method=RequestMethod.GET)
	public void noticeWrite() {
		
		System.out.println("공지사항 작성 나와라");
		
	}

	@RequestMapping(value="/admin/board/noticewrite", method=RequestMethod.POST)
	public String noticeWrite(Model model, FreeBoard noticeboard, MultipartHttpServletRequest multi) {
		
		String originName = "";
		int i = 1;
		boolean firstImage = true;
		
		noticeboardService.writeNotice(noticeboard);
		
		System.out.println(noticeboard.getBoardno());
		
		Iterator<String> files = multi.getFileNames();
		
		while(files.hasNext()) {
			String uploadFile = files.next();
			MultipartFile mFile = multi.getFile(uploadFile);
			originName = mFile.getOriginalFilename();
			
			if(originName == null || originName.equals("")) {
				logger.info("빈파일있응");
			
			} else {
				noticeboardService.fileSave(mFile, noticeboard.getBoardno());
				
				if( "image".equals(mFile.getContentType().split("/")[0]) ) {
					if(firstImage) {
						noticeboardService.firstImageSave(mFile, noticeboard.getBoardno());
						firstImage = false;
					}
				}
				
				logger.info(i + " . 실제파일이름" + originName);
				i++;
			}
		}
		
		return "redirect:/admin/main";
	}
}
