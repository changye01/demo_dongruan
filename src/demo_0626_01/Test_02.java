package demo_0626_01;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

import com.mysql.jdbc.PreparedStatement;

public class Test_02 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String user="root";
		String password ="0000";
		String url="jdbc:mysql://localhost:3306/course_selection";
		
//		是一个java类 注意大小写
		String driver ="com.mysql.jdbc.Driver";
		
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		Scanner inputScanner=new Scanner(System.in);
//		System.out.println("课程名称：");
//		String name=inputScanner.next();
//		System.out.println("学分：");
//		String grade=inputScanner.next();
		String c_nameString="lalalaa";
		int grade=4;
//		获取数据库连接
		try {
			java.sql.Connection conn=DriverManager.getConnection(url, user, password);
			if(conn!=null){
				System.out.println("connection success");
				
			}else {
				System.out.println("connection failed");
			}
			
//			编写sql语句
//			sql语句换行 必须添加空格
			String sql ="insert into"
					+" course_info(c_name,c_grade)"
					+" values(?,?)";
			String sql1="update course_info set c_name='jsp' where c_id=6";
			String sql2="delete from course_info where c_id=6";
			
			java.sql.PreparedStatement stmt =conn.prepareStatement(sql);
			stmt.setObject(1, c_nameString);
			stmt.setObject(2, grade);
			int row=stmt.executeUpdate(sql);
			if (row>0) {
				System.out.println("execute sussess");
			}else {
				System.out.println("execute failed");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
