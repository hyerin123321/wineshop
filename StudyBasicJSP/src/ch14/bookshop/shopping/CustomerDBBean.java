package ch14.bookshop.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomerDBBean {
	
	private static CustomerDBBean instance = new CustomerDBBean();
	
	public static CustomerDBBean getInstance() {
		return instance;
	}
	
	private CustomerDBBean() {}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	public void insertMember(CustomerDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "";
			
			sql = "insert into member values(?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getReg_date());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getTel());
			
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
			try { conn.close(); } catch(SQLException ex) {}
		}

	}
	
	// 사용자 인증
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			String sql = "";
			
			sql = "select passwd from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) 
					x = 1; //인증성공
				else 
					x = 0; // 비밀번호 틀림
			} else  
				x = -1; //해당아이디 없음
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null)
				try { rs.close(); } catch(SQLException ex) {}
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
				try { conn.close(); } catch(SQLException ex) {}
			
		}
		return x;
	}
	
	public int confirmId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		
		try {
			conn = getConnection();
			String sql = "";
			sql = "select id from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				x = 1;
			else 
				x = -1;
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null)
				try { rs.close(); } catch(SQLException ex) {}
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
				try { conn.close(); } catch(SQLException ex) {}
			
		}
		return x;
	}
	
	
	public CustomerDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CustomerDataBean member = null;
		
		try {
			conn = getConnection();
			String sql = "";
			sql = "select * from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new CustomerDataBean();
				
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
			}
		}  catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null)
				try { rs.close(); } catch(SQLException ex) {}
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
				try { conn.close(); } catch(SQLException ex) {}
			
		}
		return member;
	}
		
	public void updateMember(CustomerDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "";
			
			sql = "update member set passwd=?,name=?,tel=?,address=? where id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getTel());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getId());
			
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
			try { conn.close(); } catch(SQLException ex) {}
		}

	}
	
	public int deleteMember(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			String sql = "";
			
			sql = "select passwd from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					sql = "delete from member where id=?";
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1;
				} else 
					x = 0;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null)
				try { rs.close(); } catch(SQLException ex) {}
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
				try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
		
	}
}
