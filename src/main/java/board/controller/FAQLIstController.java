package board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FAQLIstController {
	
	private static final Logger logger = LoggerFactory.getLogger(FAQLIstController.class);
	
	@RequestMapping(value = "/board/faqlist", method = RequestMethod.GET)
	public void faqList(Model model, @RequestParam(defaultValue = "1") int curPage) {
	
	}
}
