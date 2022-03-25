package com.pay;

import java.sql.*;

public class PayDTO {
	
	private int payIdx;
	private int gIdx;
	private int payType;
	private int price;
	private Timestamp payDate;
	private int aIdx;
	private String name;
	private String aId;
	
	public PayDTO() {
		super();
	}
	
	
	/*INPUT Method*/
	public PayDTO(int payIdx, int gIdx, int payType, int price, Timestamp payDate, int aIdx) {
		super();
		this.payIdx = payIdx;
		this.gIdx = gIdx;
		this.payType = payType;
		this.price = price;
		this.payDate = payDate;
		this.aIdx = aIdx;
	}

	public PayDTO(int payIdx, int gIdx, int payType, int price, Timestamp payDate) {
		super();
		this.payIdx = payIdx;
		this.gIdx = gIdx;
		this.payType = payType;
		this.price = price;
		this.payDate = payDate;
	}

	public int getPayIdx() {
		return payIdx;
	}


	public void setPayIdx(int payIdx) {
		this.payIdx = payIdx;
	}


	public int getgIdx() {
		return gIdx;
	}


	public void setgIdx(int gIdx) {
		this.gIdx = gIdx;
	}


	public int getPayType() {
		return payType;
	}


	public void setPayType(int payType) {
		this.payType = payType;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public Timestamp getPayDate() {
		return payDate;
	}


	public void setPayDate(Timestamp payDate) {
		this.payDate = payDate;
	}


	public String getaId() {
		return aId;
	}


	public void setaId(String aId) {
		this.aId = aId;
	}

	public int getaIdx() {
		return aIdx;
	}

	public void setaIdx(int aIdx) {
		this.aIdx = aIdx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	

}