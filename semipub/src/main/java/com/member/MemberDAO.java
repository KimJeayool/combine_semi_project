package com.member;

import java.sql.*;
import java.util.*;

public class MemberDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MemberDAO() {
		// TODO Auto-generated constructor stub
	}
	
	/**Login Admin Method*/
	public MemberDTO adminCheck(String aId, String aPwd) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="select * from ADMIN where aId=? and aPwd=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, aId);
			ps.setString(2, aPwd);
			rs=ps.executeQuery();
			
			MemberDTO dto = null;
			if(rs.next()) {
				int aIdx = rs.getInt("aIdx");
				String name = rs.getString("name");
				String lev = rs.getString("lev");
				
				dto = new MemberDTO(aIdx, name, lev);
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
			} catch (Exception e2) {}
		}
	}
	
	/**List Admin Method*/
	public ArrayList<MemberDTO> getMemberList(){
		try {
			conn=com.db.SemiDB.getConn();
			String sql="select * from ADMIN order by aIdx desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<MemberDTO> arr=new ArrayList<MemberDTO>();
			while(rs.next()) {
	            int aIdx=rs.getInt("aIdx");
	            String aId=rs.getString("aId");
	            String aPwd=rs.getString("aPwd");
	            String name=rs.getString("name");
	            String lev=rs.getString("lev");
	            
	            MemberDTO dto=new MemberDTO(aIdx, aId, aPwd, name, lev);
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
	
	/**Add Admin Method*/
	public int getMember(MemberDTO dto) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="insert into ADMIN values(ADMIN_idx.nextval,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getaId());
			ps.setString(2, dto.getaPwd());
			ps.setString(3, dto.getName());
			ps.setString(4, dto.getLev());
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
	
	
	/**Edit Admin Method*/
	public int editMember(MemberDTO dto) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="update ADMIN set aId=?, aPwd=?, name=?, lev=? where aIdx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getaId());
			ps.setString(2, dto.getaPwd());
			ps.setString(3, dto.getName());
			ps.setString(4, dto.getLev());
			ps.setInt(5, dto.getaIdx());
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
	
	/**Cheak Id Method*/
	public boolean idCheck(String userid) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="select aId from ADMIN where aId=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			return rs.next();
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
	}
	
	/**Delete Admin Method*/
	public int deleteMember(int aIdx) {
		try {
			conn=com.db.SemiDB.getConn();
			String sql="delete from ADMIN where aIdx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, aIdx);
			int result = ps.executeUpdate();
			return result;
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