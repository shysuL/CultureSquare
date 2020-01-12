package main.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import main.service.face.WeatherService;

@Service
public class WeatherServiceImpl implements WeatherService{

	  String SERVICEKEY = "ZvKByoGsEZqnLjKlaKIIIyihjep6H%2B%2Fq4FZIweedxIT7K4vDFxHAUzJV2IR59I98fPr0OqfLuM%2FbhyZEP%2FIyzQ%3D%3D";
	
	@Override
	public String getDate() {
        
        SimpleDateFormat todayDate = new SimpleDateFormat ( "yyyyMMdd");
        Date time = new Date();
        		
        String today = todayDate.format(time);
        		
        

        return today;
	}
	


	@Override
	public String getYesterDate() {
		Calendar c1 = new GregorianCalendar();

		c1.add(Calendar.DATE, -1); // 오늘날짜로부터 -1

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // 날짜 포맷 

		String today = sdf.format(c1.getTime()); // String으로 저장
		
        

        return today;
	}
	

	@Override
	public List getWeather() throws IOException, ParseException {

		String apiUrl = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData";
		// 홈페이지에서 받은 키
		String serviceKey = SERVICEKEY;
		String nx = "60";	//위도
		String ny = "127";	//경도
		String baseDate = getYesterDate();	//조회하고싶은 날짜
		String baseTime = "2300";	//조회하고싶은 시간 -> 5시에 발표
		String type = "json";	//타입 xml, json 등등 ..
		String numOfRows = "153";	//한 페이지 결과 수 
		String today = getDate();
		
		ArrayList<HashMap> list = new ArrayList<HashMap>();
		
		
	//전날 23시 부터 153개의 데이터를 조회하면 오늘과 내일의 날씨를 알 수 있음
		
		
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey);
		urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx, "UTF-8")); //경도
		urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny, "UTF-8")); //위도
		urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /* 조회하고싶은 날짜*/
		urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(baseTime, "UTF-8")); /* 조회하고싶은 시간 AM 02시부터 3시간 단위 */
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode(type, "UTF-8"));	/* 타입 */
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));	/* 한 페이지 결과 수 */
       
		/*
		 * GET방식으로 전송해서 파라미터 받아오기
		 */
		URL url = new URL(urlBuilder.toString());
		//어떻게 넘어가는지 확인하고 싶으면 아래 출력분 주석 해제
		//System.out.println(url);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		String result= sb.toString();
        

		// Json parser를 만들어 만들어진 문자열 데이터를 객체화 
		JSONParser parser = new JSONParser(); 
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(result);
		} catch (org.json.simple.parser.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		// response 키를 가지고 데이터를 파싱 
		JSONObject parse_response = (JSONObject) obj.get("response"); 
		// response 로 부터 body 찾기
		JSONObject parse_body = (JSONObject) parse_response.get("body"); 
		// body 로 부터 items 찾기 
		JSONObject parse_items = (JSONObject) parse_body.get("items");

		// items로 부터 itemlist 를 받기 
		JSONArray parse_item = (JSONArray) parse_items.get("item");
		String category;
		JSONObject weather; // parse_item은 배열형태이기 때문에 하나씩 데이터를 하나씩 가져올때 사용
		// 카테고리와 값만 받아오기
		String day="";
		String time="";
		for(int i = 0 ; i < parse_item.size(); i++) {
			
			
		    HashMap hm = new HashMap();
		    
			weather = (JSONObject) parse_item.get(i);
			Object fcstValue = weather.get("fcstValue");
			Object fcstDate = weather.get("fcstDate");
			Object fcstTime = weather.get("fcstTime");
			//double형으로 받고싶으면 아래내용 주석 해제
			//double fcstValue = Double.parseDouble(weather.get("fcstValue").toString());
			category = (String)weather.get("category"); 
			// 출력
			if(!day.equals(fcstDate.toString())) {
				day=fcstDate.toString();
			}
			if(!time.equals(fcstTime.toString())) {
				time=fcstTime.toString();
				if(today.equals(day)) {
				}
			}
			
			if(today.equals(day)) {
				
				 if(category.equals("T3H")) {
					 hm.put("date", today);
					 hm.put("time", time);
					 hm.put("T3H", fcstValue);
					 list.add(hm);
				 }
				 if(category.equals("SKY")) {
					 hm.put("date", today);
					 hm.put("time", time);
					 hm.put("SKY", fcstValue);
					 list.add(hm);
				 }
				
			}
		}
		
		
//		for(int i = 0; i <list.size(); i++) {
//				System.out.println("띠용 :" + list.get(i));
//				
//		}

		/*
		 * 항목값	항목명	단위
		 * POP	강수확률	 %
		 * PTY	강수형태	코드값
		 * R06	6시간 강수량	범주 (1 mm)
		 * REH	습도	 %
		 * S06	6시간 신적설	범주(1 cm)
		 * SKY	하늘상태	코드값
		 * T3H	3시간 기온	 ℃
		 * TMN	아침 최저기온	 ℃
		 * TMX	낮 최고기온	 ℃
		 * UUU	풍속(동서성분)	 m/s
		 * VVV	풍속(남북성분)	 m/s
		 * WAV	파고	 M
		 * VEC	풍향	 m/s
		 * WSD	풍속	1

		 */
		
		return list;
	        
	}
}
