package com.match;

public class MatchDTO {
	
	private int gIdx;
	private int tNum;
	private String nickName;
	private int male;
	private int female;
	private String msg;
	private int matchNum;
	private String matchStatus;
	
	
	public MatchDTO() {
		super();
	}

	public MatchDTO(int gIdx, int tNum, String nickName, int male, int female, String msg, int matchNum,
			String matchStatus) {
		super();
		this.gIdx = gIdx;
		this.tNum = tNum;
		this.nickName = nickName;
		this.male = male;
		this.female = female;
		this.msg = msg;
		this.matchNum = matchNum;
		this.matchStatus = matchStatus;
	}

	public int getgIdx() {
		return gIdx;
	}

	public void setgIdx(int gIdx) {
		this.gIdx = gIdx;
	}

	public int gettNum() {
		return tNum;
	}

	public void settNum(int tNum) {
		this.tNum = tNum;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getMale() {
		return male;
	}

	public void setMale(int male) {
		this.male = male;
	}

	public int getFemale() {
		return female;
	}

	public void setFemale(int female) {
		this.female = female;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getMatchNum() {
		return matchNum;
	}

	public void setMatchNum(int matchNum) {
		this.matchNum = matchNum;
	}

	public String getMatchStatus() {
		return matchStatus;
	}

	public void setMatchStatus(String matchStatus) {
		this.matchStatus = matchStatus;
	}

}
