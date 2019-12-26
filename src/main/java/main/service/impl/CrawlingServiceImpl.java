package main.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import main.dto.Culture;
import main.service.face.CrawlingService;

@Service
public class CrawlingServiceImpl implements CrawlingService{

	@Override
	public List<Culture> getList(Culture culture) {
		
		// Jsoup를 이용해서 http://www.cgv.co.kr/movies/ 크롤링
			String url = "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EA%B3%B5%EC%97%B0"; //크롤링할 url지정
			Document doc = null;        //Document에는 페이지의 전체 소스가 저장된다

			try {
				doc = Jsoup.connect(url)
			            .userAgent("Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36")
			            .header("scheme", "https")
			            .header("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
			            .header("accept-encoding", "gzip, deflate, br")
			            .header("accept-language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,es;q=0.6")
			            .header("cache-control", "no-cache")
			            .header("pragma", "no-cache")
			            .header("upgrade-insecure-requests", "1")
			            .get();

			} catch (IOException e) {
				e.printStackTrace();
			}
			
			//select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
			Elements element = doc.select("div.list_area");    


			List<Culture> list = new ArrayList<Culture>();
			for(Element el : element.select("li")) {
				Culture culture1 = new Culture();
				culture1.setCul(el.toString());
				System.out.println(culture1);
				list.add(culture1);
				
			}
				
		
		return list;
	}

}
