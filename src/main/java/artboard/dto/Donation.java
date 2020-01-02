package artboard.dto;

public class Donation {

	private int donno;
	private int donprice;
	private int userno;
	private int boardno;
	
	private String usernick;

	@Override
	public String toString() {
		return "Donation [donno=" + donno + ", donprice=" + donprice + ", userno=" + userno + ", boardno=" + boardno
				+ ", usernick=" + usernick + "]";
	}

	public int getDonno() {
		return donno;
	}

	public void setDonno(int donno) {
		this.donno = donno;
	}

	public int getDonprice() {
		return donprice;
	}

	public void setDonprice(int donprice) {
		this.donprice = donprice;
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
