package main.service.face;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;


public interface WeatherService {
	
	    int[][] REGION = {{60,127},{60,120},{73,134},{69,107},{51,67},{89,90},{98,76},{52,38}};
	    String[] LOCATION = {"서울특별시", "경기도","강원도","충청북도","전라남도","대구광역시", "부산광역시", "제주특별자치도"};
	   
	   /**
	    * 2020-01-12
	    * 조홍철
	    * 
	    * 현재 날짜를 구한다
	    * 
	    * @return String - 현재 날짜
	    */
	   public String getDate();
	   
	   /**
	    * 2020-01-12
	    * 조홍철
	    * 
	    * 어제 날짜를 구한다
	    * 
	    * @return String - 어제날짜
	    */
	   public String getYesterDate();
	   
	   /**
	    * 2020-01-12
	    * 조홍철
	    *  
	    *  날씨 정보를 조회한다
	    */
	   public List getWeather() throws IOException, ParseException;
}
