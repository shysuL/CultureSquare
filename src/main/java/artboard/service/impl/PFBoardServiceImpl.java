package artboard.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
	public List<Board> getList(String searchMonth) {
		
		List<Board> list = pfboardDao.selectAll3(searchMonth);
		for (int i = 0; i < list.size(); i++) {
			Board board = list.get(i);
			board.setPerformday(getDateDay(board.getPerformdate(),"yyyyMMdd"));
		}
		return list;
	}
	

	@Override
	public Board view(Board bno) {
		return pfboardDao.view(bno);
	}

	@Override
	public Board getWriter(Board userno) {
		return pfboardDao.selectWriter(userno);
	}

	@Override
	public void write(Board board) {
		// boardno - board_seq.nextval
		board.setBoardno(pfboardDao.selectSeqNextval());
		
		pfboardDao.insertBoard(board);
		pfboardDao.insertPerform(board);
	}

	@Override
	public String getDateDay(String date, String dateType){
		String day = "" ;
	     
	    SimpleDateFormat dateFormat = new SimpleDateFormat(dateType) ;
	    Date nDate = null;
		try {
			nDate = dateFormat.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     
	    Calendar cal = Calendar.getInstance() ;
	    cal.setTime(nDate);
	     
	    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
	     
	     
	     
	    switch(dayNum){
	        case 1:
	            day = "일";
	            break ;
	        case 2:
	            day = "월";
	            break ;
	        case 3:
	            day = "화";
	            break ;
	        case 4:
	            day = "수";
	            break ;
	        case 5:
	            day = "목";
	            break ;
	        case 6:
	            day = "금";
	            break ;
	        case 7:
	            day = "토";
	            break ;
	             
	    }
	    return day ;
	}
	
	

}
