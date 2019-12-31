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
import prboard.dto.PRBoard;
import prboard.dto.PRType;
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
		try {	
			mFile.transferTo(dest);			//실제 파일 저장
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
	
	
	
}
