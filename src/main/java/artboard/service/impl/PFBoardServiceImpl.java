package artboard.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import artboard.dao.face.FollowDao;
import artboard.dao.face.PFBoardDao;
import artboard.dao.face.ReplyDao;
import artboard.dto.Board;
import artboard.dto.Donation;
import artboard.dto.PFUpFile;
import artboard.dto.Reply;
import artboard.service.face.PFBoardService;
import util.Paging;



@Service
public class PFBoardServiceImpl implements PFBoardService{

	private static final Logger logger = LoggerFactory.getLogger(PFBoardServiceImpl.class);
	@Autowired ServletContext context;
	@Autowired PFBoardDao pfboardDao;
	@Autowired ReplyDao replyDao;
	@Autowired FollowDao followDao;

	@Override
	public List<Board> getList(Board board) {

		List<Board> list = pfboardDao.selectAll3(board);
		for (int i = 0; i < list.size(); i++) {
			Board temp = list.get(i);
			temp.setPerformday(getDateDay(temp.getPerformdate(),"yyyyMMdd"));
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
		
		if(board.getLon().equals("") && board.getLat().equals("")) {
			
			logger.info("지도 안넣엇을때 : " + 1);
			
			// boardno - board_seq.nextval
			board.setBoardno(pfboardDao.selectSeqNextval());

			pfboardDao.insertBoard(board);
			pfboardDao.insertPerform(board);
			
		} else {
			
			logger.info("지도넣었을때 : " + 2 );
			// boardno - board_seq.nextval
			board.setBoardno(pfboardDao.selectSeqNextval());

			pfboardDao.insertBoard(board);
			pfboardDao.insertPerform(board);
			pfboardDao.insertLocation(board);
			
			
		}
			
		
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
	public void fileSave(MultipartFile mFile, int boardNo) {
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");

		//UUID
		String uid = UUID.randomUUID().toString().split("-")[4];

		//저장될 파일의 이름(원본명 + UUID)
		String filename = mFile.getOriginalFilename() + "_" + uid;

		//저장될 파일 객체
		File dest = new File(storedPath, filename);

		//저장될 이미지 파일 객체
		//				File imgDest = new File(storedPath2, filename);
		try {	
			mFile.transferTo(dest);			//실제 파일 저장
			//					mFile.transferTo(imgDest);		//이미지 파일 저장
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	

		// DB에 저장 (업로드된 파일의 정보를 기록)
		PFUpFile upfile = new PFUpFile();
		upfile.setOriginname(mFile.getOriginalFilename());
		upfile.setStoredname(filename);
		upfile.setFilesize((int)mFile.getSize());
		upfile.setBoardno(boardNo);

		pfboardDao.insertFile(upfile);

	}


	@Override
	public List<PFUpFile> getFileList(int boardno) {
		List<PFUpFile> list =pfboardDao.selectFileList(boardno);
		return list;
	}


	@Override
	public PFUpFile getFile(int fileno) {
		return pfboardDao.selectFileByFileno(fileno);
	}

	@Override
	public void firstImageSave(MultipartFile mFile, int boardno) {
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("pfImage");
		
		//UUID
		String uid = UUID.randomUUID().toString().split("-")[4];
		
		//저장될 파일의 이름(원본명 + UUID)
		String filename = boardno +"";
		
		//저장될 파일 객체
		File dest = new File(storedPath, filename);
		
		try {	
			mFile.transferTo(dest);			//실제 파일 저장
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	@Override
	public void deleteServerFile(List<PFUpFile> list) {
		String storedPath = context.getRealPath("upload");
		String path = "";
		
		// 서버에 있는 파일 삭제
		for (int i=0; i<list.size(); i++) {
			// 삭제할 파일의 경로
			path = storedPath+"\\"+list.get(i).getStoredname(); 
			
			File file = new File(path);
			if(file.exists() == true){
				file.delete();
			}
		}
	}


	@Override
	public void deleteFile(List<PFUpFile> list) {
		// DB에 있는 파일 삭제
		for (int i=0; i<list.size(); i++) {
			pfboardDao.deleteFile(list.get(i).getBoardno());
		}
	}

	@Override
	public List<Board> getselectAll(Paging pfpaging) {
		return pfboardDao.selectAll(pfpaging);
	}


	@Override
	public int getTotalCnt(Board pfboard) {
		return pfboardDao.selectPfCnt(pfboard);

	}


	@Override
	public int recommendCheck(Board board) {

		int check = pfboardDao.selectRecommend(board);

		//전에 추천한적이 없다면
		if(check == 0) {

			return check; //추천
		}
		else {
			return check; //추천 취소
		}
	}


	@Override
	public void recommend(Board board) {
		pfboardDao.insertRecommend(board);
	}


	@Override
	public void recommendCancel(Board board) {
		pfboardDao.deleteRecommend(board);
	}


	@Override
	public int recommendView(Board board) {
		return pfboardDao.selectrecommendView(board);
	}


	@Override
	public int getGroupNoByReplyNo(Reply reply) {
		return pfboardDao.selectGroupNo(reply);
	}


	@Override
	public List<Reply> getReReplyByNo(int groupNo) {
		return pfboardDao.selectReReplyList(groupNo);
	}


	@Override
	public int getREreplyCnt(int groupno) {
		return pfboardDao.selectREreplyCnt(groupno);
	}


	@Override
	public Reply getUserNoForReply(String usernick) {
		return pfboardDao.selectUserNoToReply(usernick);
	}


	@Override
	public int getMaxReplyOrder(Reply reply) {
		return pfboardDao.selectMaxReplyOrder(reply);
	}


	@Override
	public void addReReply(Reply reply) {
		pfboardDao.insertReReply(reply);
	}


	@Override
	public void modifyPF(Board board) {
		// 1. 게시글 내용 변경
		pfboardDao.updatePF(board);
		// 2. PF 추가정보(날짜, 유형) 변경
		pfboardDao.updatePFAdd(board);
	}


	@Override
	public void deleteThumbnail(int boardno) {
		//파일이 저장될 경로
		String storedPath = context.getRealPath("pfImage");
		
		String path = storedPath+"\\" +boardno;
		
		File file = new File(path);
		if(file.exists() == true){
			file.delete();
//			logger.info("삭제 성공임니당!");
		}
	}


	@Override
	public void deletePF(Board board) {
		pfboardDao.updatePFbyDelete(board);
	}


	@Override
	public void updateReplyByNo(Reply reply) {
		pfboardDao.updateReplyByNo(reply);
	}


	@Override
	public void deleteRereplyByGroupNo(int groupNo) {
		pfboardDao.deleteReReplyByGroupNo(groupNo);
	}

	
	@Override
	public Board viewLoc(Board bno) {
		return pfboardDao.selectLoc(bno);
	}


	@Override
	public void follow(Board board) {
		followDao.insertFollow(board);
	}


	@Override
	public void followCancel(Board board) {
		followDao.deleteFollow(board);
	}


	@Override
	public int followView(Board board) {
		return followDao.selectFollowView(board);
	}


	@Override
	public int followCheck(Board board) {
		int check = followDao.selectFollow(board);

		//전에 추천한적이 없다면
		if(check == 0) {

			return check; //추천
		}
		else {
			return check; //추천 취소
		}
	}


	@Override
	public void modifyLoc(Board board) {
		 pfboardDao.updateLoc(board);
	}


}
