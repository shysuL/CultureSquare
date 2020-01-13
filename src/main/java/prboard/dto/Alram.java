package prboard.dto;

public class Alram {
	
	private int alramno;
	private String alramcontents;
	private String alramtime;
	private int alramcheck;
	private int alramtype;
	private String alramsender;
	private int userno;
	private int boardno;
	
	@Override
	public String toString() {
		return "Alram [alramno=" + alramno + ", alramcontents=" + alramcontents + ", alramtime=" + alramtime
				+ ", alramcheck=" + alramcheck + ", alramtype=" + alramtype + ", alramsender=" + alramsender
				+ ", userno=" + userno + ", boardno=" + boardno + "]";
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

}
