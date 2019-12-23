package user.service.face;

import javax.servlet.http.HttpSession;

public interface NaverService {
	/**
	 * 2019-12-23
	 * 조홍철
	 * 
	 * apiResult 결과값을 셋팅한다.
	 * 
	 * @param apiResult -  셋팅할 apiResult
	 * @param session -  셋팅할 세션
	 * @return String - 셋팅한 결과 apiResult
	 */
	public String setApiResult(String apiResult, HttpSession session);
}
