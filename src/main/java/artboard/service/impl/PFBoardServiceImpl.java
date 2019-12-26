package artboard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import artboard.dao.face.PFBoardDao;
import artboard.dto.Board;
import artboard.service.face.PFBoardService;
import util.Paging;


@Service
public class PFBoardServiceImpl implements PFBoardService{

	@Autowired PFBoardDao pfboardDao;
	
	@Override
	public List getList(Paging paging) {
		return pfboardDao.selectAll(paging);
	}

	@Override
	public Paging getPaging(Paging paging) {
		
		int totalCount = pfboardDao.selectCntAll();
		
		return new Paging(totalCount, paging.getCurPage() );
	}

	@Override
	public Board view(Board bno) {
		return pfboardDao.view(bno);
	}

	@Override
	public Board getWriter(Board userno) {
		return pfboardDao.selectWriter(userno);
	}
	
	

}
