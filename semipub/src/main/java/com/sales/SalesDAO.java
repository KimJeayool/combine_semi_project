package com.sales;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class SalesDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	//GET Sales List
	public ArrayList<SalesDTO> getSalesList(int cp, int ls, String startdate, String enddate){
		try {
			conn=com.db.SemiDB.getConn();
			
			int start=(cp-1)*ls+1; 
			int end=cp*ls;
			
			if(startdate.equals("")) { 
				startdate = "0000-00-00"; 
			}
			
			if(enddate.equals("")) { 
				enddate = "9999-99-99"; 
			}
			
			String sql="SELECT * FROM "
					+ "("
					+ "SELECT ROWNUM AS rnum, A.* "
					+ "FROM ("
					+ "SELECT A.payidx, B.tnum, B.total, A.paydate, C.name, B.gidx FROM PAYLIST A, GUEST B , ADMIN C "
					+ "WHERE A.gidx = B.gidx AND b.pay='결제' "
					+ "AND A.aIdx = C.aIdx "
					+ "AND TO_CHAR(A.paydate, 'YYYY-MM-DD') >= ? "
					+ "AND TO_CHAR(A.paydate, 'YYYY-MM-DD') <= ? ) A"
					+ ") "
					+ "where rnum>=? and rnum<=?";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, startdate); 
			ps.setString(2, enddate); 
			ps.setInt(3, start);
			ps.setInt(4, end);
			rs=ps.executeQuery();
			
			ArrayList<SalesDTO> arr=new ArrayList<SalesDTO>();
			while(rs.next()) {
				int payIdx=rs.getInt("payidx"); 
				int tNum=rs.getInt("tnum");
				int total=rs.getInt("total");
				java.sql.Timestamp payDate=rs.getTimestamp("paydate");
				String name=rs.getString("name");
				int gIdx=rs.getInt("gIdx"); 
				SalesDTO dto=new SalesDTO(payIdx, tNum, total, payDate, name, gIdx);
				arr.add(dto);				
			}
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				
			}
		}
	}
	
	/**Total Sales List Between startdate and enddate*/
	public int getTotalCnt(String startdate, String enddate) {
		try {
			conn=com.db.SemiDB.getConn();
			
			if(startdate.equals("")) {
				startdate = "0000-00-00";
			}
			
			if(enddate.equals("")) {
				enddate = "9999-99-99";
			}
			
			String sql="select count(*) from paylist where TO_CHAR(paydate, 'YYYY-MM-DD') >= ? "
					+ "AND TO_CHAR(paydate, 'YYYY-MM-DD') <= ? ";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, startdate);
			ps.setString(2, enddate);
			rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			return count==0?1:count; 
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}	
	}
	
	/**GET Total Sales Between startdate and enddate*/
	public int getTotalPrice(String startdate, String enddate) {
		try {
			conn=com.db.SemiDB.getConn();
			
			if(startdate.equals("")) {
				startdate = "0000-00-00";
			}
			
			if(enddate.equals("")) {
				enddate = "9999-99-99";
			}
			
			String sql="select sum(B.total) from PAYLIST A, GUEST B , ADMIN C "
					+ "WHERE A.gidx = B.gidx AND B.pay='결제' "
					+ "AND A.aIdx = C.aIdx "
					+ "AND TO_CHAR(paydate, 'YYYY-MM-DD') >= ? "
					+ "AND TO_CHAR(paydate, 'YYYY-MM-DD') <= ? ";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, startdate);
			ps.setString(2, enddate);
			rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			return count; 
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}	
	}
	
	//Get PAYLIST 
	public ArrayList<SalesDTO> arr(int gIdx){
		try {
			conn=com.db.SemiDB.getConn();

			String sql="select A.mname, A.price, B.count, C.paydate, D.name from menu A, semi_order B, paylist C, admin D "
					+ "where A.midx = B.midx and B.gidx = c.gidx and c.aidx = d.aidx and B.gidx = ?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			rs=ps.executeQuery();
			
			ArrayList<SalesDTO> arr=new ArrayList<SalesDTO>();
			while(rs.next()) {
				String mName=rs.getString("mname"); 
				int price=rs.getInt("price");
				int count=rs.getInt("count");
				java.sql.Timestamp payDate=rs.getTimestamp("paydate");
				String name=rs.getString("name");
				SalesDTO dto=new SalesDTO(mName, price, count, payDate, name);
				
				arr.add(dto);				
			}
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				
			}
		}
	}
	
	
}