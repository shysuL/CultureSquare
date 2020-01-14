package board.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import artboard.dto.PFUpFile;
import board.dao.face.NoticeBoardDao;
import board.dto.FreeBoard;
import board.dto.Reply;
import board.dto.UpFile;
import board.service.face.NoticeBoardService;
import util.Paging;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService{

	@Autowired private NoticeBoardDao noticeboardDao;
	@Autowired ServletContext context;
	
	@Override
	public List<FreeBoard> getList(Paging paging) {
		
		return noticeboardDao.selectAll(paging);
	}

	@Override
	public int getListCnt(FreeBoard noticeboard) {
		
		return noticeboardDao.selectNoticeCnt(noticeboard);
	}
	
	@Override
	public int getListCnt(Map<String, String> map) {
		return noticeboardDao.selectCnt(map);
	}

	@Override
	public FreeBoard noticeDetail(int boardno) {
		
		return noticeboardDao.selectnoticeDetail(boardno);
	}

	@Override
	public void writeNotice(FreeBoard noticeboard) {
		
		noticeboardDao.insertnoticeBoard(noticeboard);
		
	}

	@Override
	public void increaseViews(int boardno) {
		
		noticeboardDao.updateViews(boardno);
		
	}

	@Override
	public FreeBoard getUserNoByNick(Object attribute) {
		
		return noticeboardDao.selectByUserNick(attribute);
	}

	@Override
	public List<FreeBoard> getViewsList() {
		
		return noticeboardDao.selectViewsAll();
	}

	@Override
	public void noticeDelete(int boardno) {
		
		noticeboardDao.deletenoticeBoard(boardno);
		
	}

	@Override
	public void updateNoticeBoard(FreeBoard noticeboard) {

		noticeboardDao.updatenoticeBoard(noticeboard);
		
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
		
		noticeboardDao.insertFile(upfile);

	}

	@Override
	public UpFile getFile(int boardno) {
		
		return noticeboardDao.selectFile(boardno);
		
	}

	@Override
	public UpFile getFileNo(int fileno) {
		
		return noticeboardDao.selectFileNo(fileno);
		
	}

	@Override
	public void fileDelete(UpFile fileinfo) {
		
		File file = new File(context.getRealPath("upload\\"+fileinfo.getStoredname()));
		
		// 삭제할 파일의 경로
		if(file.exists() == true){
			file.delete();
		}	
		noticeboardDao.deleteFile(fileinfo);
		
	}

	@Override
	public int recommendCheck(FreeBoard noticeBoard) {
//		int check = noticeboardDao.selectRecommend(noticeBoard);
//
//		//전에 추천한적이 없다면
//		if(check == 0) {
//			
//			return check; //추천
//		}
//		else {
//			return check; //추천 취소
//		}
		return 0;
	}

	@Override
	public void recommend(FreeBoard noticeBoard) {

//		noticeboardDao.insertRecommend(noticeBoard);
		
	}

	@Override
	public void recommendCancal(FreeBoard noticeBoard) {

//		noticeboardDao.deleteRecommend(noticeBoard);
		
	}

	@Override
	public int recommendView(FreeBoard noticeBoard) {
		return 0;
//		return noticeboardDao.selectrecommendView(noticeBoard);
	}

	@Override
	public void deleteBlike(int boardno) {

//		noticeboardDao.deleteBlike(boardno);
		
	}

	@Override
	public void insertReply(Reply reply) {
		
//		noticeboardDao.insertReply(reply);
		
	}

	@Override
	public List<Reply> getReplyList(int boardno) {
		return null;
//		return noticeboardDao.selectReply(boardno);
		
	}

	@Override
	public void fileSave(MultipartFile mFile, int boardno) {
		
		String storedPath = context.getRealPath("upload");
		String uuid = UUID.randomUUID().toString().split("-")[4];
		String filename = mFile.getOriginalFilename() + "_" + uuid;
		File dest = new File(storedPath, filename);
		
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
		UpFile upfile = new UpFile();
		upfile.setOriginname(mFile.getOriginalFilename());
		upfile.setStoredname(filename);
		upfile.setFilesize((int)mFile.getSize());
		upfile.setBoardno(boardno);

		noticeboardDao.insertFile(upfile);
		
	}
	
	@Override
	public void firstImageSave(MultipartFile mFile, int boardno) {
		
		String storedPath = context.getRealPath("pfImage");
		String uuid = UUID.randomUUID().toString().split("-")[4];
		String filename = boardno +"";
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

}
