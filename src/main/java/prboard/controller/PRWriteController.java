package prboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PRWriteController {
	
	@RequestMapping(value="/prboard/write", method=RequestMethod.GET)
	public void boardWrite() {}
}
