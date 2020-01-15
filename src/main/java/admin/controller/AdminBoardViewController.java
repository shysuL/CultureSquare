package admin.controller;

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

import admin.service.face.AdminService;
import artboard.dto.Board;
import artboard.dto.PFUpFile;
import artboard.dto.Reply;
import artboard.service.face.PFBoardService;
import board.dto.FreeBoard;
import board.service.face.FreeBoardService;
import board.service.face.NoticeBoardService;
import prboard.dto.PRBoard;
import prboard.dto.UpFile;
import prboard.service.face.PRBoardService;
import user.dto.User_table;

@Controller
public class AdminBoardViewController {
	
	@Autowired private PFBoardService pfboardService;
	@Autowired private PRBoardService prBoardService;
	@Autowired private FreeBoardService freeboardService;
	@Autowired private AdminService adminService;
	@Autowired private NoticeBoardService noticeboardService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminBoardViewController.class);
	
	//PF 게시판
	@RequestMapping(value="/admin/board/view/pfview", method=RequestMethod.GET)
	public void pfview(Board bno, Model model) {
		
		Board viewPF = pfboardService.view(bno);
		model.addAttribute("viewpf", viewPF);
		
		List<PFUpFile> fileList = pfboardService.getFileList(viewPF.getBoardno());
		
		model.addAttribute("fileList", fileList);
		System.out.println("PF파일" + fileList);
		
		Board userno = new Board();
		userno.setUserno(viewPF.getUserno());
		
		Board writer = pfboardService.getWriter(userno);
		model.addAttribute("writer", writer);
		
		Reply reply = new Reply();
		List<Reply> replyList = pfboardService.getReplyList(bno);
		model.addAttribute("replyList", replyList);
	}
	
	@RequestMapping(value="/admin/board/view/pfview/delete", method=RequestMethod.GET)
	public String deletepf(Board board) {
		
		// 1. 대표 이미지 삭제
		pfboardService.deleteThumbnail(board.getBoardno());
		
		//게시글 첨부파일 조회
		List<PFUpFile> list = pfboardService.getFileList(board.getBoardno());
		
//		logger.info("PF 기존 파일 : " + list);

		//2. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!list.isEmpty()) {
			//서버에 있는 파일 삭제
			pfboardService.deleteServerFile(list);

			//DB 파일 삭제
			pfboardService.deleteFile(list);
		}
		
		// 게시글 삭제( 삭제된 게시글로 UPDATE ) 
		pfboardService.deletePF(board);
		
		return "redirect:/admin/main";
		
	}
	
	//PR게시판
	@RequestMapping(value="/admin/board/view/prview", method=RequestMethod.GET)
	public void prview(PRBoard prboard, Model model) {
		
		PRBoard viewPR = prBoardService.getViewInfo(prboard.getBoardno());
		model.addAttribute("viewpr", viewPR);
		
		List<UpFile> fileList = prBoardService.getFileList(viewPR.getBoardno());
		model.addAttribute("fileList", fileList);
		
		prboard.dto.Reply reply = new prboard.dto.Reply();
		List<prboard.dto.Reply> replyList = prBoardService.getReplyByboardNo(reply);
		model.addAttribute("replyList", replyList);
		
//		System.out.println("pr" + viewPR);
//		System.out.println("pr" + fileList);
//		System.out.println("pr" + replyList);
	}
	
	@RequestMapping(value="/admin/board/view/prview/delete", method=RequestMethod.GET)
	public String deletepr(PRBoard prboard, prboard.dto.Reply prReply) {
		
		// 1. 대표 이미지 삭제
		prBoardService.deleteThumbnail(prboard.getBoardno());
		//게시글 첨부파일 조회
		List<UpFile> fileList = prBoardService.getFileList(prboard.getBoardno());
		
		//2. 파일 삭제(기존 파일 삭제) 첨부파일이 있을때만 삭제
		if(!fileList.isEmpty()) {
			//서버에 있는 파일 삭제
			prBoardService.deleteServerFile(fileList);
			//DB 파일 삭제
			prBoardService.deleteFile(fileList);
		}
		//3. PR 타입 삭제
		prBoardService.deletePRType(prboard);
		//4.  게시글 좋아요 삭제
		prBoardService.deleteBlike(prboard);
		
		//5. 댓글 좋아요 삭제
		//5-1 보드번호를 통한 댓글 리스트들의 댓글 번호 구해 삭제하기 
		prReply.setBoardno(prboard.getBoardno());
		List<prboard.dto.Reply> replyVO = prBoardService.getReplyByboardNo(prReply);
        
//        logger.info("답 테스트 : "  + replyVO);
        
        if(replyVO.size() > 0){
            for(int i=0; i<replyVO.size(); i++){
            	//5-2댓글 좋아요 데이터 삭제
            	prBoardService.deleteReLike(replyVO.get(i).getReplyno());
            }
        }
      //6. 댓글 대댓글 삭제
		prBoardService.deleteReplyToBoard(prboard);
		//7. PR 게시글 삭제
		prBoardService.deletePR(prboard);
		
		return "redirect:/admin/main";
	}
	
	//자유게시판
	@RequestMapping(value="/admin/board/view/freeview", method=RequestMethod.GET)
	public void freeview(Model model, @RequestParam("boardno") int boardno, board.dto.UpFile fileList) {
		
		freeboardService.increaseViews(boardno);
		
		FreeBoard viewFree = freeboardService.freeDetail(boardno);
		fileList = freeboardService.getFile(boardno);
	
		model.addAttribute("viewfree", viewFree);
		model.addAttribute("fileList", fileList);
		
		//댓글 리스트 전달
		board.dto.Reply reply = new board.dto.Reply();
		List<board.dto.Reply> replyList = freeboardService.getReplyList(boardno);
		model.addAttribute("replyList", replyList);
		
//		System.out.println(boardno);
	}
	
	@RequestMapping(value="/admin/board/view/freeview/delete", method=RequestMethod.GET)
	public String deletefree(@RequestParam("boardno") int boardno, HttpSession session, board.dto.UpFile file, board.dto.Reply reply) {
		
		board.dto.UpFile fileInfo = freeboardService.getFile(boardno);
		
		if (file.getFileno() != 0) {
			freeboardService.fileDelete(fileInfo);
		}
		
		freeboardService.deleteBlike(boardno);
		
		reply.setBoardno(boardno);
		List<board.dto.Reply> replyVO = freeboardService.getReplyByboardNo(reply);
		
		if(replyVO.size() > 0) {
			for(int i=0; i<replyVO.size(); i++){
				//5-2댓글 좋아요 데이터 삭제
				freeboardService.deleteReLike(replyVO.get(i).getReplyno());
			}
		}
		//6. 댓글 대댓글 삭제
		freeboardService.deleteReplyToBoard(boardno);
		freeboardService.freeDelete(boardno);

		return "redirect:/admin/main";
	}
	
	@RequestMapping(value="/admin/board/view/noticeview", method=RequestMethod.GET)
	public void noticeview(Model model, Board board, @RequestParam("boardno") int boardno) {
		
		Board notice = adminService.getView(board);
		
		model.addAttribute("notice", notice);
		
		board.dto.UpFile fileinfo = noticeboardService.getFile(boardno);
		
		model.addAttribute("fileinfo", fileinfo);
		
	}
	
	@RequestMapping(value="/admin/board/view/noticeview/delete", method=RequestMethod.GET)
	public String deletenotice(@RequestParam("boardno") int boardno, board.dto.UpFile file) {
		
		board.dto.UpFile fileinfo = noticeboardService.getFile(boardno);
		
		if(file.getFileno() != 0) {
			noticeboardService.fileDelete(fileinfo);
			
		}
		
		noticeboardService.noticeDelete(boardno);
		
		return "redirect:/admin/main";
	}
	
	@RequestMapping(value="/admin/noticeboard/download")
	public ModelAndView noticeDownload(int fileno, ModelAndView mav) {
		
		board.dto.UpFile file = noticeboardService.getFileNo(fileno);
		
		logger.info("공지사항 파일번호" + fileno);
		logger.info("공지사항 다운로드 되라" + file);
		
		mav.addObject("downFile", file);
		mav.setViewName("noticedown");
		
		return mav;
	}
	
	@RequestMapping(value="/admin/board/view/userview", method=RequestMethod.GET)
	public void userview(Model model, User_table user) {
		
		
		User_table userinfo = adminService.getUserInfo(user);
		
		model.addAttribute("userinfo", userinfo);
		
		logger.info("userinfo" + userinfo);
	}
	
	@RequestMapping(value="/admin/board/view/userview/delete", method=RequestMethod.GET)
	public String userdelete() {
		
		return "redirect:/admin/main";
	}
	
	@RequestMapping(value="/admin/user/mgrpermit", method=RequestMethod.POST)
	public String mgrpermit(HttpSession session, User_table user) {
		
		logger.info("되냐!?");
		
//		user.setUserno((Integer)session.getAttribute("userno"));
		user.setUserno(user.getUserno());
		
		adminService.updatepermit(user);
		
		return "redirect:/admin/main";
		
	}
	
	@RequestMapping(value="/admin/user/downPermit", method=RequestMethod.POST)
	public String downpermit(HttpSession session, User_table user) {
		logger.info("다운되냐1");
		
		user.setUserno((Integer)session.getAttribute("userno"));
		
		adminService.downpermit(user);
		
		logger.info("다운되냐2");
		
		return "redirect:/admin/main";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
