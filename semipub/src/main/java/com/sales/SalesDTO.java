package com.sales;

import java.sql.Date;

public class SalesDTO {

	private int payIdx;
	private int tNum;
	private int total;
	private int gIdx;
	private Date payDate;
	private String name;
	
	private String startdate;
	private String enddate;

	public SalesDTO() {
		super();
	}

	public SalesDTO(int payIdx, int tNum, int total, Date payDate, String name) {
		super();
		this.payIdx = payIdx;
		this.tNum = tNum;
		this.total = total;
		this.payDate = payDate;
		this.name = name;
	}

	public int getgIdx() {
		return gIdx;
	}

	public void setgIdx(int gIdx) {
		this.gIdx = gIdx;
	}

	public int getPayIdx() {
		return payIdx;
	}

	public void setPayIdx(int payIdx) {
		this.payIdx = payIdx;
	}

	public int gettNum() {
		return tNum;
	}

	public void settNum(int tNum) {
		this.tNum = tNum;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	
	
}