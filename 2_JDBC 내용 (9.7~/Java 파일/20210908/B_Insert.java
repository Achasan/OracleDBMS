package sist;

/*
 * CRUD - CREATE 구현해보기 (CREATE)
 * DB에 있는 PRODUCTS 테이블을 기준으로 구현하였다.
 * 
 * 데이터를 생성하는 CREATE문은 기본키 제약조건이 걸린 번호생성에 대한
 * 로직을 구현하는 것이 중요하다는 점을 알았다. 사용자로 부터 컬럼에 대한 데이터 값을
 * 차례로 받아서 데이터를 추가하였다.
 * 기본키에 해당하는 제품번호는 테이블에서 제품번호의 최댓값을 받아와서 최댓값+1한 값을
 * 사용자로부터 입력받지 않도록 하고, 제품번호로 넣어주었다.
 * 
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class B_Insert {
	
	public static void main(String[] args) throws NumberFormatException, IOException {
		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		Connection connection = null;
		
		PreparedStatement ps = null;
	
		ResultSet rs = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		
		String user = "WebData"; String pw = "sungja";
		
		// 기본적으로 세팅하는 부분은 이전과 동일하므로 설명 생략
		
		
		System.out.println("PRODUCTS 새 제품 추가");
		System.out.println("=================");
		
		System.out.print("제품 번호 입력 > ");
		String key = br.readLine();
		
		System.out.print("제품 이름 입력 > ");
		String name = br.readLine();
		
		System.out.print("제품 코드 입력 > ");
		String code = br.readLine();
		
		System.out.println("입고가 입력 > ");
		int input_price = Integer.parseInt(br.readLine());
		
		System.out.print("출고가 입력 > ");
		int output_price = Integer.parseInt(br.readLine());
		
		System.out.print("배송비 입력 > ");
		int transCost = Integer.parseInt(br.readLine());
		
		System.out.print("마일리지 입력 > ");
		int mileage = Integer.parseInt(br.readLine());
		
		System.out.print("제조사 입력 > ");
		String company = br.readLine();
		
		System.out.print("재고 상태 입력 > ");
		int status = Integer.parseInt(br.readLine());
		
		// PRODUCTS 컬럼은 총 10개로 구성되어있는데, 여기서 제품번호를 제외한 9개의 컬럼을 사용자로부터 입력을 받도록하였다.
		// 입력받을 때는 BufferedReader를 통해 입력을 받았기 때문에 int값은 Integer.parseInt()를 사용하여 타입변환을 해주어야한다.
		
		
		
		try {
			Class.forName(driver);
			System.out.println("Driver Loaded");
			
			connection = DriverManager.getConnection(url, user, pw);
			
			
			// 먼저 PRODUCTS의 제품번호의 최댓값을 얻어오는 쿼리를 DB에 보낸다. 그룹함수 MAX()를 사용한다.
			String sql = "SELECT MAX(PNUM) \"MAX\" FROM PRODUCTS";
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();
			int max = 0;
			
			// 결과값을 하나이기 때문에 반복문을 사용할 필요는 없다. if문을 사용하여 값을 얻어오도록하자.
			if(rs.next()) {
				max = rs.getInt("MAX"); // 제품번호의 최댓값은 숫자이므로 int값으로 받아온다.
				max++;
				System.out.println("PNUM VALUE SAVED");	// 제품번호 최댓값 저장되었다는 멘트
			}
			
			
			// 이제 사용자로부터 입력받은 각 컬럼의 데이터들을 PRODUCTS 테이블에 추가시켜준다.
			// 여기서 중요한 개념이 나온다. SQL문을 String 타입으로 작성하기 때문에 사용자로부터 받은 데이터 값을 저장해도 쿼리문에 넣어줄 수가 없다.
			// 문자열로 인식하기 때문이다. 따라서 '?' 키워드를 사용하여 해당 키워드에 변수값을 넣는 메소드를 사용해주어야한다.
			// 이 메소드는 PreparedStatement 클래스에서 제공한다.
			sql = "INSERT INTO PRODUCTS VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = connection.prepareStatement(sql);	 // 컴파일한 sql문을 PreparedStatement 객체로 보내준다.
			
			// setXXX() 메소드를 사용하여 변수를 쿼리문 안에 넣어줄 수 있다. 매개값은 (인덱스, 변수이름)으로 되어있다.
			// 인덱스는 몇 번째 '?'키워드에 해당 변수를 넣을 것인지를 묻는다. 테이블의 컬럼순서에 맞게 변수를 넣어주어야 한다.
			ps.setInt(1, max); ps.setString(2, key);ps.setString(3, name); ps.setString(4, code);
			ps.setInt(5, input_price); ps.setInt(6, output_price); ps.setInt(7, transCost);
			ps.setInt(8, mileage); ps.setString(9, company); ps.setInt(10, status);
			
			
			// db에 데이터를 생성하는 것이므로 결과값이 없다 executeUpdate() 메소드 실행
			// executeUpdate()는 데이터를 리턴하지는 않지만, 쿼리문이 올바르게 실행되었는지에 대한 리턴값을 int타입으로 반환한다.
			// 1이 나오면 제대로 수행되었다는 뜻이다. result 변수에 저장.
			int result = ps.executeUpdate();
			
			// 쿼리문이 제대로 실행되었다면 1을 리턴하므로 result가 0보다 클 경우 성공, 안되면 실패했다는 출력문을 넣어준다.
			if(result > 0) {
				System.out.println("제품 추가 완료");
			} else {
				System.out.println("제품 추가 실패, 에러 발생");
			}
			
			// 실행이 끝나면 각 객체에 남아있는 데이터들을 닫아주어 메모리를 반환하도록 한다.
			rs.close(); ps.close(); connection.close();
			
		} catch (ClassNotFoundException e) {
			System.out.println("error occured : class not found");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("error occured : sql error");
			e.printStackTrace();
		}
		
		

		
	}
}
