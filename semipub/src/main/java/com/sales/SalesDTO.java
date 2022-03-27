package com.sales;

import java.sql.Date;
import java.sql.Timestamp;

public class SalesDTO {

	private int payIdx;
	private int tNum;
	private int total;
	private int gIdx;
	private Timestamp payDate;
	private String name;
	private String mName;
	private int price;
	private int count;
	
	private String startdate;
	private String enddate;

	public SalesDTO() {
		super();
	}

	public SalesDTO(int payIdx, int tNum, int total, Timestamp payDate, String name, int gIdx) {
		super();
		this.payIdx = payIdx;
		this.tNum = tNum;
		this.total = total;
		this.payDate = payDate;
		this.name = name;
		this.gIdx = gIdx;
	}
	
	public SalesDTO(String mName, int price, int count, Timestamp payDate, String name) {
		super();
		this.mName = mName;
		this.price = price;
		this.count = count;
		this.payDate = payDate;
		this.name = name;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
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

	public Timestamp getPayDate() {
		return payDate;
	}

	public void setPayDate(Timestamp payDate) {
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