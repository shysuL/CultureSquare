package admin.dto;

public class Admin {
	
	private int adminno;
	private String adminid;
	private String adminpw;
	
	@Override
	public String toString() {
		return "Admin [adminno=" + adminno + ", adminid=" + adminid + ", adminpw=" + adminpw + "]";
	}

	public int getAdminno() {
		return adminno;
	}

	public void setAdminno(int adminno) {
		this.adminno = adminno;
	}

	public String getAdminid() {
		return adminid;
	}

	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}

	public String getAdminpw() {
		return adminpw;
	}

	public void setAdminpw(String adminpw) {
		this.adminpw = adminpw;
	}
	
	
	

}
