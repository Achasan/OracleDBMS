package sist;

//사번 이름 담당업무
// 관리자 no 급여 보너스 부서번호
// JTABLE
// 전체목록 사원목록 사원수정 사원삭제 


import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

public class EMP extends JFrame{
	
	Connection connection = null;
	
	PreparedStatement ps = null;
	
	ResultSet rs = null;
	
	String sql = null;
	
	DefaultTableModel model;
	
	JComboBox<String> job2;
	JComboBox<String> managerNo2;
	JComboBox<String> deptNo2;
	JTextField empno2;
	JTextField name2;
	JTextField salary2;
	JTextField bonus2;
	JTable table;
	
	
	public EMP() {
		
		setTitle("EMP");
		
		JPanel panel1 = new JPanel();
		JPanel panel2 = new JPanel();
		JPanel panel3 = new JPanel(new BorderLayout());
		
		JPanel panel4 = new JPanel();
		
		JLabel empno1 = new JLabel("사번 ");
		empno2 = new JTextField(5);
		
		JLabel name1 = new JLabel("이름 ");
		name2 = new JTextField(10);
		
		JLabel job1 = new JLabel("담당업무 ");
		job2 = new JComboBox<String>();
		job2.addItem("선택");
		
		JLabel managerNo1 = new JLabel("관리자번호 ");
		managerNo2 = new JComboBox<String>();
		managerNo2.addItem("선택");
		
		JLabel salary1 = new JLabel("급여 ");
		salary2 = new JTextField(10);
		
		JLabel bonus1 = new JLabel("인센티브 ");
		bonus2 = new JTextField(10);
		
		JLabel deptNo1 = new JLabel("부서번호 ");
		deptNo2 = new JComboBox<String>();
		deptNo2.addItem("선택");
		
		String[] header = {"사번", "이름", "담당업무", "관리자번호", "입사일", "급여", "인센티브", "부서번호"};
		model = new DefaultTableModel(header, 0);
		table = new JTable(model);
		JScrollPane scroll = new JScrollPane(table, 
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED, 
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);
		
		
		DefaultTableCellRenderer cell = new DefaultTableCellRenderer();
		cell.setHorizontalAlignment(JLabel.CENTER);
		table.getColumnModel().getColumn(0).setCellRenderer(cell);
		table.getColumnModel().getColumn(1).setCellRenderer(cell);
		table.getColumnModel().getColumn(2).setCellRenderer(cell);
		table.getColumnModel().getColumn(3).setCellRenderer(cell);
		table.getColumnModel().getColumn(4).setCellRenderer(cell);
		table.getColumnModel().getColumn(7).setCellRenderer(cell);
	
		
		JButton button1 = new JButton("사원목록");
		JButton button2 = new JButton("사원추가");
		JButton button3 = new JButton("사원수정");
		JButton button4 = new JButton("사원삭제");
		
		panel1.add(empno1); panel1.add(empno2);
		panel1.add(name1); panel1.add(name2);
		panel1.add(job1); panel1.add(job2);
		
		panel2.add(managerNo1); panel2.add(managerNo2);
		panel2.add(salary1); panel2.add(salary2);
		panel2.add(bonus1); panel2.add(bonus2);
		panel2.add(deptNo1); panel2.add(deptNo2);
		
		panel3.add(panel1, BorderLayout.NORTH);
		panel3.add(panel2, BorderLayout.CENTER);
		
		panel4.add(button1); panel4.add(button2);
		panel4.add(button3); panel4.add(button4);
		
		add(panel3, BorderLayout.NORTH);
		add(scroll, BorderLayout.CENTER);
		add(panel4, BorderLayout.SOUTH);
		
		connect(); comboJob(); comboMgr(); comboDept();
		
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setResizable(false);
		setBounds(200,200,800,300);
		
		
		button1.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				connect(); model.setRowCount(0); select();
			}
		});
		
		button2.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {

				int select = JOptionPane.showConfirmDialog(null, name2.getText() + " 사원 데이터를 추가하시겠습니까?", "Confirm",
						JOptionPane.YES_NO_OPTION);
	
				if(select == JOptionPane.YES_OPTION) {
					connect(); insert(); model.setRowCount(0); select();
					
					empno2.setText(null); name2.setText(null);
					salary2.setText(null); bonus2.setText(null);
					job2.setSelectedIndex(0); managerNo2.setSelectedIndex(0);
					deptNo2.setSelectedIndex(0); empno2.requestFocus();
				}
			}
		});
		
		button3.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				int select = JOptionPane.showConfirmDialog(null, empno2.getText() + " 사번의 데이터를 수정하시겠습니까?", "Confirm",
						JOptionPane.YES_NO_OPTION);
				
				if(select == JOptionPane.YES_OPTION) {
					connect(); update(); model.setRowCount(0); select();
					
					empno2.setText(null); name2.setText(null);
					salary2.setText(null); bonus2.setText(null);
					job2.setSelectedIndex(0); managerNo2.setSelectedIndex(0);
					deptNo2.setSelectedIndex(0); empno2.requestFocus();
				}
			}
		});
		
		button4.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				int select = JOptionPane.showConfirmDialog(null, "선택한 데이터를 삭제하실건가요?", "Confirm",
						JOptionPane.YES_NO_OPTION);
				
				if(select == JOptionPane.YES_OPTION) {
					connect(); delete(); model.removeRow(table.getSelectedRow());
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	void comboJob() {
		
		try {
			sql = "SELECT DISTINCT JOB FROM EMP ORDER BY JOB";
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				job2.addItem(rs.getString("JOB"));
			}
			
			rs.close(); ps.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	void comboDept() {
		
		try {
			sql = "SELECT DEPTNO, DNAME FROM DEPT ORDER BY DEPTNO";
			
			ps = connection.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				deptNo2.addItem(rs.getString("DEPTNO") + " : " + rs.getString("DNAME"));
			}
			
			rs.close(); ps.close(); connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
	}
	
	
	void comboMgr() {
		
		sql = "SELECT EMPNO, ENAME FROM EMP WHERE JOB = 'MANAGER' ORDER BY EMPNO";
		try {
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				managerNo2.addItem(rs.getString("EMPNO") + " : " + rs.getString("ENAME"));
			}
			
			ps.close(); rs.close(); 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	void select() {
		sql = "SELECT * FROM EMP ORDER BY EMPNO";
		
		try {
			ps = connection.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Object[] objects = {rs.getString("EMPNO"), rs.getString("ENAME"), rs.getString("JOB"),
						rs.getString("MGR"), rs.getString("HIREDATE").substring(0, 10), "$"+rs.getString("SAL"), "$"+rs.getInt("COMM"),
						rs.getString("DEPTNO")};
				
				model.addRow(objects);
			}
			
			ps.close(); rs.close(); connection.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	void insert() {
		sql = "INSERT INTO EMP VALUES(?, ?, ?, ?, SYSDATE, ?, ?, ?)";
		
		try {
			ps = connection.prepareStatement(sql);
	
			ps.setInt(1, Integer.parseInt(empno2.getText())); ps.setString(2, name2.getText());
			ps.setString(3, (String)job2.getSelectedItem()); 
			ps.setInt(4, Integer.parseInt(managerNo2.getSelectedItem().toString().substring(0, 4)));
			ps.setInt(5, Integer.parseInt(salary2.getText()));
			ps.setInt(6, Integer.parseInt(bonus2.getText()));
			ps.setInt(7, Integer.parseInt(deptNo2.getSelectedItem().toString().substring(0,2)));
			
			int result = ps.executeUpdate();
			
			if(result > 0) {
				JOptionPane.showMessageDialog(null, "사원 데이터가 추가되었습니다.", "INFO", JOptionPane.INFORMATION_MESSAGE);
			} else {
				JOptionPane.showMessageDialog(null, "오류 발생, 관리자에게 문의하세요.", "Error", JOptionPane.ERROR_MESSAGE);
			}
			
			ps.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	void update() {
		sql = "UPDATE EMP SET ENAME = ?, JOB = ?, MGR = ?, SAL = ?, COMM = ?, DEPTNO = ?"
				+ " WHERE EMPNO = ?";
		
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, name2.getText()); ps.setString(2, (String)job2.getSelectedItem());
			ps.setInt(3, Integer.parseInt(managerNo2.getSelectedItem().toString().substring(0,4)));
			ps.setInt(4, Integer.parseInt(salary2.getText())); ps.setInt(5, Integer.parseInt(bonus2.getText()));
			ps.setInt(6, Integer.parseInt(deptNo2.getSelectedItem().toString().substring(0, 2)));
			ps.setInt(7, Integer.parseInt(empno2.getText()));
			
			int result = ps.executeUpdate();
			
			if(result > 0) {
				JOptionPane.showMessageDialog(null, "사원 데이터가 수정되었습니다.", "INFO", JOptionPane.INFORMATION_MESSAGE);
			} else {
				JOptionPane.showMessageDialog(null, "오류 발생, 관리자에게 문의하세요.", "Error", JOptionPane.ERROR_MESSAGE);
			}
			
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
	}
	
	
	void delete() {
		sql = "DELETE FROM EMP WHERE EMPNO = ?";
		
		try {
			ps = connection.prepareStatement(sql);
			
			ps.setInt(1, Integer.parseInt((String)model.getValueAt(table.getSelectedRow(), 0)));
			
			int result = ps.executeUpdate();
			
			if(result > 0) {
				JOptionPane.showMessageDialog(null, (String)model.getValueAt(table.getSelectedRow(), 1)
						+ "데이터가 삭제되었습니다.", "INFO", JOptionPane.INFORMATION_MESSAGE);
			} else {
				JOptionPane.showMessageDialog(null, "오류 발생, 관리자에게 문의하세요.", "Error", JOptionPane.ERROR_MESSAGE);
			}
			
			ps.close(); connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		new EMP();
	}
}