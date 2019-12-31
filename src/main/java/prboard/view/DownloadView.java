package prboard.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import prboard.dto.UpFile;


public class DownloadView extends AbstractView {
	
	private static final Logger logger = LoggerFactory.getLogger(DownloadView.class);
	
	@Autowired ServletContext context;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		//모델값 가져오기
		UpFile file = (UpFile) model.get("downFile");
		
		System.out.println(file);
		
		logger.info("모델값 : " + file);
		
		//서블릿컨텍스트 얻기
		ServletContext context = request.getSession().getServletContext();
		
		String path = context.getRealPath("upload");
		String filename = file.getStoredname();
		
		//업로드된 실제 파일에 대한 객체 얻기
		File src = new File( path, filename );
		
		logger.info("파일 : " + src);
		logger.info("파일존재여부 : " + src.exists());
		
		//ContentType 설정
		//	이진데이터(application/octet-stream) 형식으로 응답 설정
		//	 브라우저는 응답 받은 데이터의 형식이
		//	어떤 형태를 가지는지 알 수 없게되어 무조건 다운받아버린다
		response.setContentType("application/octet-stream");
		
		//응답 데이터의 크기 설정
		response.setContentLength( (int)src.length() );
		
		//응답 데이터의 인코딩 설정
		response.setCharacterEncoding("utf-8");
		
		//클라이언트가 저장할 때 사용할 파일 이름에 대한 인코딩 설정
		String outfileName
		= URLEncoder.encode( file.getOriginname());
		logger.info("변환된 파일명 : " + outfileName);
		
		outfileName = outfileName.replace("+", "%20"); //띄어쓰기 변환
		logger.info("보정된 파일명 : " + outfileName);
		
		//브라우저가 다운로드에 사용할 이름 설정
		response.setHeader("Content-Disposition", "attachment; filename=\"" + outfileName + "\"");
		
		//응답(브라우저로 출력)
		
		//	서버의 File -> FileInputStream
		//	-> OutputStream으로 출력
		
		//서버에 저장된 파일 객체
		File origin = new File(context.getRealPath("upload"),
				file.getStoredname());
//		File origin = src;
		
		//서버의 파일 입력스트림
		FileInputStream fis = new FileInputStream(origin);
		
		//서버의 응답 출력 스트림
		OutputStream out = response.getOutputStream();
		
		//서버->클라이언트 복사(출력)
		FileCopyUtils.copy(fis, out);
		out.flush(); //출력버퍼 비우기
		
		//스트림 닫기
		fis.close();
		out.close();
	}

}
