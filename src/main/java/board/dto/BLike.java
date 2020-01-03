package board.dto;

public class BLike {
	private int likeno;
	private int userno;
	private int boardno;
	@Override
	public String toString() {
		return "BLike [likeno=" + likeno + ", userno=" + userno + ", boardno=" + boardno + "]";
	}
	public int getLikeno() {
		return likeno;
	}
	public void setLikeno(int likeno) {
		this.likeno = likeno;
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
