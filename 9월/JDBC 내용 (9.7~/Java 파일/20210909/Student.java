package sist;

/* 
 * 수업에서 강사님이 작성한 내용을 토대로 만든 STUDENTS
 * DB연동 GUI이다.
 */


import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class Student extends JFrame{
	
	Connection connection = null;
	
	PreparedStatement ps = null;
	
	ResultSet rs = null;
	
	JTextField text1; JTextField text2; JTextField text3; JTextField text4;
	JTextField text5; JTextField text6; JTextField text7;
	
	DefaultTableModel model;
	JTable table;
	
	
	public Student() {
		
		setTitle("학생 데이터 베이스");
		
		JPanel panel1 = new JPanel();
		JPanel panel2 = new JPanel();
		JPanel panel3 = new JPanel();
		
		JPanel folder = new JPanel(new BorderLayout());
		
		JLabel label1 = new JLabel("학번 ");
		text1 = new JTextField(10);
		
		JLabel label2 = new JLabel("이름 ");
		text2 = new JTextField(10);
		
		JLabel label3 = new JLabel("학과 ");
		text3 = new JTextField(10);
		
		JLabel label4 = new JLabel("학년 ");
		text4 = new JTextField(10);
		
		JLabel label5 = new JLabel("나이 ");
		text5 = new JTextField(10);
		
		JLabel label6 = new JLabel("연락처 ");
		text6 = new JTextField(10);
		
		JLabel label7 = new JLabel("주소 ");
		text7 = new JTextField(10);
		
		
		String[] header = {"학번", "이름", "학과", "학년", "나이", "연락처", "가입일", "주소"};
		model = new DefaultTableModel(header, 0);
		table = new JTable(model);
		table.setAutoResizeMode(table.AUTO_RESIZE_ALL_COLUMNS);
		JScrollPane scroll = new JScrollPane(table, ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED,
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);
		
		JButton button1 = new JButton("전체목록");
		JButton button2 = new JButton("학생추가");
		JButton button3 = new JButton("학생수정");
		JButton button4 = new JButton("학생삭제");
		
		panel1.add(label1); panel1.add(text1);
		panel1.add(label2); panel1.add(text2);
		panel1.add(label3); panel1.add(text3);
		
		panel2.add(label4); panel2.add(text4);
		panel2.add(label5); panel2.add(text5);
		panel2.add(label6); panel2.add(text6);
		panel2.add(label7); panel2.add(text7);
		
		folder.add(panel1, BorderLayout.NORTH); folder.add(panel2, BorderLayout.CENTER);
		
		panel3.add(button1); panel3.add(button2);
		panel3.add(button3); panel3.add(button4);
		
		add(folder, BorderLayout.NORTH);
		add(scroll, BorderLayout.CENTER);
		add(panel3, BorderLayout.SOUTH);
		
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(200, 200, 700, 300);
		setResizable(true);
		
		button1.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				connect();
				model.setRowCount(0);
				select();
			}
			
		});
		
		button2.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				connect();
				insert();
				model.setRowCount(0);
				select();
			}
			
		});
		
		button3.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				connect();
				update();
				model.setRowCount(0);
				select();
			}
		});
		
		button4.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				int select = JOptionPane.showConfirmDialog(null, model.getValueAt(table.getSelectedRow(), 1) + 
						" 학생의 데이터를 삭제하시겠습니까?", "확인", JOptionPane.YES_NO_OPTION);
				
				if(select == JOptionPane.CLOSED_OPTION) {
					JOptionPane.showMessageDialog(null, "데이터를 삭제하지 않았습니다.");
				} else if(select == JOptionPane.YES_OPTION) {
					connect(); delete();
					
					model.removeRow(table.getSelectedRow());
				}
			}
		});
	
	}
	
	void connect() {
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		
		String user = "WebData"; String pw = "sungja";
		
		try {
			Class.forName(driver);
			
			connection = DriverManager.getConnection(url, user, pw);			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	void select() {
		
		String sql = "SELECT * FROM STUDENTS ORDER BY STUNUMBER";
		try {
			
			ps = connection.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Object[] objects = {rs.getInt("STUNUMBER"), rs.getString("NAME"), rs.getString("MAJOR"),
						rs.getInt("GRADE"), rs.getInt("OLD"), rs.getString("PHONE"), rs.getString("REGDATE"), rs.getString("ADDRESS")
				};
				
				objects[6] = objects[6].toString().substring(0, 10);
				
				model.addRow(objects);
			}
			
			rs.close(); ps.close(); connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	void insert() {

		try {
			String sql = "INSERT INTO STUDENTS VALUES(?, ?, ?, ?, ?, ?, SYSDATE, ?)";
			ps = connection.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(text1.getText())); ps.setString(2, text2.getText());
			ps.setString(3, text3.getText()); ps.setInt(4, Integer.parseInt(text4.getText()));
			ps.setInt(5, Integer.parseInt(text5.getText()));
			ps.setString(6, text6.getText()); ps.setString(7, text7.getText());
			
			int result = ps.executeUpdate();
			
			if(result > 0) {
				JOptionPane.showMessageDialog(null, text2.getText() + " 학생의 데이터가 추가되었습니다.", "INFO", JOptionPane.INFORMATION_MESSAGE);
			} else {
				JOptionPane.showMessageDialog(null, "Error Occured. Please request administrator");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	void update() {
	
		String sql = "UPDATE STUDENTS SET NAME = ?, MAJOR = ?, GRADE = ?, "
				+ "OLD = ?, PHONE = ?, ADDRESS = ? WHERE STUNUMBER = ?";
		
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(7, Integer.parseInt(text1.getText())); ps.setString(1, text2.getText());
			ps.setString(2, text3.getText()); ps.setInt(3, Integer.parseInt(text4.getText()));
			ps.setInt(4, Integer.parseInt(text5.getText()));
			ps.setString(5, text6.getText()); ps.setString(6, text7.getText());
			
			int result = ps.executeUpdate();
			
			if(result > 0) {
				JOptionPane.showMessageDialog(null, text2.getText() + " 학생의 데이터가 수정되었습니다.", "INFO", JOptionPane.INFORMATION_MESSAGE);
			} else {
				JOptionPane.showMessageDialog(null, "Error Occured. Please request administrator");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	void delete() {
		
		String sql = "DELETE FROM STUDENTS WHERE STUNUMBER = ?";
		
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, (int)model.getValueAt(table.getSelectedRow(), 0));
			
			int result = ps.executeUpdate();
			
			if(result > 0) {
				JOptionPane.showMessageDialog(null, (String)model.getValueAt(table.getSelectedRow(), 1) + 
						" 학생의 데이터가 삭제되었습니다.", "INFO", JOptionPane.OK_OPTION);
			} else {
				JOptionPane.showMessageDialog(null, "Error Occured. Please request administrator");
			}
			
			ps.close(); connection.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}
	
	public static void main(String[] args) {
		Student student = new Student();
	}
}