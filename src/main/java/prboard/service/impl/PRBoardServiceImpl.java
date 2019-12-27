package prboard.service.impl;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import prboard.controller.PRListController;
import prboard.dao.face.PRBoardDao;
import prboard.service.face.PRBoardService;

@Service
public class PRBoardServiceImpl implements PRBoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(PRBoardServiceImpl.class);
	
	String ScheduledNickname = "";
	
	@Autowired private PRBoardDao prBoardDao;
	
	@Override
	public void getNickName(String nickName) {
		ScheduledNickname = nickName;
	} 

    /*
     * 5초 마다 실행 => 5000
     * 30초(1분)마다 실행 => 30000
     */
    @Scheduled(fixedDelay=30000)
    public void prCntReset() {
    	
    	if(ScheduledNickname == null || ScheduledNickname.equals(""))
    		logger.info("널 : " + ScheduledNickname);
    	else {
    		logger.info("성공 : " + ScheduledNickname);
          prBoardDao.updatePRCnt(ScheduledNickname);
    	}
    }


}
