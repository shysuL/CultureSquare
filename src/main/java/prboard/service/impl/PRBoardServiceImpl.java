package prboard.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import prboard.dao.face.PRBoardDao;
import prboard.service.face.PRBoardService;

@Service
public class PRBoardServiceImpl implements PRBoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(PRBoardServiceImpl.class);
	
	
	@Autowired private PRBoardDao prBoardDao;

	
	
}
