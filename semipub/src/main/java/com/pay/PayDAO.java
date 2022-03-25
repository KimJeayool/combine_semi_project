package com.pay;

import java.util.*;
import java.sql.*;

public class PayDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	
	/**GET Count Pay List By gIdx*/
	public int getPayCount(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT COUNT(*) FROM paylist WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			rs = ps.executeQuery();
			
			int count = 0;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			return count;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
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
	
	
	
	/**INPUT Guest Pay Method*/
	public int inputPay(PayDTO dto) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "INSERT INTO paylist VALUES(paylist_idx.nextval,?,?,?,sysdate,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getgIdx());
			ps.setInt(2, dto.getPayType());
			ps.setInt(3, dto.getPrice());
			ps.setInt(4, dto.getaIdx());
			int result = ps.executeUpdate();
			
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			
		}
		
	}
	
	
	/**GET Total Guest payed*/
	public int getPayed(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT SUM(price) FROM paylist WHERE gidx=? AND paytype!=3";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			rs = ps.executeQuery();
			
			int payed = 0;
			if(rs.next()) {
				payed = rs.getInt(1);
			}
			
			return payed;
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
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
	
	
	/**GET Guest Pay List Method*/
	public ArrayList<PayDTO> getPayList(int gIdx, int cp, int ls){
		try {
			conn = com.db.SemiDB.getConn();
			int start = (cp-1)*ls + 1;
			int end = cp*ls;
			
			String sql = "SELECT * FROM "
					+ "(SELECT rownum as rnum, a.* FROM "
					+ "(SELECT * FROM paylist "
					+ "ORDER BY payidx DESC) a) "
					+ "WHERE gidx=? AND rnum>=? AND rnum<=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			
			ArrayList<PayDTO> arr = new ArrayList<PayDTO>();
			while(rs.next()) {
				int payIdx = rs.getInt("payidx");
				int payType = rs.getInt("paytype");
				int price = rs.getInt("price");
				java.sql.Timestamp payDate = rs.getTimestamp("paydate");
				
				PayDTO dto = new PayDTO(payIdx, gIdx, payType, price, payDate);
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
	
	
	/**Cancel Payed By payIdx*/
	public int payedCancel(int payIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE paylist SET paytype=3 WHERE payidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, payIdx);
			
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
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
	
}