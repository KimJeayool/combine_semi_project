package com.order;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class OrderDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public OrderDAO() {
		// TODO Auto-generated constructor stub
	}
	
	SimpleDateFormat timeCustom=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**GET Count of Order List By gIdx*/
	public int getOrderCount(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT COUNT(*) FROM semi_order WHERE gidx=?";
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
	
	
	
	/**GET Table Order List Method*/
	public ArrayList<OrderDTO> getTableOrder(int gIdx, int cp, int ls){
		try {
			conn = com.db.SemiDB.getConn();
			int start = (cp-1)*ls + 1;
			int end = cp*ls;
			
			String sql = "SELECT * FROM "
					+ "(SELECT rownum as rnum, step1.* FROM "
					+ "(SELECT a.oidx, a.gidx, b.tnum, c.mname, c.price, a.count, a.orderdate, d.stname "
					+ "FROM semi_order a, guest b, menu c, orderstatus d "
					+ "WHERE a.gidx=b.gidx AND a.midx=c.midx AND a.stnum=d.stnum "
					+ "ORDER BY oidx DESC) step1 ) step2 "
					+ "WHERE gidx=? AND rnum>=? AND rnum<=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			
			ArrayList<OrderDTO> arr = new ArrayList<OrderDTO>();
			while(rs.next()) {
				int oIdx = rs.getInt("oidx");
				int tNum = rs.getInt("tnum");
				String mName = rs.getString("mname");
				int price = rs.getInt("price");
				int count = rs.getInt("count");
				java.sql.Timestamp orderDate = rs.getTimestamp("orderdate");
				String stName = rs.getString("stname");
				
				OrderDTO dto = new OrderDTO(oIdx, gIdx, tNum, mName, price, count, orderDate, stName);
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
	
	public ArrayList<OrderDTO> getTableOrderList(int gIdx, int cp, int ls){
		try {
			conn = com.db.SemiDB.getConn();
			int start = (cp-1)*ls + 1;
			int end = cp*ls;
			
			String sql = "SELECT * FROM "
					+ "(SELECT rownum as rnum, step1.* FROM "
					+ "(SELECT a.oidx, a.gidx, b.tnum, c.mname, c.price, a.count, a.orderdate "
					+ "FROM semi_order a, guest b, menu c "
					+ "WHERE a.gidx=b.gidx AND a.midx=c.midx "
					+ "ORDER BY oidx DESC) step1 ) step2 "
					+ "WHERE gidx=? AND rnum>=? AND rnum<=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			
			ArrayList<OrderDTO> arr = new ArrayList<OrderDTO>();
			while(rs.next()) {
				int oIdx = rs.getInt("oidx");
				int tNum = rs.getInt("tnum");
				String mName = rs.getString("mname");
				int price = rs.getInt("price");
				int count = rs.getInt("count");
				java.sql.Timestamp orderDate = rs.getTimestamp("orderdate");
				//String stName = rs.getString("stname");
				//java.sql.Timestamp outDate = rs.getTimestamp("outDate");
				//int stNum = rs.getInt("stNum");
				//int mIdx = rs.getInt("mIdx");
				OrderDTO dto = new OrderDTO(oIdx, gIdx, tNum, mName, price, count, orderDate, "", null, 0, 0);
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	/**Get Total Price*/
	public int getTotalPrice(int gIdx) {
		try {
			conn=com.db.SemiDB.getConn();
			/*
			 * String sql="select *A.count from semi_order A, GUEST B , ADMIN C " +
			 * "WHERE A.gidx = B.gidx "
			 */
			String sql = "SELECT SUM(total) FROM "
					+ "(SELECT a.gidx, c.price*a.count AS total "
					+ "FROM semi_order a, guest b, menu c "
					+ "WHERE a.gidx=b.gidx AND a.midx=c.midx "
					+ "ORDER BY oidx DESC) "
					+ "WHERE gidx=?";

			ps=conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			rs=ps.executeQuery();
			rs.next();
			int total=rs.getInt(1);
			return total; 
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}	
	}
	
	/**Update Outdate*/
	public int updateOutdate(int gIdx) {
		try {
			conn=com.db.SemiDB.getConn();
			
			String sql = "UPDATE GUEST SET OUTDATE = SYSDATE WHERE GIDX=?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			int count=ps.executeUpdate();
			return count; 
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				//if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}	
	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/**count All orders(ok)*/
	public int countAll() {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT COUNT(*) FROM SEMI_ORDER";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);					
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}
	
	
	
	/**count orders left(ok)*/
	public int countOrders(int num) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT COUNT(*) FROM SEMI_ORDER WHERE stNum=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**View List using Page*/
	public ArrayList<OrderDTO> pageList(int cp, int ls){
		try {
			conn = com.db.SemiDB.getConn();
			int start = (cp-1)*ls+1;
			int end = cp*ls;
			String sql = "SELECT * FROM( "
					+ "    SELECT ROWNUM as rn, c.* "
					+ "        FROM ( SELECT b.*, r.stname "
					+ "            FROM(SELECT a.*, m.mname, m.price "
					+ "                FROM(SELECT s.*, g.tnum "
					+ "                    FROM  semi_order s, guest g "
					+ "                    WHERE s.gidx=g.gidx)a, "
					+ "                Menu m WHERE a.midx=m.midx ORDER BY a.stnum ASC) b, "
					+ "                    orderstatus r WHERE b.stnum= r.stnum)C) WHERE rn>=? AND rn<=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			ArrayList<OrderDTO> arr = new ArrayList<OrderDTO>();
			while(rs.next()) {
				int oIdx = rs.getInt("oIdx");
				int tNum = rs.getInt("tNum");
				String mName = rs.getString("mName");
				int count = rs.getInt("count");
				Timestamp orderDate = rs.getTimestamp("orderDate");
				String stName = rs.getString("stName");
				int price = rs.getInt("price");
				OrderDTO dto = new OrderDTO(oIdx, tNum, mName, count, orderDate, stName, price);
				arr.add(dto);
			}
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}
	
	/**View OrderList Using Table Selected*/
	public ArrayList<OrderDTO> getOrderList(int tNum){
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT b.*, r.stname FROM(SELECT a.*, m.mname, m.price "
					+ "  FROM(SELECT s.*, g.tnum FROM  semi_order s, guest g "
					+ "   WHERE s.gidx=g.gidx)a, menu m WHERE a.midx=m.midx) b, "
					+ "   orderstatus r WHERE b.stnum= r.stnum AND b.tnum=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tNum);
			rs = ps.executeQuery();
			ArrayList<OrderDTO> arr = new ArrayList<OrderDTO>();
			while(rs.next()) {
				int oIdx = rs.getInt("oIdx");
				String mName = rs.getString("mName");
				int count = rs.getInt("count");
				Timestamp orderDate = rs.getTimestamp("orderDate");
				String stName = rs.getString("stName");
				int price = rs.getInt("price");
				System.out.println("orderDAO 132 : "+stName);
				System.out.println("orderDAO 132 : "+price);
				OrderDTO dto = new OrderDTO(oIdx, tNum, mName, count, orderDate, stName, price);
				arr.add(dto);
			}
			return arr;
		} catch (Exception e) {
			return null;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}

	/**Cancel Order*/
	public int orderCancel(ArrayList<Integer> orders) {
		try {
				conn = com.db.SemiDB.getConn();
				String sql = "UPDATE SEMI_ORDER SET stnum=3 WHERE oIdx=?";
				ps = conn.prepareStatement(sql);
				int count = 0;
				for(int i=0; i<orders.size(); i++) {
					ps.setInt(1,orders.get(i));
					int result = ps.executeUpdate();
					if(result>0) {
						count++;
					}
				}
				return count;	
		} catch (Exception e) {
				e.printStackTrace();
				return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			
		}
	}

	/**Complete Order*/
	public int orderComplete(ArrayList<Integer> arr) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE SEMI_ORDER SET stnum=2 WHERE oIdx=?";
			ps = conn.prepareStatement(sql);
			int count = 0;
			for(int i=0; i<arr.size(); i++) {
				ps.setInt(1,arr.get(i));
				int result = ps.executeUpdate();
				if(result>0) {
					count++;
				}
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {	
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	
	/**Order From Cart*/
	public int setOrder(ArrayList<OrderDTO> arr) {
		try {
			int result = 0;
			conn = com.db.SemiDB.getConn();
			String sql = "INSERT INTO semi_order VALUES(order_idx.nextval,? ,? ,? , sysdate, 1)";
			ps = conn.prepareStatement(sql);
			for(int i=0; i<arr.size(); i++) {
				ps.setInt(1, arr.get(i).getgIdx());
				ps.setInt(2, arr.get(i).getmIdx());
				ps.setInt(3, arr.get(i).getCount());
				rs = ps.executeQuery();
				if(rs.next()) {result++;}
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {	
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		
	} 
	
	/**Get mIdx using mName*/
	public int getMIdx(String mName) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT mIdx FROM menu WHERE mName=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mName);
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
	
	/**Get mNamem using mIdx*/
	public String getmName(int mIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT mName FROM menu WHERE mIdx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mIdx);
			rs = ps.executeQuery();
			rs.next();
			return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null);
				if(ps!=null);
				if(conn!=null);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**Order from menuCart*/
	public int sendOrder(int mIdx, int mCount) {
		try {
			conn = com.db.SemiDB.getConn();
			//gIdx는 임의로 1설정
			String sql = "INSERT INTO semi_order VALUES(order_idx.nextval, 1, ?, ?,  sysdate, 1)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mIdx);
			ps.setInt(2, mCount);
			return ps.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		} finally {
			try {
				//if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	/**Order From Cart*/
	public int sendOrder(int gIdx, int mIdx, int mCount) {
		try {
			int result = 0;
			conn = com.db.SemiDB.getConn();
			String sql = "INSERT INTO semi_order VALUES(order_idx.nextval,? ,? ,? , sysdate, 1)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,mIdx);
			ps.setInt(2,gIdx);
			ps.setInt(3, mCount);
			rs = ps.executeQuery();
			if(rs.next()) {result++;}
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}	
	
	/**Set totalAmount at guest table*/
	public void setTotal(int total) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE guest SET total=total+? WHERE gidx=1";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,total);
			ps.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {	
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}	
	
}