package member.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import member.bean.MemberDTO;

public class MemberDAO {
	private static MemberDAO instance;
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url= "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "java";
	private String password = "dkdlxl";
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public static MemberDAO getinstance() {	
		if(instance == null) {
			synchronized (MemberDAO.class) {
				instance = new MemberDAO();				
			}
		}
		return instance;
	}
	
	public MemberDAO() {
		try {
			Class.forName(driver);
			System.out.println("드라이버 로딩성공");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}		
	}
	
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("접속 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int insert(MemberDTO memberDTO) {
		this.getConnection();
		int cnt = 0; 
		String sql = "insert into member values(?,?,?,?,?,?,?,?,?,?,?,?, sysdate)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getName());
			pstmt.setString(2, memberDTO.getId());
			pstmt.setString(3, memberDTO.getPwd());
			pstmt.setString(4, memberDTO.getGender());
			pstmt.setString(5, memberDTO.getEmail1());
			pstmt.setString(6, memberDTO.getEmail2());		
			pstmt.setString(7, memberDTO.getTel1());
			pstmt.setString(8, memberDTO.getTel2());
			pstmt.setString(9, memberDTO.getTel3());
			pstmt.setString(10, memberDTO.getZipcode());
			pstmt.setString(11, memberDTO.getAddr1());
			pstmt.setString(12, memberDTO.getAddr2());
			
			cnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
				
	}

	public String isLogin(String id, String pwd) {
		String name = null;
		this.getConnection();
		String sql = "select name from member where id = ? and pwd = ?";
		try {
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}				
		return name;
	}

}

