package sist;

/*
 * CRUD - UPDATE 구현해보기
 * DB에 있는 PRODUCTS 테이블을 기준으로 구현하였다.
 * 
 * UPDATE를 콘솔로만 구현하기에는 한계가 있었다.
 * 사용자가 원하는 부분만 수정할 수 있도록 하는게 UPDATE에서 중요한 부분인데,
 * 콘솔에서 구현할 수는 있지만, 비효율적이라고 생각하여 내일 배우는 GUI 챕터를 배우고 나서
 * UPDATE문을 제대로 구현해보려 한다. 
 * 
 * 작성한 코드는 사용자가 입고가, 출고가, 배송비, 마일리지를 수정한다가정하고 진행하였다.
 * 
 */

import java.io.*;
import java.sql.*;

public class C_Update {
	
	public static void main(String[] args) throws NumberFormatException, IOException {
		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		Connection connection = null;
		
		PreparedStatement ps = null;
		
		ResultSet rs = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		
		String user = "WebData"; String pw = "sungja";
		
		// 쿼리문의 WHERE절에 사용할 제품이름을 데이터로 받아온다.
		System.out.print("수정하려는 제품 이름 입력 > ");
		String product = br.readLine();
		
		// 수정할 컬럼의 데이터 값 사용자로부터 받아오기
		System.out.print("입고가 수정 > ");
		int input_price = Integer.parseInt(br.readLine());
		
		System.out.print("출고가 수정 > ");
		int output_price = Integer.parseInt(br.readLine());
		
		System.out.print("배송비 수정 > ");
		int transCost = Integer.parseInt(br.readLine());
		
		System.out.print("마일리지 수정 > ");
		int mileage = Integer.parseInt(br.readLine());
		
		try {
			Class.forName(driver);
			System.out.println("Driver Loaded");
			
			connection = DriverManager.getConnection(url, user, pw);
			
			// UPDATE문을 사용하여 SET문 뒤에 컬럼 이름을 적어준다. 수정할 데이터는 변수에 저장했기 때문에 '?'키워드로 처리해준다.
			String sql = "UPDATE PRODUCTS SET INPUT_PRICE = ?, OUTPUT_PRICE = ?, TRANS_COST = ?, MILEAGE = ? "
					+ "WHERE PRODUCTS_NAME = ?";
			
			ps = connection.prepareStatement(sql);
			
			// PreparedStatement 객체에서 각 '?' 키워드에 인덱스에 맞게 변수들을 넣어준다.
			ps.setInt(1, input_price); ps.setInt(2, output_price); ps.setInt(3, transCost);
			ps.setInt(4, mileage); ps.setString(5, product);
			
			// executeUpdate() 메소드를 사용하고 int값을 result 변수에 저장
			int result = ps.executeUpdate();
			
			// 성공, 실패 여부에 따라서 나올 출력문 입력
			if(result > 0) {
				System.out.println(product + " 제품 업데이트 완료");
			} else {
				System.out.println("제품 업데이트 실패, 관리자 문의");
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
