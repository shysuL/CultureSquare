package board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dao.face.FreeBoardDao;
import board.dto.FreeBoard;
import board.service.face.FreeBoardService;
import user.dto.User_table;
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
	public FreeBoard freeDetail(int boardno) {
		
		return freeboardDao.selectFreeDetail(boardno);
	}

	@Override
	public void writeFree(FreeBoard freeboard) {
		
		freeboardDao.insertFreeBoard(freeboard);
		
	}

	@Override
	public void increaseViews(int boardno) {
		
		freeboardDao.updateViews(boardno);
		
	}

	@Override
	public User_table getboardWriter(Object attribute) {
		
		return freeboardDao.selectByUserNick(attribute);
	}

	@Override
	public List<FreeBoard> getViewsList() {
		
		return freeboardDao.selectViewsAll();
	}



	}
