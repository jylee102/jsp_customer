package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DTO.Customer;

public class CustomerDAO {
	final static String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	final static String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";

	// 데이터베이스 연결 메소드
	public Connection open() {
		Connection conn = null;

		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "test", "test1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn; // 데이터베이스 연결 객체를 리턴
	}

	// 고객 리스트 가져오는 메소드
	public ArrayList<Customer> getList() throws Exception {
		Connection conn = open(); // DB 커넥션 열기
		ArrayList<Customer> customerList = new ArrayList<>();

		String sql = "SELECT ID, NAME, POINT, UPPER(GRADE) AS GRADE FROM CUSTOMERS ORDER BY ID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		try (conn; pstmt; rs) {
			while (rs.next()) {
				Customer c = new Customer();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setPoint(rs.getInt("point"));
				c.setGrade(rs.getString("grade"));

				customerList.add(c);
			}
		}

		return customerList;
	}

	// 고객 상세정보 가져오는 메소드
	public Customer getDetail(int id) throws Exception {
		Connection conn = open();
		Customer c = new Customer();

		String sql = "SELECT ID, NAME, ADDRESS, PHONE, GENDER, AGE, IMG, POINT, UPPER(GRADE) AS GRADE FROM CUSTOMERS WHERE ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		ResultSet rs = pstmt.executeQuery();

		try (conn; pstmt; rs) {
			while (rs.next()) {
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setAddress(rs.getString("address"));
				c.setPhone(rs.getString("phone"));
				c.setGender(rs.getString("gender"));
				c.setAge(rs.getInt("age"));
				c.setImg(rs.getString("img"));
				c.setPoint(rs.getInt("point"));
				c.setGrade(rs.getString("grade"));
			}
		}

		return c;
	}

	// 고객 등록 메소드
	public void registCustomer(Customer c) throws Exception {
		Connection conn = open();
		String sql = "insert into CUSTOMERS values(customer_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		try (conn; pstmt) {
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getAddress());
			pstmt.setString(3, c.getPhone());
			pstmt.setString(4, c.getGender());
			pstmt.setInt(5, c.getAge());
			pstmt.setString(6, c.getImg());
			pstmt.setInt(7, c.getPoint());
			pstmt.setString(8, c.getGrade());
			pstmt.executeUpdate();
		}
	}

	// 고객 정보 수정 메소드
	public void updateInfo(Customer c) throws Exception {
		Connection conn = open();
		String sql = "UPDATE CUSTOMERS SET NAME = ?, ADDRESS = ?, PHONE = ?, GENDER = ?, AGE = ?, "
				+ "IMG = NVL(?, (SELECT IMG FROM CUSTOMERS WHERE ID = ?)), "
				+ "POINT = NVL(?, 0), GRADE = ? WHERE ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		try (conn; pstmt) {
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getAddress());
			pstmt.setString(3, c.getPhone());
			pstmt.setString(4, c.getGender());
			pstmt.setInt(5, c.getAge());

			pstmt.setString(6, c.getImg());
			pstmt.setInt(7, c.getId());

			pstmt.setInt(8, c.getPoint());
			pstmt.setString(9, c.getGrade());
			pstmt.setInt(10, c.getId());

			// 수정된 내용이 없을 경우
			if (pstmt.executeUpdate() != 1) {
				System.out.println("수정된");
				throw new Exception("수정된 정보가 없습니다.");
			}
		}
	}

	// 고객 정보 삭제 메소드
	public void deleteCustomer(int id) throws Exception {
		Connection conn = open();
		String sql = "DELETE FROM CUSTOMERS WHERE ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		try (conn; pstmt) {
			pstmt.setInt(1, id);

			if (pstmt.executeUpdate() != 1) {
				throw new Exception("이미 존재하지 않는 고객 정보입니다.");
			}
		}
	}
}
