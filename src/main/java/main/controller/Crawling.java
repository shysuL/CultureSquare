package main.controller;

import java.io.IOException;
import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import main.dto.Culture;
import main.service.face.CrawlingService;

@Controller
public class Crawling {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	@Autowired private CrawlingService crawlingService;
	
	
	@RequestMapping(value="/main/culture")
	public void main(Model model, Culture culture) {
		
		List<Culture> list = crawlingService.getList(culture);
		
		model.addAttribute("list", list);
		
		
		

	}
}


