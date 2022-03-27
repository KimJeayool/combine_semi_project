package com.menu;

import java.sql.*;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.*;

public class MenuDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	
	public MenuDAO() {
		
	}
	
	
	/**Add Menu Information*/
	public int menuInsert(String mName,int cateNum,int price,String state,String img) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="insert into menu values(menu_idx.nextval,?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, mName);
			ps.setInt(2, cateNum);
			ps.setInt(3, price);
			ps.setString(4, state);
			ps.setString(5, img);
			int count=ps.executeUpdate();
			return count;		
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();	
				if(conn!=null)conn.close();	
			}catch(Exception e2) {}
		}
	}
	
	
	/**View MenuList using Category(cateNum) and Page*/
	public ArrayList<MenuDTO> menuList(int cateNum, int cp, int ls){
		try {
			conn=com.db.SemiDB.getConn();
			int start = (cp-1)*ls + 1;
			int end = cp*ls;
			String sql="SELECT * FROM (SELECT rownum as rnum, a.* FROM (SELECT * FROM menu ORDER BY midx DESC) a WHERE catenum=?) b WHERE rnum>=? AND rnum<=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, cateNum);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs=ps.executeQuery();
			
			ArrayList<MenuDTO> arr=new ArrayList<MenuDTO>();
			while(rs.next()) {
				int mIdx=rs.getInt("mIdx");
				String mName=rs.getString("mName");
				int price=rs.getInt("price");
				String state=rs.getString("state");
				String img=rs.getString("img");
				MenuDTO dto=new MenuDTO(mIdx, mName, cateNum, price, state, img);
				arr.add(dto);
			}
			return arr;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();	
				if(ps!=null)ps.close();	
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	
	
	/**Edit Menu*/
	public int menuEdit(MenuDTO dto) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="update menu set cateNum=?,mName=?,price=?,img=?,state=? where mIdx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getCateNum());
			ps.setString(2, dto.getmName());
			ps.setInt(3, dto.getPrice());
			ps.setString(4, dto.getImg());
			ps.setString(5, dto.getState());
			ps.setInt(6, dto.getmIdx());
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();	
				if(ps!=null)ps.close();	
				if(conn!=null)conn.close();	
			}catch(Exception e2) {}
		}
	}
	
	
	/**Delete Menu*/
	public int menuDelete(MenuDTO dto) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="delete from menu where mIdx=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getmIdx());
			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();	
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	
	/**Get Menu Quantity registered(return >=-1)*/
	public int getTotalMenuCount(int cateNum) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql = "SELECT COUNT(*) FROM menu WHERE catenum=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cateNum);
			rs = ps.executeQuery();
			
			int count = 0;
			if(rs.next()) {
				count = rs.getInt(1);
			}
			return  count;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();	
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	
	/**Count All Menu registered*/
	public int countAllMenu() {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT COUNT(*) FROM menu";
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
	
	
	/**Get Menu Quantity registered(return >=1)*/
	public int getTotalCnt(int cateNum) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT COUNT(*) FROM(SELECT m.*, c.catename FROM menu m, category c "
					+ "    WHERE m.catenum=c.catenum AND m.cateNum=?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cateNum);
			rs = ps.executeQuery();
			
			rs.next();
			int count = rs.getInt(1);
			
			return count==0? 1 : count;
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
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
	
	
	/**Get Menu Information Using mIdx*/
	public MenuDTO getMenuInfo(int mIdx){
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT * FROM menu WHERE mIdx = ? ORDER BY midx ASC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mIdx);
			rs = ps.executeQuery();
			
			MenuDTO dto = null;
			if(rs.next()) {
				String mname = rs.getString("mname");
				int price = rs.getInt("price");
				String img = rs.getString("img");
				
				dto = new MenuDTO(mIdx, mname, price, img);
			}
			
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
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
	

	
	
}