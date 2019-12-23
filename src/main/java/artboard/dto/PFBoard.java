package artboard.dto;

public class PFBoard {
	private int boardno;
	private String title;
	private String writtendate;
	private String contents;
	private String views;
	private int userno;
	private int postno;
	
	
	
	
	
	
	
	
	@Override
	public String toString() {
		return "PFBoard [boardno=" + boardno + ", title=" + title + ", writtendate=" + writtendate + ", contents="
				+ contents + ", views=" + views + ", userno=" + userno + ", postno=" + postno + "]";
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
	
	
	
	

}
