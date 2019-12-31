package user.service.impl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import user.dao.face.UserDao;
import user.dto.User_table;
import user.service.face.KakaoService;

@Service
public class KakaoServiceImpl implements KakaoService {

	@Autowired private UserDao userDao;
	
	private final static String K_CLIENT_ID = "1706cb5961fc63d24361912b1ff7e489";
	private final static String K_REDIRECT_URI = "https://localhost:8443/kakaocallback";

	@Override
	public String getAuthorizationUrl(HttpSession session) {
		String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?"
				+ "client_id=" + K_CLIENT_ID + "&redirect_uri="
				+ K_REDIRECT_URI + "&response_type=code";
		return kakaoUrl;
	}

	@Override
	public JsonNode getAccessToken(String autorize_code) {
		final String RequestUrl = "https://kauth.kakao.com/oauth/token";
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
		postParams.add(new BasicNameValuePair("client_id", K_CLIENT_ID)); // REST API KEY
		postParams.add(new BasicNameValuePair("redirect_uri", K_REDIRECT_URI)); // 리다이렉트 URI
		postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정 중 얻은 code 값

		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);
		JsonNode returnNode = null;

		try {

			post.setEntity(new UrlEncodedFormEntity(postParams));
			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			// JSON 형태 반환값 처리

			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();

		} catch (ClientProtocolException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		} finally {
			// clear resources
		}
		return returnNode;
	}

	@Override
	public JsonNode getKakaoUserInfo(JsonNode accessToken) {
		final String RequestUrl = "https://kapi.kakao.com/v1/user/me";
		//String CLIENT_ID = K_CLIENT_ID; // REST API KEY
		//String REDIRECT_URI = K_REDIRECT_URI; // 리다이렉트 URI
		//String code = autorize_code; // 로그인 과정중 얻은 토큰 값
		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);
		// add header
		post.addHeader("Authorization", "Bearer " + accessToken);

		JsonNode returnNode = null;

		try {

			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			// JSON 형태 반환값 처리
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());
		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();
		} catch (ClientProtocolException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		} finally {

			// clear resources
		}
		return returnNode;
	}

	@Override
	public JsonNode Logout(String autorize_code) {
		final String RequestUrl = "https://kapi.kakao.com/v1/user/logout";

		final HttpClient client = HttpClientBuilder.create().build();

		final HttpPost post = new HttpPost(RequestUrl);

		post.addHeader("Authorization", "Bearer " + autorize_code);

		JsonNode returnNode = null;

		try {

			final HttpResponse response = client.execute(post);

			ObjectMapper mapper = new ObjectMapper();

			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();

		} catch (ClientProtocolException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		} finally {

		}

		return returnNode;
	}

	@Override
	public int getSocialAccountCnt(User_table user) {
		
		return userDao.selectSocialCnt(user);
	}

	@Override
	public void insertKakaoInfo(User_table user) {

		userDao.insertKakaoLoginInfo(user);
	}

	@Override
	public void setKakaoLogin(String code, HttpSession session) {

		String kname = null;
		
		//결과값을 node에 담음
		JsonNode node = getAccessToken(code);
		//accessToken에 로그인한 사용자의 정보 저장
		JsonNode accessToken = node.get("access_token");


		//사용자의 정보
		JsonNode userInfo = getKakaoUserInfo(accessToken);

		//유저 정보를 카카오 API에서 가져오기
		JsonNode properties = userInfo.path("properties");
		
//		String email = userInfo.get("kaccount_email").toString();

		kname = properties.path("nickname").asText();
		
		//파싱 닉네임 세션으로 저장
		session.setAttribute("username",kname); 		//이름 	 동일
		session.setAttribute("socialnick", kname);
		session.setAttribute("login", true); 		// 로그인 상태 true
		session.setAttribute("socialType", "Kakao");
		session.setAttribute("token", accessToken);
//		session.setAttribute("userid", email);
		
		//유저 DTO에 소셜 로그인 정보 저장
		User_table user = new User_table();
		user.setUsernick(kname);
		user.setUsername(kname);
//		user.setUserid(email);
		
//		소셜 로그인 정보 존재 유무 검사
		int socialCnt = getSocialAccountCnt(user);
		
		
		//소셜로그인 정보가 회원정보에 담겨 있지 않으면 처음 로그인
		if(socialCnt == 0) {
			session.setAttribute("socialDouble", false);
			session.setAttribute("usernick",kname); 	// 닉네임
		}
		else {
			session.setAttribute("socialDouble", true);
			int userno = userDao.selectSocialuserNo(kname);
			String usernick = userDao.selectUserNick(userno);
			session.setAttribute("usernick", usernick);
		}

	}
	
	@Override
	public void insertKakaoSocial(User_table socialuser) {
		userDao.insertSocial(socialuser);
	}

	@Override
	public int getUserNo(String socialnick) {
		return userDao.selectuserNo(socialnick);
	}
}