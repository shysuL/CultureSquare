package board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dao.face.FreeBoardDao;
import board.dto.FreeBoard;
import board.service.face.FreeBoardService;
import util.Paging;


@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Autowired private FreeBoardDao freeboardDao;

	@Override
	public List<FreeBoard> getList(Paging paging) {
		
		return freeboardDao.selectAll(paging);
	}

	@Override
	public int getListCnt() {
		
		return freeboardDao.selectCnt();
	}

	@Override
	public FreeBoard getView(int boardno) {
		return freeboardDao.selectDetail(boardno);
	}

	}
