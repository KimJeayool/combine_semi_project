package com.guest;

import java.sql.*;

public class GuestDTO {
	
	private int gIdx;
	private int tNum;
	private Timestamp inDate;
	private Timestamp outDate;
	private int total;
	private String pay;
	
	public GuestDTO() {
		
	}

	public GuestDTO(int gIdx, int tNum, Timestamp inDate, Timestamp outDate, int total, String pay) {
		super();
		this.gIdx = gIdx;
		this.tNum = tNum;
		this.inDate = inDate;
		this.outDate = outDate;
		this.total = total;
		this.pay = pay;
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

	public Timestamp getInDate() {
		return inDate;
	}

	public void setInDate(Timestamp inDate) {
		this.inDate = inDate;
	}

	public Timestamp getOutDate() {
		return outDate;
	}

	public void setOutDate(Timestamp outDate) {
		this.outDate = outDate;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
	}

}