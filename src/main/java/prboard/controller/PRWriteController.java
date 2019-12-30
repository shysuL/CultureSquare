package prboard.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import prboard.service.face.PRBoardService;

@Controller
public class PRWriteController {
	
	private static final Logger logger = LoggerFactory.getLogger(PRWriteController.class);
	@Autowired private PRBoardService prBoardService;
	
	@RequestMapping(value="/prboard/write", method=RequestMethod.GET)
	public void writePR() {}
	
}
