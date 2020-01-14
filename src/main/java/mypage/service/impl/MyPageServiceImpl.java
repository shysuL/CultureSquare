package mypage.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import mypage.dao.face.MyPageDao;
import mypage.service.face.MyPageService;
import prboard.dto.UpFile;
import user.dto.User_table;
import util.MyPaging;
import util.Paging;

@Service
public class MyPageServiceImpl implements MyPageService{
	
	@Autowired ServletContext context;
	@Autowired MyPageDao mypageDao;

	@Override
	public void modifyUserInfo(User_table user) {
		mypageDao.updateUserInfo(user);
	}

	@Override
	public User_table getUserInfo(User_table user) {
		
		return mypageDao.selectUserAll(user);
		
	}

	@Override
	public User_table getFindUserPw(User_table user) {
		
		return mypageDao.selectByUserPw(user);
	}

	@Override
	public User_table getCurrentPwParam(Model model) {
		
		User_table user = new User_table();
		
		String param = null;
		
		param = (String) model.getAttribute("userpw");
		
		System.out.println("서비스임플 getCurrentPwParam : " + param);
		
		user.setUserpw(param);
		
		return user;
	}

	@Override
	public boolean equalsPw(User_table pwParam) {
		
		int cnt = 0;
		cnt = mypageDao.selectCntByUserPw(pwParam);
		System.out.println("cnt : " + cnt);
		System.out.println(pwParam);
		if(cnt == 1) {
			return true;
		}
		
		return false;
	}

	@Override
	public void modifyUserPassword(User_table pwParam) {
		System.out.println("서비스 임플에서 pwParam(변경비밀번호가 나와야함 : " + pwParam );
		
		mypageDao.updatePassword(pwParam);
		
		
	}

	@Override
	public boolean comparedPw(User_table user) {
		
		int cnt = 0;
		cnt = mypageDao.selectCntByUserPw(user);
		System.out.println("cnt : " + cnt);
		System.out.println(user);
		if(cnt == 1) {
			return true;
		}
		
		return false;
	}

	@Override
	public int userNickCheck(String usernick) {
		return mypageDao.selectUserNick(usernick);
	}

	@Override
	public void deleteUser(User_table user) {
		mypageDao.deleteUserId(user);
	}

	@Override
	public MyPaging getPaging(MyPaging paging) {
		
		int totalCount = mypageDao.selectCntAll(paging);
		
		MyPaging result = new MyPaging(totalCount, paging.getCurPage());
		result.setUserno(paging.getUserno());
		
		return result;
	}
	
	@Override
	public MyPaging getLikePaging(MyPaging paging) {
		
		int totalCount = mypageDao.selectLikeCntAll(paging);
		
		MyPaging result = new MyPaging(totalCount, paging.getCurPage());
		result.setUserno(paging.getUserno());
		
		return result;
	}
	
	@Override
	public List<HashMap<String, Object>> getLikeList(MyPaging paging) {
		
		return mypageDao.selectLikePost(paging);
	}

	@Override
	public List<HashMap<String, Object>> getWriteList(MyPaging paging) {
		return mypageDao.selectWritePost(paging);
	}
	
	@Override
	public List<HashMap<String, Object>> getReplyList(MyPaging paging) {
		return mypageDao.selectReplyPost(paging);
	}
	
	@Override
	public User_table fileSave(MultipartFile mFile, int userno) {
		
		String storedPath = context.getRealPath("upload");
		String uuid = UUID.randomUUID().toString().split("-")[4];
		String filename = mFile.getOriginalFilename() + "_" + uuid;
		File dest = new File(storedPath, filename);
		
		try {
			mFile.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//DB에 저장
		User_table userFile = new User_table();
		userFile.setOriginname(mFile.getOriginalFilename());
		userFile.setStoredname(filename);
		userFile.setUserno(userno);
		
		mypageDao.insertPhoto(userFile);
		
		return userFile;
		
	}
	
	@Override
	public void firstImageSave(MultipartFile mFile, int userno) {
		
		String storedPath = context.getRealPath("mypageImage");
		String uuid = UUID.randomUUID().toString().split("-")[4];
		String filename = userno + "";
		File dest = new File(storedPath, filename);
		
		try {
			mFile.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public User_table getFile(int userno) {
		
		return mypageDao.selectFile(userno);
	}
	
	@Override
	public void fileDelete(User_table userphoto) {
		File file = new File(context.getRealPath("upload\\" + userphoto.getStoredname()));
		
		if(file.exists() == true) {
			file.delete();
		}
		
		mypageDao.deleteFile(userphoto);
	}
	
	@Override
	public void userupdate(User_table user) {
		mypageDao.updateUserPermit(user);
	}

	@Override
	public MyPaging getPermitPaging(MyPaging paging) {
		
		int totalCount = mypageDao.selectPermitCntAll(paging);
		
		MyPaging result = new MyPaging(totalCount, paging.getCurPage());
		result.setUserno(paging.getUserno());
		
		return result;
	}

	@Override
	public List<HashMap<String, Object>> getPermitList(MyPaging paging) {
		return mypageDao.selectPermitList(paging);
	}
	
	@Override
	public MyPaging getReplyPaging(MyPaging paging) {
		
		int totalCount = mypageDao.selectReplyCntAll(paging);
		
		MyPaging result = new MyPaging(totalCount, paging.getCurPage());
		result.setUserno(paging.getUserno());
		
		return result;
	}
	
	@Override
	public MyPaging getFollowPaing(MyPaging paging) {
		
		int totalCount = mypageDao.selectFollowCntAll(paging);
		
		MyPaging result = new MyPaging(totalCount, paging.getCurPage());
		result.setUserno(paging.getUserno());
		
		return result;
	}

	@Override
	public List<HashMap<String, Object>> getFollowList(MyPaging paging) {
		return mypageDao.selectFollowList(paging);
	}
	
}
