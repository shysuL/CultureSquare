package prboard.dto;

import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class PRBoard {
	private int boardno;
	private String title;
	private String writtendate;
	private String content;
	private int views;
	private int userno;
	private int postno;
	private String prname;
	@Override
	public String toString() {
		return "PRBoard [boardno=" + boardno + ", title=" + title + ", writtendate=" + writtendate + ", content="
				+ content + ", views=" + views + ", userno=" + userno + ", postno=" + postno + ", prname=" + prname
				+ "]";
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
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
	public String getPrname() {
		return prname;
	}
	public void setPrname(String prname) {
		this.prname = prname;
	}
	
	
}
