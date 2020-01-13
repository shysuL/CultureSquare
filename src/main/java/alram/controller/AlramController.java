package alram.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import alram.dto.Alram;
import alram.service.face.AlramService;
import prboard.controller.PRViewController;
import prboard.dto.Reply;
import user.dto.User_table;

@Controller
public class AlramController {
	
	@Autowired private AlramService alramService;
	private static final Logger logger = LoggerFactory.getLogger(AlramController.class);
	
	@RequestMapping(value="/alram/alarmcnt")
	public ModelAndView alarmcnt(ModelAndView mav, User_table user) {
		
		//1. 사용자 번호 구하기
		user.setUserno(alramService.getUserNoByUserNick(user.getUsernick()));
		
		//2. 알람 갯수 구하기
		int alramCnt = alramService.getAlramCnt(user.getUserno());
		
		mav.addObject("alramCnt", alramCnt);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/alram/readalram")
	public ModelAndView readalram(ModelAndView mav, User_table user) {
		
		//1. 사용자 번호 구하기
		user.setUserno(alramService.getUserNoByUserNick(user.getUsernick()));
		
		//2. 알림 읽음 표시 1로 업데이트
		alramService.readAlram(user.getUserno());
		
		mav.addObject("update", true);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
	
	@RequestMapping(value="/alram/getAlramList")
	public ModelAndView getAlramList(ModelAndView mav, User_table user) {
		
		ArrayList<HashMap> alramList = new ArrayList<HashMap>();
		
		//1. 사용자 번호 구하기
		user.setUserno(alramService.getUserNoByUserNick(user.getUsernick()));
		
		// 해당 사용자 알람 리스트 불러오기
		List<Alram> alramVO = alramService.getAlramList(user.getUserno());
		
		logger.info("알람 테스트 : "  + alramVO);
		
	     
        if(alramVO.size() > 0){
        	
        	
            for(int i=0; i<alramVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("alramno", alramVO.get(i).getAlramno());
                hm.put("alramcontents", alramVO.get(i).getAlramcontents());
                hm.put("alramtime", alramVO.get(i).getAlramcheck());
                hm.put("alramtype", alramVO.get(i).getAlramtype());
                hm.put("alramsender", alramVO.get(i).getAlramsender());
                hm.put("usernick", alramVO.get(i).getUsernick());
                hm.put("boardno", alramVO.get(i).getBoardno());
                hm.put("title", alramVO.get(i).getTitle());
                
                alramList.add(hm);
            }
        }
        
        logger.info("알람 리스트 테스트: " + alramList);
		
			
		mav.addObject("alramList", alramList);
		//viewName지정하기
		mav.setViewName("jsonView");
		
		return mav;
		
	}
}
