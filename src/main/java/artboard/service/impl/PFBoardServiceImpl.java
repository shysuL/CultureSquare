package artboard.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import artboard.dao.face.PFBoardDao;
import artboard.dto.PFBoard;
import artboard.service.face.PFBoardService;
import util.Paging;


@Service
public class PFBoardServiceImpl implements PFBoardService{

	@Autowired PFBoardDao pfboardDao;
	
	@Override
	public List<PFBoard> getList(Paging paging) {
		return pfboardDao.selectAll(paging);
	}

	@Override
	public int getTotalPage() {
		return pfboardDao.selectCntAll();
	}
	
	

}
