package prboard.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import prboard.dao.face.PRBoardDao;
import prboard.dto.Alram;
import prboard.dto.PRBoard;
import prboard.dto.PRType;
import prboard.dto.Reply;
import prboard.dto.UpFile;
import prboard.service.face.PRBoardService;
import util.PRPaging;

@Service
public class PRBoardServiceImpl implements PRBoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(PRBoardServiceImpl.class);
	
	@Autowired ServletContext context;
	@Autowired private PRBoardDao prBoardDao;


	@Override
	public void writePR(PRBoard prBoard) {
		
		//게시글 삽입
		prBoardDao.insertPR(prBoard);
	}

	@Override
	public int getUserNoByUserNick(String userNick) {
		return prBoardDao.selectUserNoByUserNick(userNick);
	}

	@Override
	public void insertPRType(PRType prType) {

		prBoardDao.insertPRType(prType);
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
//		File imgDest = new File(storedPath2, filename);
		try {	
			mFile.transferTo(dest);			//실제 파일 저장
//			mFile.transferTo(imgDest);		//이미지 파일 저장
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		// DB에 저장 (업로드된 파일의 정보를 기록)
		UpFile upfile = new UpFile();
		upfile.setOriginname(mFile.getOriginalFilename());
		upfile.setStoredname(filename);
		upfile.setFilesize((int)mFile.getSize());
		upfile.setBoardno(boardNo);
		
		prBoardDao.insertFile(upfile);
		
	}

	@Override
	public void updatePrWriteDate(int userNo) {

		prBoardDao.updateWritePrDate(userNo);
	}

	@Override
	public String getWriteDate(int userNo) {
		
		return prBoardDao.selectWriteDate(userNo);
	}

	@Override
	public int getTimePass(String writeDate) {
		
		return prBoardDao.selectTimePass(writeDate);
	}

	@Override
	public int getCntAll(Map<String, String> map) {
		return prBoardDao.selectCntAll(map);
	}

	@Override
	public List getList(PRPaging paging) {
		
		List list = prBoardDao.selectAll(paging);
		return list;
	}

	@Override
	public PRBoard getViewInfo(int boardno) {
		
		prBoardDao.hit(boardno);
		PRBoard viewBoard = prBoardDao.selectViewInfo(boardno);
		
		return viewBoard;
	}

	@Override
	public List<UpFile> getFileList(int boardno) {
		
		List<UpFile> list = prBoardDao.selectFileList(boardno);
		return list;
	}

	@Override
	public UpFile getFile(int fileno) {
		return prBoardDao.selectFileByFileno(fileno);
	}

	@Override
	public void firstImageSave(MultipartFile mFile, int boardno) {

		//파일이 저장될 경로
		String storedPath = context.getRealPath("prImage");
		
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
	public void modifyPR(PRBoard prBoard) {

		// 1. 게시글 내용 변경
		prBoardDao.updatePR(prBoard);
		
		// 2. PR 유형 변경
		prBoardDao.updatePRType(prBoard);
		
	}

	@Override
	public void deleteThumbnail(int boardno) {

		String storedPath = context.getRealPath("prImage");
		//서버에 있는 파일 삭제
		// 삭제할 파일의 경로
		String path = storedPath+"\\"+boardno; 
		
		File file = new File(path);
		if(file.exists() == true){
			file.delete();
			logger.info("삭제 성공임니당!");
		}
	}
	
	@Override
	public void deleteServerFile(List<UpFile> list) {
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
	public void deleteFile(List<UpFile> list) {

		// DB에 있는 파일 삭제
		for (int i=0; i<list.size(); i++) {
			prBoardDao.deleteFile(list.get(i).getBoardno());
		}
	}

	@Override
	public void deletePR(PRBoard prBoard) {

		prBoardDao.deletePR(prBoard);
	}

	@Override
	public void deletePRType(PRBoard prBoard) {

		prBoardDao.deletePRType(prBoard);
	}

	@Override
	public PRBoard getUserNoByNick(String usernick) {
		
		return prBoardDao.selectUserNoToLike(usernick);
	}
	
	@Override
	public int recommendCheck(PRBoard prBoard) {
		
		int check = prBoardDao.selectRecommend(prBoard);

		//전에 추천한적이 없다면
		if(check == 0) {
			
			return check; //추천
		}
		else {
			return check; //추천 취소
		}
	}

	@Override
	public void recommend(PRBoard prBoard) {

		prBoardDao.insertRecommend(prBoard);
	}

	@Override
	public void recommendCancal(PRBoard prBoard) {

		prBoardDao.deleteRecommend(prBoard);
	}

	@Override
	public int recommendView(PRBoard prBoard) {

		return prBoardDao.selectrecommendView(prBoard);
	}

	@Override
	public void deleteBlike(PRBoard prBoard) {

		prBoardDao.deleteBlike(prBoard);
	}

	@Override
	public Reply getUserNoForReply(String usernick) {
		return prBoardDao.selectUserNoToReply(usernick);
	}

	@Override
	public List<Reply> getReplyByboardNo(Reply reply) {
		return prBoardDao.selectReplyList(reply);
	}

	@Override
	public void deleteReplyToBoard(PRBoard prBoard) {
		prBoardDao.deleteReplyToBoard(prBoard);
	}

	@Override
	public void addReply(Reply reply) {

		prBoardDao.insertReply(reply);
	}

	@Override
	public void deleteReplyByNo(Reply reply) {

		prBoardDao.deleteReplyByNo(reply);
	}

	@Override
	public void updateReplyByNo(Reply reply) {

		prBoardDao.updateReplyByNo(reply);
	}

	@Override
	public int getGroupNoByReplyNo(Reply reply) {
		return prBoardDao.selectGroupNo(reply);
	}

	@Override
	public List<Reply> getReReplyByNo(int groupNo) {
		return prBoardDao.selectReReplyList(groupNo);
	}

	@Override
	public int getREreplyCnt(int groupno) {
		return prBoardDao.selectREreplyCnt(groupno);
	}

	@Override
	public void deleteReReplyByGroupNo(int groupNo) {

		prBoardDao.deleteReReplyByGroupNo(groupNo);
	}

	@Override
	public int getMaxReplyOrder(Reply reply) {
		
		return prBoardDao.selectMaxReplyOrder(reply);
	}

	@Override
	public void addReReply(Reply reply) {

		prBoardDao.insertReReply(reply);
	}

	@Override
	public Reply getUserNoForReplyLike(String usernick) {

		return prBoardDao.selectUserNoToReplyLike(usernick);
	}

	@Override
	public int replyRecommendCheck(Reply reply) {
		
		int check = prBoardDao.selectReplyRecommend(reply);

		//전에 추천한적이 없다면
		if(check == 0) {
			
			return check; //추천
		}
		else {
			return check; //추천 취소
		}
	}

	@Override
	public int replyRecommendView(Reply reply) {
		
		return prBoardDao.selectReplyRecommendView(reply);
	}

	@Override
	public void replyRecommend(Reply reply) {

		prBoardDao.insertReplyRecommend(reply);
	}

	@Override
	public void replyRecommendCancal(Reply reply) {

		prBoardDao.deleteReLike(reply);
	}

	@Override
	public void deleteReLike(int replyno) {

		prBoardDao.deleteReLikeForBoard(replyno);

	}

	@Override
	public List<Reply> getBestReplyByboardNo(Reply reply) {
		
		return prBoardDao.selectBestReplyList(reply);
	}

	@Override
	public List<Reply> getMostReplyByboardNo(Reply reply) {

		return prBoardDao.selectMostReplyList(reply);
	}

	@Override
	public List getMoreList(PRPaging paging) {
		List list = prBoardDao.selectAllByViews(paging);
		return list;
	}

	@Override
	public List getLikeList(PRPaging paging) {
		List list = prBoardDao.selectAllByLike(paging);
		return list;
	}

	@Override
	public int getUserno(int boardno) {
		return prBoardDao.selectUserNoByBoardNo(boardno);
	}

	@Override
	public void insertReplyAlram(Alram alram) {

		prBoardDao.insertReplyAlram(alram);
	}
}
