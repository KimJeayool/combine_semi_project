package com.table;

public class TableDTO {
	
	private int tNum;
	private String tId;
	private String tPwd;
	
	public TableDTO() {
		
	}

	public TableDTO(int tNum, String tId, String tPwd) {
		super();
		this.tNum = tNum;
		this.tId = tId;
		this.tPwd = tPwd;
	}

	public int gettNum() {
		return tNum;
	}

	public void settNum(int tNum) {
		this.tNum = tNum;
	}

	public String gettId() {
		return tId;
	}

	public void settId(String tId) {
		this.tId = tId;
	}

	public String gettPwd() {
		return tPwd;
	}

	public void settPwd(String tPwd) {
		this.tPwd = tPwd;
	}
	
}