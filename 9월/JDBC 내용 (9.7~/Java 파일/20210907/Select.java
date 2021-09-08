package sist;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Select {
	public static void main(String[] args) {
		StringBuilder sb = new StringBuilder();
		
		Connection connection = null;					// 자바와 DB를 연결하는 객체
		
		PreparedStatement pstmt = null; 				// SQL문을 전송하는 객체
				
		ResultSet rs = null;							// SQL 실행 결과를 가지고 있는 객체
		
		String driver = "oracle.jdbc.driver.OracleDriver"; 	// ojdbc8.jar 안에 있는 OracleDriver 클래스의 주소값을 driver에 저장
				
		String url = "jdbc:oracle:thin:@localhost:1521:xe";	// DB에 연결할 계정 주소를 가리킨다. 여기서 thin은 JDK가 있으면 설치가능한 드라이버를 말하고, @뒤에는 등록된 계정의 주소를 적는다.
															// 아이피:포트:식별자 순이다. 계정 속성에서 확인할 수 있다.
		
		String user = "WebData";
		
		String password = "sungja";
		
		// 1. 오라클 드라이버 로딩
		// forName() : 프로그램 실행 시에 드라이버를 로딩한다(동적로딩).
		try {
			
			Class.forName(driver);
			System.out.println("드라이버 로딩 성공");
			
			// 2. DriverManager 클래스를 이용하여 연결정보를 얻어와서 객체에 저장, 매개값으로는 연결주소, 계정이름, 비밀번호를 넣어준다.
			// 	  DriverManger 클래스의 getConnection 메소드에 매개값을 넣어주면 매개값을 토대로 계정 연결정보를 db에(오라클, mysql 등) 전달한다.
			//    연결이 성공하면 연결된 정보를 리턴하는데, 그 정보를 connection 클래스에 저장해놓기 위해 connection 변수에 저장
			connection = DriverManager.getConnection(url, user, password);
			
			if(connection != null) {
				System.out.println("DB 연결 완료");
			} else {
				System.out.println("연결 실패, 다시 확인");
			}
			
			// 3. db가 연결되었으므로 쿼리문을 작성하여 db에 보내기
			String sql = "SELECT * FROM MEMBER10 ORDER BY MEMNUMBER"; // 쿼리문을 String 타입의 sql에 저장
			pstmt = connection.prepareStatement(sql); // 실행할 쿼리문을 Connection 클래스에 있는 prepareStatement 메소드를 통해 PrepareStatement 객체의 값으로 변환시킨다.
			
			
			// 4. db에 SQL문을 전송
			rs = pstmt.executeQuery();	 // 변환시킨 sql문을 db에 넘겨서 db에서 실행시킨다. ResultSet 값을 리턴하기 때문에 rs 변수에 저장한다.
			
			// 5. rs에 저장되어있는 데이터를 불러오기
			while(rs.next()) {
				int mn = rs.getInt("MEMNUMBER");
				sb.append(mn).append("\t");
				
				String id = rs.getString("MEMID") + "    ";
				sb.append(id).append("\t");
				
				String name = rs.getString("MEMNAME");
				sb.append(name).append("\t");
				
				int age = rs.getInt("AGE");
				sb.append(age).append("\t");
				
				int mileage = rs.getInt("MILEAGE");
				sb.append(mileage).append("\t");
				
				String job = rs.getString("JOB");
				sb.append(job).append("\t");
				
				String address = rs.getString("ADDR") + "          ";
				sb.append(address).append("\t");
				
				String regDate = rs.getString("REGDATE").substring(0, 10);
				sb.append(regDate).append("\t");
				
				sb.append("\n");
				
			}
			
			System.out.println(sb);
			
			// 6. 연결되어 있던 객체들을 종료시켜주어야 한다.
			System.out.println("연결을 종료합니다.");
			rs.close();	pstmt.close();	connection.close(); // 역순으로 종료시켜주어야 한다.
			
		} catch (ClassNotFoundException | SQLException e) {
			
			System.out.println("Error : 클래스를 찾을 수 없음");
			e.printStackTrace();
			
		}
		
	}
}
