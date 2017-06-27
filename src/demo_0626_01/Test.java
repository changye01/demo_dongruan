package demo_0626_01;

import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String user="root";
		String password ="0000";
		String url="jdbc:mysql://localhost:3306/xuanke";
		
//		是一个java类 注意大小写
		String driver ="com.mysql.jdbc.Driver";
		
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		获取数据库连接
		try {
			java.sql.Connection conn=DriverManager.getConnection(url, user, password);
			if(conn!=null){
				System.out.println("connection success");
				
			}else {
				System.out.println("connection failed");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
