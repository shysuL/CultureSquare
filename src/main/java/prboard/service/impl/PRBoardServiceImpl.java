package prboard.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import prboard.dao.face.PRBoardDao;
import prboard.dto.PRBoard;
import prboard.service.face.PRBoardService;

@Service
public class PRBoardServiceImpl implements PRBoardService {
	
	@Autowired private PRBoardDao prBoardDao;



}
