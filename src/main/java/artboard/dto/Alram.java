package artboard.dto;

public class Alram {
	
	private int alramno;
	private String alramcontents;
	private String alramtime;
	private int alramcheck;
	private int alramtype;
	private String alramsender;
	private int userno;
	private int boardno;
	private int replyno;
	private int likeno;
	private int donno;
	
	@Override
	public String toString() {
		return "Alram [alramno=" + alramno + ", alramcontents=" + alramcontents + ", alramtime=" + alramtime
				+ ", alramcheck=" + alramcheck + ", alramtype=" + alramtype + ", alramsender=" + alramsender
				+ ", userno=" + userno + ", boardno=" + boardno + ", replyno=" + replyno + ", likeno=" + likeno
				+ ", donno=" + donno + "]";
	}

	public int getAlramno() {
		return alramno;
	}

	public void setAlramno(int alramno) {
		this.alramno = alramno;
	}

	public String getAlramcontents() {
		return alramcontents;
	}

	public void setAlramcontents(String alramcontents) {
		this.alramcontents = alramcontents;
	}

	public String getAlramtime() {
		return alramtime;
	}

	public void setAlramtime(String alramtime) {
		this.alramtime = alramtime;
	}

	public int getAlramcheck() {
		return alramcheck;
	}

	public void setAlramcheck(int alramcheck) {
		this.alramcheck = alramcheck;
	}

	public int getAlramtype() {
		return alramtype;
	}

	public void setAlramtype(int alramtype) {
		this.alramtype = alramtype;
	}

	public String getAlramsender() {
		return alramsender;
	}

	public void setAlramsender(String alramsender) {
		this.alramsender = alramsender;
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

	public int getReplyno() {
		return replyno;
	}

	public void setReplyno(int replyno) {
		this.replyno = replyno;
	}

	public int getLikeno() {
		return likeno;
	}

	public void setLikeno(int likeno) {
		this.likeno = likeno;
	}

	public int getDonno() {
		return donno;
	}

	public void setDonno(int donno) {
		this.donno = donno;
	}	
	
}
