package board.service.impl;

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

import board.controller.FreeWriteController;
import board.dao.face.FreeBoardDao;
import board.dto.FreeBoard;
import board.dto.UpFile;
import board.service.face.FreeBoardService;
import user.dto.User_table;
import util.Paging;


@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(FreeWriteController.class);
	
	@Autowired private FreeBoardDao freeboardDao;
	@Autowired ServletContext context;
	
	@Override
	public List<FreeBoard> getList(Paging paging) {
		
		return freeboardDao.selectAll(paging);
	}

	@Override
	public int getListCnt(Map<String, String> map) {
		
		return freeboardDao.selectCnt(map);
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

	@Override
	public void freeDelete(int boardno) {
		
		freeboardDao.deleteFreeBoard(boardno);
		
	}

	@Override
	public void updateFreeBoard(FreeBoard freeboard) {

		freeboardDao.updateFreeBoard(freeboard);
		
	}

	@Override
	public void filesave(UpFile upfile, int boardno) {
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");

		//UUID
		String uid = UUID.randomUUID().toString().split("-")[4];

		//저장될 파일의 이름 (원본명 + UUID)
		String filename = upfile.getFile().getOriginalFilename()+"_"+uid;
		

		//저장될 파일 객체
		File dest = new File(storedPath, filename);

		try {
			upfile.getFile().transferTo(dest); //실제 파일 저장
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}


		// DB에 저장 (업로드된 파일의 정보를 기록)
		upfile.setOriginname(upfile.getFile().getOriginalFilename());
		upfile.setStoredname(filename);
		upfile.setFilesize(upfile.getFile().getSize());
		upfile.setBoardno(boardno);
		logger.info(upfile.toString());
		
		freeboardDao.insertFile(upfile);

	}

	@Override
	public UpFile getFile(int boardno) {
		
		return freeboardDao.selectFile(boardno);
	}

	@Override
	public UpFile getFileNo(int fileno) {
		
		return freeboardDao.selectFileNo(fileno);
	}

	@Override
	public void fileDelete(UpFile fileno) {
		
		freeboardDao.deleteFile(fileno);
		
	}

	}
