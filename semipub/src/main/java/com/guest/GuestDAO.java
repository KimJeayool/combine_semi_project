package com.guest;

import java.util.*;
import java.sql.*;

public class GuestDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public GuestDAO() {
		
	}
	
	/**GET Not Pay guest*/
	public ArrayList<GuestDTO> getGuest(int startIdx, int endIdx){
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT * FROM guest "
					+ "WHERE pay='미결제' AND tnum>=? AND tnum<=? "
					+ "ORDER BY tnum ASC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startIdx);
			ps.setInt(2, endIdx);
			rs = ps.executeQuery();
			
			ArrayList<GuestDTO> arr = new ArrayList<GuestDTO>();
			while(rs.next()) {
				int gIdx = rs.getInt("gidx");
				int tNum = rs.getInt("tnum");
				java.sql.Timestamp inDate = rs.getTimestamp("indate");
				java.sql.Timestamp outDate = rs.getTimestamp("outdate");
				int total = rs.getInt("total");
				String pay = rs.getString("pay");
				
				GuestDTO dto = new GuestDTO(gIdx, tNum, inDate, outDate, total, pay);
				arr.add(dto);
			}
			return arr;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	/**Change Guest Sate to Payed*/
	public int changeGuestState(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE guest SET pay='결제' WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			
			int result = ps.executeUpdate();
			return result;
					
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
	}

	/**SET Guest*/
	public int userIndate(int tNum) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="insert into GUEST values(GUEST_idx.nextval,?,sysdate,sysdate,0,'미결제')";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tNum);
			int count=ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
		
	}
	
}