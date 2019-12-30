package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PwSha256 {

	public static String userPwEncSHA256(String pw) {
		
		StringBuffer sb = new StringBuffer();
		MessageDigest md;
		
		try {
			md = MessageDigest.getInstance("SHA-256");
			md.update(pw.getBytes());
			
			byte[] data = md.digest();
			for(int i=0; i < data.length; i ++) {
				byte tmpData = data[i];
				String EncPw = Integer.toString((tmpData & 0xff) + 0x100, 16).substring(1);
				sb.append(EncPw);
				
			}
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return sb.toString();
			
	}
	
}
