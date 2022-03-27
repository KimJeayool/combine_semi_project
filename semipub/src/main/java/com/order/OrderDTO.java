package com.order;
import java.sql.*;

public class OrderDTO {
	
	private int oIdx;
	private int tNum;
	private String mName;
	private int count;
	private Timestamp orderDate;
	private String stName;
	private int stNum;
	private int gIdx;
	private int mIdx;
	private int price;
	private Timestamp outDate;
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public OrderDTO(int count, Timestamp orderDate, int gIdx, int mIdx) {
		super();
		this.count = count;
		this.orderDate = orderDate;
		this.gIdx = gIdx;
		this.mIdx = mIdx;
	}


	public OrderDTO(int oIdx, int tNum, String mName, int count, Timestamp orderDate, String stName) {
		super();
		this.oIdx = oIdx;
		this.tNum = tNum;
		this.mName = mName;
		this.count = count;
		this.orderDate = orderDate;
		this.stName = stName;
	}


	public OrderDTO(int oIdx, int tNum, String mName, int count, Timestamp orderDate, String stName, int stNum) {
		super();
		this.oIdx = oIdx;
		this.tNum = tNum;
		this.mName = mName;
		this.count = count;
		this.orderDate = orderDate;
		this.stName = stName;
	}
	
	
	public OrderDTO(int oIdx, int tNum, String mName, int count, Timestamp orderDate, String stName, int gIdx,
			int price) {
		super();
		this.oIdx = oIdx;
		this.tNum = tNum;
		this.mName = mName;
		this.count = count;
		this.orderDate = orderDate;
		this.stName = stName;
		this.gIdx = gIdx;
		this.price = price;
	}

	public OrderDTO(int oIdx, String mName, int count, Timestamp orderDate, String stName, int price) {
		super();
		this.oIdx = oIdx;
		this.mName = mName;
		this.count = count;
		this.orderDate = orderDate;
		this.stName = stName;
		this.price = price;
	}
	

	
	
	public OrderDTO(int oIdx, int gIdx, int tNum, String mName, int price, int count, Timestamp orderDate,
			String stName) {
		super();
		this.oIdx = oIdx;
		this.gIdx = gIdx;
		this.tNum = tNum;
		this.mName = mName;
		this.price = price;
		this.count = count;
		this.orderDate = orderDate;
		this.stName = stName;
	}
	
	public OrderDTO(int oIdx, int gIdx, int tNum, String mName, int price, int count, Timestamp orderDate,
			String stName, Timestamp outDate, int stNum, int mIdx) {
		super();
		this.oIdx = oIdx;
		this.gIdx = gIdx;
		this.tNum = tNum;
		this.mName = mName;
		this.price = price;
		this.count = count;
		this.orderDate = orderDate;
		this.stName = stName;
		this.outDate = outDate;
		this.stNum = stNum;
		this.mIdx = mIdx;
		
		
	}


	public int getoIdx() {
		return oIdx;
	}

	public void setoIdx(int oIdx) {
		this.oIdx = oIdx;
	}

	public int gettNum() {
		return tNum;
	}

	public void settNum(int tNum) {
		this.tNum = tNum;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public String getStName() {
		return stName;
	}

	public void setStName(String stName) {
		this.stName = stName;
	}

	public int getStNum() {
		return stNum;
	}

	public void setStNum(int stNum) {
		this.stNum = stNum;
	}

	public int getgIdx() {
		return gIdx;
	}

	public void setgIdx(int gIdx) {
		this.gIdx = gIdx;
	}

	public int getmIdx() {
		return mIdx;
	}

	public void setmIdx(int mIdx) {
		this.mIdx = mIdx;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Timestamp getOutDate() {
		return outDate;
	}

	public void setOutDate(Timestamp outDate) {
		this.outDate = outDate;
	}

	
	
}