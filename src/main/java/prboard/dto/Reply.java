package prboard.dto;

public class Reply {
	private int replyno;
	private int groupno;
	private int replyorder;
	private int replydepth;
	private String recontents;
	private String replydate;
	private int userno;
	private int boardno;
	
	private String usernick;

	@Override
	public String toString() {
		return "Reply [replyno=" + replyno + ", groupno=" + groupno + ", replyorder=" + replyorder + ", replydepth="
				+ replydepth + ", recontents=" + recontents + ", replydate=" + replydate + ", userno=" + userno
				+ ", boardno=" + boardno + ", usernick=" + usernick + "]";
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
}
