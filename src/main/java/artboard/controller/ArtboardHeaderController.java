package artboard.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ArtboardHeaderController {
	private static final Logger logger = LoggerFactory.getLogger(ArtboardHeaderController.class);
	
	@RequestMapping(value = "/layout/header", method = RequestMethod.GET)
	public void getCurdate(Model model) {
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy");
		SimpleDateFormat format2 = new SimpleDateFormat ( "MM");
				
		Date time = new Date();
				
		String nowYear = format1.format(time);
		String nowMonth = format2.format(time);
				
		model.addAttribute("nowYear",nowYear);
		model.addAttribute("nowMonth",nowMonth);
		
		System.out.println("nowYear : " + nowYear);
		System.out.println("nowMonth : " + nowMonth);
		logger.info("nowYear : " + nowYear);
		logger.info("nowMonth : " + nowMonth);
		
		
		
	}

}
