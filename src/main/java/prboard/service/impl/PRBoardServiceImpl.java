package prboard.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import prboard.dao.face.PRBoardDao;
import prboard.service.face.PRBoardService;
import user.dto.User_table;

@Service
public class PRBoardServiceImpl implements PRBoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(PRBoardServiceImpl.class);
	
	String ScheduledNickname = "";
	
	@Autowired private PRBoardDao prBoardDao;
	
	@Override
	public void getNickName(String usernick) {
		ScheduledNickname = usernick;
	} 
	
	@Override
	public int getprCntByNickName(String usernick) {
		User_table user = new User_table();
		
		user = prBoardDao.selectprCnt(usernick);
		
		return user.getPrcnt();
		
	}

    /*
     * 5초 마다 실행 => 5000
     * 30초(1분)마다 실행 => 30000
     */
    @Scheduled(fixedDelay=10000)
    public void prCntReset() {
    	
    	if(ScheduledNickname == null || ScheduledNickname.equals("") )
    		logger.info("널 : " + ScheduledNickname);
    	else {
    		
    		int prCnt = getprCntByNickName(ScheduledNickname);
    		logger.info("prnct갯수 ? " + prCnt);
    		
    		if(prCnt == 0)
    			logger.info("널은 아닌데 prCnt가 0임 : " + ScheduledNickname);
    		else {
    			logger.info("성공 : " + ScheduledNickname);
    			prBoardDao.updatePRCnt(ScheduledNickname);
    		}
    		
    	}
    }
}
