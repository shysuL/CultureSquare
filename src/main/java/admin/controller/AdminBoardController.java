package admin.controller;

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

import board.dto.FreeBoard;
import board.service.face.FreeBoardService;
import prboard.service.face.PRBoardService;
import util.PRPaging;
import util.Paging;

@Controller
public class AdminBoardController {
	
	@Autowired private FreeBoardService freeboardService;
	@Autowired private PRBoardService prBoardService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminBoardController.class);
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public String board(Model model, @RequestParam(defaultValue="1") int curPage, String searchtarget, 
							String searchcategory, HttpServletRequest req, HttpSession session,
							String searchType, String search, PRPaging prpaging) {
		
		System.out.println(session.getAttribute("adminLogin"));
		
		if( session.getAttribute("adminLogin") == null ) {
			
			return "redirect:/admin/login"; 
			
		} else {
			
			//자유게시판
			Map<String, String> map = new HashMap<String, String>();
			
			map.put("searchcategory", searchcategory);
			map.put("searchtarget", searchtarget);
			
			Paging fbpaging = new Paging(freeboardService.getListCnt(map), curPage);
			
			fbpaging.setSearchcategory(searchcategory);
			fbpaging.setSearchtarget(searchtarget);

			model.addAttribute("fbpaging", fbpaging);
			model.addAttribute("url", req.getRequestURI());
			
			List<FreeBoard> fblist = freeboardService.getList(fbpaging);
			
			model.addAttribute("fblist", fblist);
			
			List<FreeBoard> viewList = freeboardService.getViewsList();
//			logger.info(viewList.toString());
			
			model.addAttribute("viewList", viewList);
//--------------------------------------------------------------------------------------------
			
			//pr게시판
			Map<String, String> prmap = new HashMap<String, String>();
			
			if(searchType!=null && !"".equals(searchType)) {
				prmap.put("searchType", searchType);
			}
			
			if(search!=null && !"".equals(search)) {
				prmap.put("search", search);
			}
			
			int totalCount = prBoardService.getCntAll(map);
			
			PRPaging paging2 = new PRPaging(totalCount, prpaging.getCurPage());
			
			paging2.setsearch2(map);
			
			model.addAttribute("paging", paging2);
			
			List prlist = prBoardService.getList(paging2);
			
			model.addAttribute("prlist", prlist);
			
			logger.info("보드 리스트 겟 테스트 : " + prlist);
//--------------------------------------------------------------------------------------------
			
			return "admin/main"; 
		}
		
		
	}
	
	@RequestMapping(value="/admin/main", method=RequestMethod.POST)
	public String board(int category, String searchcategory, String searchtarget, @RequestParam(defaultValue="1") int curPage, Model model, HttpServletRequest req) {
		if (category == 1) {
			//자유게시판
			Map<String, String> map = new HashMap<String, String>();
			
			map.put("searchcategory", searchcategory);
			map.put("searchtarget", searchtarget);
			
			Paging fbpaging = new Paging(freeboardService.getListCnt(map), curPage);
			
			fbpaging.setSearchcategory(searchcategory);
			fbpaging.setSearchtarget(searchtarget);

			model.addAttribute("fbpaging", fbpaging);
			model.addAttribute("url", req.getRequestURI());
			
			List<FreeBoard> list = freeboardService.getList(fbpaging);
			
			model.addAttribute("fblist", list);
			
			List<FreeBoard> viewList = freeboardService.getViewsList();
			
			model.addAttribute("viewList", viewList);
			
			return "/admin/board/freeBoard";
		}
		
		return "/admin/board/user";
	}
	
}
