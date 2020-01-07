package user.dto;

public class User_table {
	
	private int userno;
	private String userid;
	private String userpw;
	private String username;
	private String usernick;
	private String userphone;
	private String usergender;
	private int userbirth;
	private String interest;
	private int usertype;
	private int permit;
	private String emailcheck;
	private String originname;
	private String storedname;
	private int follow;
	private int prcnt;
	private int sociallogin;
	private int rnum;
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	@Override
	public String toString() {
		return "User_table [userno=" + userno + ", userid=" + userid + ", userpw=" + userpw + ", username=" + username
				+ ", usernick=" + usernick + ", userphone=" + userphone + ", usergender=" + usergender + ", userbirth="
				+ userbirth + ", interest=" + interest + ", usertype=" + usertype + ", permit=" + permit
				+ ", emailcheck=" + emailcheck + ", originname=" + originname + ", storedname=" + storedname
				+ ", follow=" + follow + ", prcnt=" + prcnt + ", sociallogin=" + sociallogin + ", rnum=" + rnum + "]";
	}
	public int getUserno() {
		return userno;
	}
	public void setUserno(int userno) {
		this.userno = userno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsernick() {
		return usernick;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public String getUserphone() {
		return userphone;
	}
	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}
	public String getUsergender() {
		return usergender;
	}
	public void setUsergender(String usergender) {
		this.usergender = usergender;
	}
	public int getUserbirth() {
		return userbirth;
	}
	public void setUserbirth(int userbirth) {
		this.userbirth = userbirth;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public int getUsertype() {
		return usertype;
	}
	public void setUsertype(int usertype) {
		this.usertype = usertype;
	}
	public int getPermit() {
		return permit;
	}
	public void setPermit(int permit) {
		this.permit = permit;
	}
	public String getEmailcheck() {
		return emailcheck;
	}
	public void setEmailcheck(String emailcheck) {
		this.emailcheck = emailcheck;
	}
	public String getOriginname() {
		return originname;
	}
	public void setOriginname(String originname) {
		this.originname = originname;
	}
	public String getStoredname() {
		return storedname;
	}
	public void setStoredname(String storedname) {
		this.storedname = storedname;
	}
	public int getFollow() {
		return follow;
	}
	public void setFollow(int follow) {
		this.follow = follow;
	}
	public int getPrcnt() {
		return prcnt;
	}
	public void setPrcnt(int prcnt) {
		this.prcnt = prcnt;
	}
	public int getSociallogin() {
		return sociallogin;
	}
	public void setSociallogin(int sociallogin) {
		this.sociallogin = sociallogin;
	}

	public void setInterest(String[] checkInterest) {
		
	}
	
	

	
	
	

}
