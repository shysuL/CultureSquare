package main.dto;

public class Weather {
	private String date;
	private String humidity;
	private String sky;
	private String time;
	private String rainPercentage;
	private String rainCode;
	@Override
	public String toString() {
		return "Weather [date=" + date + ", humidity=" + humidity + ", sky=" + sky + ", time=" + time
				+ ", rainPercentage=" + rainPercentage + ", rainCode=" + rainCode + "]";
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHumidity() {
		return humidity;
	}
	public void setHumidity(String humidity) {
		this.humidity = humidity;
	}
	public String getSky() {
		return sky;
	}
	public void setSky(String sky) {
		this.sky = sky;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getRainPercentage() {
		return rainPercentage;
	}
	public void setRainPercentage(String rainPercentage) {
		this.rainPercentage = rainPercentage;
	}
	public String getRainCode() {
		return rainCode;
	}
	public void setRainCode(String rainCode) {
		this.rainCode = rainCode;
	}
}
