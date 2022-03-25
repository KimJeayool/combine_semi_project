package com.member;

public class MemberDTO{
	private int aIdx;
	private String aId;
	private String aPwd;
	private String name;
	private String lev;
	
	public MemberDTO() {
		// TODO Auto-generated constructor stub
	}

	public MemberDTO(int aIdx, String name, String lev) {
		super();
		this.aIdx = aIdx;
		this.name = name;
		this.lev = lev;
	}

	public MemberDTO(int aIdx, String aId, String aPwd, String name, String lev) {
		super();
		this.aIdx = aIdx;
		this.aId = aId;
		this.aPwd = aPwd;
		this.name = name;
		this.lev = lev;
	}

	public int getaIdx() {
		return aIdx;
	}

	public void setaIdx(int aIdx) {
		this.aIdx = aIdx;
	}

	public String getaId() {
		return aId;
	}

	public void setaId(String aId) {
		this.aId = aId;
	}

	public String getaPwd() {
		return aPwd;
	}

	public void setaPwd(String aPwd) {
		this.aPwd = aPwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLev() {
		return lev;
	}

	public void setLev(String lev) {
		this.lev = lev;
	}
	

	
	
}