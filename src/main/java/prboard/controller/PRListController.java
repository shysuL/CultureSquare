package prboard.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import user.controller.LoginController;
import util.Paging;

@Controller
public class PRListController {
	private static final Logger logger = LoggerFactory.getLogger(PRListController.class);

	@RequestMapping(value="/prboard/prlist", method=RequestMethod.GET)
	public void prList(Model model, Paging paging) {
		logger.info("pr리스트 출력");
	}
}
