package com.menu;

import java.sql.*;

public class MenuDTO {
	private int mIdx;
	private String mName;
	private int cateNum;
	private int price;
	private String state;
	private String img;
	
	public MenuDTO() {
		super();
	}

	public MenuDTO(String mName, int price, String img) {
		super();
		this.mName = mName;
		this.price = price;
		this.img = img;
	}	

	public MenuDTO(int mIdx, String mName, int price, String img) {
		super();
		this.mIdx = mIdx;
		this.mName = mName;
		this.price = price;
		this.img = img;
	}

	public MenuDTO(String mName, int cateNum, int price, String state) {
		super();
		this.mName = mName;
		this.cateNum = cateNum;
		this.price = price;
		this.state = state;
	}

	public MenuDTO(int mIdx, String mName, int cateNum, int price, String state, String img) {
		super();
		this.mIdx = mIdx;
		this.mName = mName;
		this.cateNum = cateNum;
		this.price = price;
		this.state = state;
		this.img = img;
	}

	public int getmIdx() {
		return mIdx;
	}

	public void setmIdx(int mIdx) {
		this.mIdx = mIdx;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public int getCateNum() {
		return cateNum;
	}

	public void setCateNum(int cateNum) {
		this.cateNum = cateNum;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	
	
	
}