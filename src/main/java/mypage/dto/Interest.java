package mypage.dto;

public class Interest {
	private String interest;
	private boolean check;

	public String getInterest() {
		return interest;
	}

	public void setInterest(String interest) {
		this.interest = interest;
	}

	public boolean isCheck() {
		return check;
	}

	public void setCheck(boolean check) {
		this.check = check;
	}

	@Override
	public String toString() {
		return "Interest [interest=" + interest + ", check=" + check + "]";
	}
}
