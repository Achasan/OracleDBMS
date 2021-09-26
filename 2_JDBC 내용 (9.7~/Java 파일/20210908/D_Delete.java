package sist;

import java.io.*;
import java.sql.*;

/*
 * CRUD - DELETE 구현
 * DB에 있는 PRODUCTS 테이블을 기준으로 구현하였다.
 * 
 * 단순히만 보면 DELETE는 쉬운 부분이라고 할 수 있다. 
 * 조건에 맞는 행 하나를 삭제하는 쿼리문을 보내주면 되는데,
 * 여기서 후처리까지 자바에서 하도록 해볼 생각이다.
 * DELETE를 사용하여 중간에 있는 행을 삭제하면 제품번호가 중간에 비게 되는데,
 * 삭제하는 행보다 큰 제품번호가 있다면 그 제품번호의 행을 하나씩 줄여서
 * 빈 제품번호를 하나씩 채우도록 구현해보았다.
 * 
 * 총 3개의 파트로 나누어져 있다.
 * 1. 삭제할 행의 제품번호 가져오기
 * 2. 행 삭제하기
 * 3. 삭제한 행 보다 큰 제품번호를 하나씩 줄이기
 * 
 */

public class D_Delete {
	
	public static void main(String[] args) throws IOException {
		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		Connection connection = null;
		
		PreparedStatement ps = null;
		
		ResultSet rs = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		
		String user = "WebData"; String password = "sungja";
		
		// 제품 이름을 WHERE절에 사용하기위해 사용자로부터 삭제하려는 제품의 이름을 변수에 저장한다.
		System.out.print("삭제하려는 제품 이름 입력 > ");
		String product = br.readLine();
		
		try {
			Class.forName(driver);
			System.out.println("Driver Loaded");
			
			connection = DriverManager.getConnection(url, user, password);
			
			// 먼저 삭제하려는 행의 제품번호를 가져오기 위해서 SELECT 문을 사용한다.
			String sql = "SELECT PNUM FROM PRODUCTS WHERE PRODUCTS_NAME = ?";
			
			// PrepareStatement 객체에서 메소드 사용하여 변수를 넣어줌
			ps = connection.prepareStatement(sql);
			ps.setString(1, product);
			
			// SELECT문이므로 executeQuery() 메소드 사용
			rs = ps.executeQuery();
			
			// 결과값을 저장하기 위해 변수를 선언하고, 초기값을 넣어준다.
			int pNum = 0;
			
			// pNum 변수에 삭제할 행의 제품번호를 저장한다. 성공/실패 출력문을 작성한다.
			if(rs.next()) {
				pNum = rs.getInt("PNUM");
				System.out.println("PNUM 로드 완료.");
			} else {
				System.out.println("알 수 없는 오류 발생 : PNUM");
			}
			
			
			// 2. 행 삭제하기, DELETE문을 작성하여 제품 이름과 맞는 행이 있으면 삭제한다.
			sql = "DELETE FROM PRODUCTS WHERE PRODUCTS_NAME = ?";
			ps = connection.prepareStatement(sql);
			ps.setString(1, product);
			
			// 결과값은 없으므로 executeUpdate() 메소드 사용
			int result = ps.executeUpdate();
			
			// 성공/실패 출력문 출력
			if(result>0) {
				System.out.println("제품 데이터 삭제 완료");
			} else {
				System.out.println("알 수 없는 에러 발생 : RESULT");
			}
			
			// 3. 삭제한 행보다 큰 제품 번호를 1씩 줄이기, UPDATE 쿼리문을 작성한다.
			//    제품번호 컬럼이름은 PNUM인데, 삭제한 행의 제품번호를 pNum 변수에 저장했으므로 그 변수보다 큰 행이 있다면
			//	  PNUM 값에 - 1을 연산하여 저장하도록 한다.
			sql = "UPDATE PRODUCTS SET PNUM = PNUM - 1 WHERE PNUM > ?";
			ps = connection.prepareStatement(sql);
			ps.setInt(1, pNum);
			
			// DB에 있는 제품번호의 데이터값 수정이므로 결과값은 없다. executeUpdate() 실행
			int result2 = ps.executeUpdate();
			
			if(result2 > 0) {
				System.out.println("PNUM 정렬 완료");
			} else {
				System.out.println("PNUM 정렬 실패, 삭제한 제품보다 높은 값의 PNUM이 없을 수 있음.");
			}
			
			// 마지막에 close() 메소드 사용하는 것을 잊지 말자.
			rs.close(); ps.close(); connection.close();
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
