package sist;

/*
 * CRUD - READ 구현해보기 (SELECT)
 * DB에 있는 PRODUCTS 테이블을 기준으로 구현하였다.
 * SELECT문으로 PRODUCTS에 있는 컬럼들을 모두 가져와서 콘솔에 출력하도록 작성했다.
 * 여기서 필요없는 STATUS 컬럼은 출력문에서 제외하였다.
 * 
 * SELECT문은 데이터를 출력만 하는 파트여서 그런지 크게 복잡한 로직은 없었다.
 * 기본적인 개념을 이해하는데 중점을 두었다.
 * 
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class A_Select {
	
	public static void main(String[] args) {
		
		StringBuilder sb = new StringBuilder();
		
		Connection connection = null;		// Connection 객체를 null로 생성하여 생성된 연결객체를 받을 수 있도록 변수 선언
		
		PreparedStatement ps = null;		// Connection 객체를 받으면 쿼리문을 DB에 보내기 위해 PreparedStatement 객체 변수를 선언
		
		ResultSet rs = null;				// SELECT문의 경우 결과값을 ResultSet 객체로 리턴하므로 결과데이터를 받을 객체의 변수 선언
		
		String driver = "oracle.jdbc.driver.OracleDriver";    // 드라이버를 통해 연결하기 위해 드라이버가 있는 경로를 driver 변수에 저장
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";   // 오라클 DB에 접속하기위한 접속주소를 작성하여 url 주소에 저장
		
		String user = "WebData"; String pw = "sungja";		  // 오라클 DB에 접속하기 위해서는 계정과 비밀번호가 필요하다. 변수에 저장해준다.
		
		try {
			Class.forName(driver);							  // 드라이버를 동적로딩하기 위해서 Class클래스에 있는 정적메소드 forName()를 사용하여 드라이버 로딩
			System.out.println("Driver Loaded");			  // forName() 메소드는 try-catch문에 작성한다. 클래스가 없을 경우 예외를 출력하기 때문.
															  // 드라이버가 성공적으로 로딩되면 다음문장으로 드라이버가 로드되었다는 출력문을 작성
			
			connection = DriverManager.getConnection(url, user, pw);	
			// 드라이버가 로드되었으면 DriverManager 객체의 정적메소드인 getConnection() 메소드를 호출하여 연결정보를 가져온다.
			// 매개값으로 오라클DB의 주소, 계정이름, 비밀번호를 넣어주어야한다. 
			// 매개값에 맞는 주소에서 로그인하여 연결되면 Connection 객체를 리턴한다. 변수에 저장하도록 하자.
			
			String sql = "SELECT * FROM PRODUCTS ORDER BY PNUM";	// sql문을 작성한다. SELECT문으로 PRODUCTS의 모든 데이터를 불러오는 쿼리문 작성, 변수에 저장
			
			ps = connection.prepareStatement(sql);					// connection 객체에서 sql문을 SQL에 맞도록 컴파일 하여 PrepareStatement 객체로 반환하는
																	// prepareStatement() 메소드에 sql 변수를 매개값으로 넣어서 ps 변수에 저장한다.
			
			rs = ps.executeQuery();									// sql문에 따로 지정해줄 '?' 파라미터가 없었으므로 바로 쿼리문을 db에 넘겨주도록 한다.
																	// SELECT문은 결과데이터 값을 리턴하므로 executeQuery() 메소드를 사용한다.
																	// 쿼리문을 실행하여 나온 결과값을 ResultSet 객체타입인 rs 변수에 저장한다.
			
			
			while(rs.next()) {	// rs.next() : boolean 타입으로 되어있으며, 불러올 행이 있을 경우에는 true, 아닐 경우에는 false를 리턴한다. 반복문 제어에 사용가능
								// 			   true를 리턴하면 다음행으로 넘어가게 된다. while 반복문을 사용하여 해당 행에 있는 컬럼 데이터들을 하나씩 StringBuilder에 쌓는다.
				
				sb.append(rs.getInt("PNUM")).append("\t");					// 행을 호출할 떄마다 각 컬럼의 데이터자료형에 맞도록 getXXX() 메소드를 사용하여 
				sb.append(rs.getString("CATEGORY_FK")).append("\t");		// 데이터를 호출한다.
				sb.append(rs.getString("PRODUCTS_NAME")).append("\t");
				sb.append(rs.getString("EP_CODE_FK")).append("\t");
				sb.append(rs.getString("INPUT_PRICE")).append("\t");
				sb.append(rs.getString("OUTPUT_PRICE")).append("\t");
				sb.append(rs.getString("TRANS_COST")).append("\t");
				sb.append(rs.getString("MILEAGE")).append("\t");
				sb.append(rs.getString("COMPANY")).append("\t");
				sb.append("\n");
				
			}
			
			System.out.println(sb); // StringBuilder에 넣은 데이터들을 모두 출력한다. 클자 수에 따라서 \t 이 안맞는 경우가 있는데 이건 방법을 찾아봐야할 것 같다..
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
