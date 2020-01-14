package artboard.dto;

public class Board {

	// 마이페이지 게시글 번호
	private int rnum;

	// Board
	private int boardno;
	private String title;
	private String writtendate;
	private String contents;
	private String views;
	private int userno;
	private int postno;
	
	// location
	private String lat;
	private String lon;
	
	
	//Perform_add
	private int performno;
	private String performname;
	private String performdate;
	private int writepermit;
	private int updatepermit;
	private int deletepermit;

	private String performday;

	// User_table
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

	// BLike
	private int blike;

	// replyCnt
	private int replyCnt;
	
	// follow
	private int followno;
	private String sender;

	private String searchMonth;
	
	@Override
	public String toString() {
		return "Board [rnum=" + rnum + ", boardno=" + boardno + ", title=" + title + ", writtendate=" + writtendate
				+ ", contents=" + contents + ", views=" + views + ", userno=" + userno + ", postno=" + postno + ", lat="
				+ lat + ", lon=" + lon + ", performno=" + performno + ", performname=" + performname + ", performdate="
				+ performdate + ", writepermit=" + writepermit + ", updatepermit=" + updatepermit + ", deletepermit="
				+ deletepermit + ", performday=" + performday + ", userid=" + userid + ", userpw=" + userpw
				+ ", username=" + username + ", usernick=" + usernick + ", userphone=" + userphone + ", usergender="
				+ usergender + ", userbirth=" + userbirth + ", interest=" + interest + ", usertype=" + usertype
				+ ", permit=" + permit + ", emailcheck=" + emailcheck + ", originname=" + originname + ", storedname="
				+ storedname + ", follow=" + follow + ", prcnt=" + prcnt + ", sociallogin=" + sociallogin + ", blike="
				+ blike + ", replyCnt=" + replyCnt + ", followno=" + followno + ", sender=" + sender + ", searchMonth="
				+ searchMonth + "]";
	}



	public int getFollowno() {
		return followno;
	}



	public void setFollowno(int followno) {
		this.followno = followno;
	}



	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getBoardno() {
		return boardno;
	}

	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWrittendate() {
		return writtendate;
	}

	public void setWrittendate(String writtendate) {
		this.writtendate = writtendate;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getViews() {
		return views;
	}

	public void setViews(String views) {
		this.views = views;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public int getPostno() {
		return postno;
	}

	public void setPostno(int postno) {
		this.postno = postno;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public int getPerformno() {
		return performno;
	}

	public void setPerformno(int performno) {
		this.performno = performno;
	}

	public String getPerformname() {
		return performname;
	}

	public void setPerformname(String performname) {
		this.performname = performname;
	}

	public String getPerformdate() {
		return performdate;
	}

	public void setPerformdate(String performdate) {
		this.performdate = performdate;
	}

	public int getWritepermit() {
		return writepermit;
	}

	public void setWritepermit(int writepermit) {
		this.writepermit = writepermit;
	}

	public int getUpdatepermit() {
		return updatepermit;
	}

	public void setUpdatepermit(int updatepermit) {
		this.updatepermit = updatepermit;
	}

	public int getDeletepermit() {
		return deletepermit;
	}

	public void setDeletepermit(int deletepermit) {
		this.deletepermit = deletepermit;
	}

	public String getPerformday() {
		return performday;
	}

	public void setPerformday(String performday) {
		this.performday = performday;
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

	public int getBlike() {
		return blike;
	}

	public void setBlike(int blike) {
		this.blike = blike;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	public String getSearchMonth() {
		return searchMonth;
	}

	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}
	
	
}
