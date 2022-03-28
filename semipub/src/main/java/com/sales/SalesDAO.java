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
					+ "SELECT A.payidx, B.tnum, A.price, A.paydate, C.name, B.gidx FROM PAYLIST A, GUEST B , ADMIN C "
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
				int price=rs.getInt("price");
				java.sql.Timestamp payDate=rs.getTimestamp("paydate");
				String name=rs.getString("name");
				int gIdx=rs.getInt("gIdx"); 
				SalesDTO dto=new SalesDTO(payIdx, tNum, price, payDate, name, gIdx);
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
			
			String sql="select sum(A.price) from PAYLIST A, GUEST B , ADMIN C "
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
	public ArrayList<SalesDTO> arr(int gIdx, int payIdx){
		try {
			conn=com.db.SemiDB.getConn();

			String sql="select A.mname, E.total, C.price, B.count, C.paydate, D.name, F.payment "
					+ "from menu A, semi_order B, paylist C, admin D, guest E, payment F "
					+ "where A.midx = B.midx and B.gidx = c.gidx and c.aidx = d.aidx and c.gidx = e.gidx and C.paytype = F.paytype "
					+ "and B.gidx = ? and C.payidx = ?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			ps.setInt(2, payIdx);
			rs=ps.executeQuery();
			
			ArrayList<SalesDTO> arr=new ArrayList<SalesDTO>();
			while(rs.next()) {
				String mName=rs.getString("mname"); 
				int total=rs.getInt("total");
				int price=rs.getInt("price");
				int count=rs.getInt("count");
				java.sql.Timestamp payDate=rs.getTimestamp("paydate");
				String name=rs.getString("name");
				String payment=rs.getString("payment");
				SalesDTO dto=new SalesDTO(mName, total, price, count, payDate, name, payment);
				
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