package user.service.face;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

@Service
public interface JoinSendMailService {
	
	public void mailSendWithUserKey(String userid, String username, HttpServletRequest req);

	
}
