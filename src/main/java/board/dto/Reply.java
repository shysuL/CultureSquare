package board.dto;

public class Reply {
	private int rnum;
	
	private int replyno;
	private int groupno;
	private int replyorder;
	private int replydepth;
	private String recontents;
	private String replydate;
	private int userno;
	private int boardno;
	
	private String usernick;
	private int maxreplyorder;
	
	@Override
	public String toString() {
		return "Reply [rnum=" + rnum + ", replyno=" + replyno + ", groupno=" + groupno + ", replyorder=" + replyorder
				+ ", replydepth=" + replydepth + ", recontents=" + recontents + ", replydate=" + replydate + ", userno="
				+ userno + ", boardno=" + boardno + ", usernick=" + usernick + ", maxreplyorder=" + maxreplyorder + "]";
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getReplyno() {
		return replyno;
	}

	public void setReplyno(int replyno) {
		this.replyno = replyno;
	}

	public int getGroupno() {
		return groupno;
	}

	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}

	public int getReplyorder() {
		return replyorder;
	}

	public void setReplyorder(int replyorder) {
		this.replyorder = replyorder;
	}

	public int getReplydepth() {
		return replydepth;
	}

	public void setReplydepth(int replydepth) {
		this.replydepth = replydepth;
	}

	public String getRecontents() {
		return recontents;
	}

	public void setRecontents(String recontents) {
		this.recontents = recontents;
	}

	public String getReplydate() {
		return replydate;
	}

	public void setReplydate(String replydate) {
		this.replydate = replydate;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public int getBoardno() {
		return boardno;
	}

	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getUsernick() {
		return usernick;
	}

	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}

	public int getMaxreplyorder() {
		return maxreplyorder;
	}

	public void setMaxreplyorder(int maxreplyorder) {
		this.maxreplyorder = maxreplyorder;
	}

}
