package artboard.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import artboard.dao.face.PFBoardDao;
import artboard.dao.face.ReplyDao;
import artboard.dto.Board;
import artboard.dto.Donation;
import artboard.dto.Reply;
import artboard.service.face.PFBoardService;

import prboard.dto.UpFile;

import util.Paging;



@Service
public class PFBoardServiceImpl implements PFBoardService{

	@Autowired PFBoardDao pfboardDao;
	@Autowired ReplyDao replyDao;
	
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
		//게시글 조회수 +1
		pfboardDao.updateViews(bno);
		
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


	@Override
	public Board getUserByNo(Board userno) {
		return pfboardDao.selectUserByNo(userno);
	}


	@Override
	public void insertReply(Reply reply) {
		replyDao.insertReply(reply);
	}


	@Override
	public int getUsernoByUsernick(Board loginUser) {
		return pfboardDao.selectUsernoByUsernick(loginUser);
	}


	@Override
	public List<Reply> getReplyList(Board bno) {
		return replyDao.selectReply(bno);
	}


	@Override
	public boolean deleteReply(Reply reply) {
		replyDao.deleteReply(reply);
		
		if(replyDao.countReply(reply) > 0) {
			return false;
		}else {
			return true;
		}		
	}


	@Override
	public Donation getUserNoByNick(Donation donation) {
		donation.setUserno(pfboardDao.selectNoForDonation(donation));
		return donation;
	}


	@Override
	public void insertDonation(Donation donation) {
		pfboardDao.insertDonation(donation);
	}


	@Override
	public void insertRereply(Reply reply) {
		replyDao.insertRereply(reply);
	}


	@Override
	public List<Reply> getReplyByboardNo(Reply reply) {
		return replyDao.selectReplyList(reply);
	}
	
	@Override
	public void fileSave(MultipartFile mFile, int boardno) {
		
	}


	@Override
	public List<UpFile> getFileList(int boardno) {
		return null;
	}


	@Override
	public UpFile getFile(int fileno) {
		return null;
	}


	@Override
	public void deleteServerFile(List<UpFile> list) {
		
	}


	@Override
	public void deleteFile(List<UpFile> list) {
	}

	@Override
	public List<Board> getselectAll(Paging pfpaging) {
		return pfboardDao.selectAll(pfpaging);
	}


	@Override
	public int getTotalCnt(Board pfboard) {
		return pfboardDao.selectPfCnt(pfboard);

	}
	

}
