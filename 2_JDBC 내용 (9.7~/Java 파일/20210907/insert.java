package sist;

import java.io.*;
import java.sql.*;

public class insert {

	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		Connection connection = null;
		
		PreparedStatement ps = null;
		
		ResultSet rs = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		
		String id = "WebData"; String pw = "sungja";
		
		
		System.out.println("[회원가입]");
		System.out.print("ID 입력 > ");
		String regId = br.readLine();
		
		System.out.print("이름 입력 > ");
		String name = br.readLine();
		
		System.out.print("PW 입력 > ");
		String regPw = br.readLine();
		
		System.out.print("나이 입력 > ");
		int age = Integer.parseInt(br.readLine());
		
		int mileage = 0;
		
		System.out.print("직업 입력 > ");
		String job = br.readLine();
		
		System.out.print("주소 입력 > ");
		String address = br.readLine();
		
		try {
			Class.forName(driver);
			System.out.println("드라이버 로드 성공, DB 연결중");
			
			connection = DriverManager.getConnection(url, id, pw);
			
			if(connection == null) {
				System.out.println("DB 연결 실패");
			}
			
			String sql = "INSERT INTO MEMBER10 VALUES(MEMBER10_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			
			ps = connection.prepareStatement(sql);
			
			ps.setString(1, regId);	ps.setString(2, name);	ps.setString(3, regPw);
			ps.setInt(4, age);	ps.setInt(5, mileage);	ps.setString(6, job);
			ps.setString(7, address);
			
			
			// 데이터베이스에 SQL 문을 전송한다 : SQL문이 SELECT절인 경우에는 executeQuery() 메소드를 사용한다.(ResultSet반환)
			//							단, SQL문이 select가 아닌 insert, update, delete SQL문인 경우에는 
			//							ExecuteUpdate() 메소드를 사용해야한다. 왜냐하면 결과값이 없는 DB의 데이터를 추가, 수정, 삭제하는 것이기 때문이다.
			//							메소드를 실행하면 실행결과를 int 타입으로 반환한다.(1 : 성공적으로 실행됨)
			int number = ps.executeUpdate();
			
			if(number > 0) {
				System.out.println("회원가입이 완료되었습니다.");
			} else {
				System.out.println("회원가입에 실패했습니다.");
			}
			
			ps.close();
			connection.close();
			
			
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("에러 발생, 다시 입력해주세요.");
			e.printStackTrace();
		}
	}

}
