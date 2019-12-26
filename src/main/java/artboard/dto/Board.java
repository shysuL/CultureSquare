package artboard.dto;


public class Board {
	private int boardno;
	private String title;
	private String writtendate;
	private String contents;
	private String views;
	private int userno;
	private int postno;
	
	
	private int performno;
	private String performname;
	private String performdate;
	private int writepermit;
	private int updatepermit;
	private int deletepermit;
	

	
	@Override
	public String toString() {
		return "Board [boardno=" + boardno + ", title=" + title + ", writtendate=" + writtendate + ", contents="
				+ contents + ", views=" + views + ", userno=" + userno + ", postno=" + postno + ", performno="
				+ performno + ", performname=" + performname + ", performdate=" + performdate + ", writepermit="
				+ writepermit + ", updatepermit=" + updatepermit + ", deletepermit=" + deletepermit + "]";
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

	
	public int getWritepermit() {
		return writepermit;
	}

	public String getPerformdate() {
		return performdate;
	}


	public void setPerformdate(String performdate) {
		this.performdate = performdate;
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
