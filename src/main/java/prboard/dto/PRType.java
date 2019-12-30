package prboard.dto;

public class PRType {

	private int prno;
	private String prname;
	private int boardno;
	@Override
	public String toString() {
		return "PRType [prno=" + prno + ", prname=" + prname + ", boardno=" + boardno + "]";
	}
	public int getPrno() {
		return prno;
	}
	public void setPrno(int prno) {
		this.prno = prno;
	}
	public String getPrname() {
		return prname;
	}
	public void setPrname(String prname) {
		this.prname = prname;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
}
