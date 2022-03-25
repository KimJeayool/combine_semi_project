package com.table;

import java.sql.*;
import java.util.*;

public class TableDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public TableDAO() {
		
	}
	
	/**Check Table Id Method*/
	public boolean checkId(String tId) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT * FROM semi_table WHERE tid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, tId);
			rs = ps.executeQuery();
			
			boolean canUse = true;
			if(rs.next()) {
				canUse = false;
			}
			return canUse;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
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
	
	/**GET Table Count Method*/
	public int getTableCount() {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT MAX(tnum) FROM semi_table";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			int result = 0;
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
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
	
	
	/**ADD Table Method*/
	public int addTable(TableDTO tdto) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "INSERT INTO semi_table VALUES(?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tdto.gettNum());
			ps.setString(2, tdto.gettId());
			ps.setString(3, tdto.gettPwd());
			int result = ps.executeUpdate();
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null) {ps.close();}
				if(conn!=null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**Delete Last Table Method*/
	public int deleteTable(int tNum) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "DELETE FROM semi_table WHERE tnum=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tNum);
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

/**Login Table Method*/
	public int userCheck(String tId, String tPwd) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="select TNUM from SEMI_TABLE where tId=? and tPwd=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, tId);
			ps.setString(2, tPwd);
			rs=ps.executeQuery();
			
			int tnum = 0;
			if(rs.next()) {
				tnum = rs.getInt(1);
			}
			return tnum;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
	}
	
	/**List Table Method*/
	public ArrayList<TableDTO> getTableList(){
		try {
			conn=com.db.SemiDB.getConn();
			String sql="select * from SEMI_TABLE order by tNum desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			ArrayList<TableDTO> arr=new ArrayList<TableDTO>();
			while(rs.next()) {
	            int tNum=rs.getInt("tNum");
	            String tId=rs.getString("tId");
	            String tPwd=rs.getString("tPwd");
	            
	            TableDTO dto=new TableDTO(tNum, tId, tPwd);
	            arr.add(dto);
			}
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
	         return null;
		} finally {
			try {
				if(rs!=null)rs.close();
	            if(ps!=null)ps.close();
	            if(conn!=null)ps.close();
			} catch (Exception e2) {}
		}
	}

	/**Edit Table List Method*/
	public int editTable(TableDTO dto) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="update SEMI_TABLE set tId=?, tPwd=? where tNum=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.gettId());
			ps.setString(2, dto.gettPwd());
			ps.setInt(3, dto.gettNum());
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