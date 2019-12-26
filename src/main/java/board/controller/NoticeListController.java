package board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NoticeListController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeListController.class);
	
	@RequestMapping(value = "/board/noticelist", method = RequestMethod.GET)
	public void noticeboardList(Model model, @RequestParam(defaultValue = "1") int curPage) {
		logger.info("노티스 보드 리스트");
	}
}
