package com.match;

import java.sql.*;
import java.util.*;

public class MatchDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MatchDAO() {
		
	}
	
	
	/**Get Match Table Info List*/
	public ArrayList<MatchDTO> getMatchInfo(int startIdx, int endIdx){
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT * FROM "
					+ "(SELECT b.* "
					+ "FROM guest a, match_table b "
					+ "WHERE pay='미결제' AND a.gidx=b.gidx) "
					+ "WHERE tnum>=? AND tnum<=? "
					+ "ORDER BY tnum ASC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startIdx);
			ps.setInt(2, endIdx);
			rs = ps.executeQuery();
			
			ArrayList<MatchDTO> arr = new ArrayList<MatchDTO>();
			while(rs.next()) {
				int gIdx = rs.getInt("gidx");
				int tNum = rs.getInt("tnum");
				String nickName = rs.getString("nickname");
				int male = rs.getInt("male");
				int female = rs.getInt("female");
				String msg = rs.getString("msg");
				int matchNum = rs.getInt("matchnum");
				String matchStatus = rs.getString("matchstatus");
				
				MatchDTO dto = new MatchDTO(gIdx, tNum, nickName, male, female, msg, matchNum, matchStatus);
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
	
	
	/**Get match_table Info*/
	public MatchDTO getMatchInfo(int gIdx){
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT * FROM match_table WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
			rs = ps.executeQuery();
			
			MatchDTO dto = null;
			if(rs.next()) {
				int tNum = rs.getInt("tnum");
				String nickName = rs.getString("nickname");
				int male = rs.getInt("male");
				int female = rs.getInt("female");
				String msg = rs.getString("msg");
				int matchNum = rs.getInt("matchnum");
				String matchStatus = rs.getString("matchstatus");
				
				dto = new MatchDTO(gIdx, tNum, nickName, male, female, msg, matchNum, matchStatus);
			}
			return dto;
			
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
	
	
	/**UPDATE match_table Info*/
	public int updateMatchInfo(MatchDTO dto) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE match_table SET nickname=?, male=?, female=?, msg=? WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getNickName());
			ps.setInt(2, dto.getMale());
			ps.setInt(3, dto.getFemale());
			ps.setString(4, dto.getMsg());
			ps.setInt(5, dto.getgIdx());
			int count = ps.executeUpdate();
			return count;
			
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
	
	
	/**GET My gIndex*/
	public int getMygIndex(int tNum) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT gidx FROM guest WHERE pay='미결제' AND indate=outdate AND tnum=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tNum);
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
	
	
	/**SET Match Table Number*/
	public int requestMatch(int mygIdx, int partner) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE match_table SET matchnum=? WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, partner);
			ps.setInt(2, mygIdx);
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
	
	
	/**GET Partner tNum*/
	public int getPartnertNum(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT matchnum FROM match_table WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
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
	
	
	/**Cancel Request*/
	public int cancelMatch(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE match_table SET matchnum=0 WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
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
	
	
	/**GET Table gidx that request to me */
	public ArrayList<Integer> getTablegIdxs(int tNum) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "SELECT gidx FROM "
					+ "(SELECT b.* "
					+ "FROM guest a, match_table b "
					+ "WHERE pay='미결제' AND a.gidx=b.gidx) "
					+ "WHERE matchnum=? "
					+ "ORDER BY tnum ASC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tNum);
			rs = ps.executeQuery();
			
			ArrayList<Integer> arr = new ArrayList<Integer>();
			while(rs.next()) {
				int gIdx = rs.getInt(1);
				arr.add(gIdx);
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
	
	
	/**SET Match*/
	public int setMatch(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE match_table SET matchstatus='매칭' WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
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
	
	
	/**SET Cancel*/
	public int setCancel(int gIdx) {
		try {
			conn = com.db.SemiDB.getConn();
			String sql = "UPDATE match_table SET matchstatus='비매칭' WHERE gidx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gIdx);
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

}
