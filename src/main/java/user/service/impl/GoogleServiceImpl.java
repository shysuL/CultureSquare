package user.service.impl;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import user.dao.face.UserDao;
import user.dto.User_table;
import user.service.face.GoogleService;

@Service
public class GoogleServiceImpl implements GoogleService {

	@Autowired private UserDao userDao;

	@Override
	public int getSocialAccountCnt(User_table user) {
		return userDao.selectSocialCnt(user);
	}

	@Override
	public void insertGoogleInfo(User_table user) {

		userDao.insertGoogleLoginInfo(user);
	}

	@Override
	public void setGoogleLogin(String code, HttpSession session, OAuth2Parameters googleOAuth2Parameters) throws IOException{
		//RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("code", code);
		parameters.add("client_id", "455988852585-f3r7dkn0se2ao5jjomake0usgfoccj1v.apps.googleusercontent.com");
		parameters.add("client_secret", "FmIfUs1Yfw3dKiHCemsSCHiT");
		parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
		parameters.add("grant_type", "authorization_code");

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(parameters, headers);
		ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token", HttpMethod.POST, requestEntity, Map.class);
		Map<String, Object> responseMap = responseEntity.getBody();

		// id_token 라는 키에 사용자가 정보가 존재한다.
		// 받아온 결과는 JWT (Json Web Token) 형식으로 받아온다. 콤마 단위로 끊어서 첫 번째는 현 토큰에 대한 메타 정보, 두 번째는 우리가 필요한 내용이 존재한다.
		// 세번째 부분에는 위변조를 방지하기 위한 특정 알고리즘으로 암호화되어 사이닝에 사용한다.
		//Base 64로 인코딩 되어 있으므로 디코딩한다.

		String[] tokens = ((String)responseMap.get("id_token")).split("\\.");
		Base64 base64 = new Base64(true);
		String body = new String(base64.decode(tokens[1]));

		String tokenInfo = new String(Base64.decodeBase64(tokens[1]), "utf-8");

		//Jackson을 사용한 JSON을 자바 Map 형식으로 변환
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> result = mapper.readValue(body, Map.class);



		//유저 DTO에 소셜 로그인 정보 저장
		User_table user = new User_table();
		user.setUsername(result.get("name"));
		user.setUsernick(result.get("given_name"));

		//소셜 로그인 정보 존재 유무 검사
		int socialCnt = getSocialAccountCnt(user);
		

		//소셜로그인 정보가 회원정보에 담겨 있지않은 경우 처음 로그인
		if(socialCnt == 0) {
		
			session.setAttribute("socialDouble", false);
			session.setAttribute("usernick",result.get("given_name")); 	// 닉네임
			
		}
		
		//두번 이상 로그인
		else {
			session.setAttribute("socialDouble", true);
			int userno = userDao.selectSocialuserNo(result.get("given_name"));
			String usernick = userDao.selectUserNick(userno);
			session.setAttribute("usernick", usernick);
		}

		// 파싱 데이터로 세션 저장
		session.setAttribute("socialnick", result.get("given_name"));
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("username", result.get("name"));			// 이름
		session.setAttribute("socialType", "Google");
	}

	@Override
	public void insertGoogleSocial(User_table socialuser) {
		userDao.insertSocial(socialuser);
	}

	@Override
	public int getUserNo(String socialnick) {
		return userDao.selectuserNo(socialnick);
	}
}
