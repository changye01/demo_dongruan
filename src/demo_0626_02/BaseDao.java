package demo_0626_02;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 负责执行 各种 sql语句
 * 
 *
 */
import com.mysql.jdbc.ResultSetMetaData;
public class BaseDao {
	/**
	 * insert
	 * update
	 * delete
	 * @param sql
	 * @param params
	 * @return
	 */
	public int excuteUpdate(String sql,List<String> params ) {
		String user = "root";
		String password = "0000";
		String url = "jdbc:mysql://127.0.0.1:3306/course_selection"
				+ "?useUnicode=true&characterEncoding=utf-8";
		String driver = "com.mysql.jdbc.Driver";
		int row = 0;
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			Connection conn=DriverManager.getConnection(url, user, password);
			//根据sql 构建执行的对象
			PreparedStatement stmt=conn.prepareStatement(sql);
			//判断 sql中是否有 ? 
			if (params!=null) {
//				说明 List 集合中有数据，那就证明 sql中有 ?
				for(int i=0;i<params.size();i++){
				//集合 下标 为 0 的值 赋值给 第 1 个 ？
				stmt.setString(i+1, params.get(i));
				}
				row=stmt.executeUpdate();
				stmt.close();
				conn.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return row;
	}
	
	public List<Map<String, String>> executeQuery(String sql,List<String> params) {
		List<Map<String, String>> list=
				new ArrayList<Map<String,String>>();
		String user = "root";
		String password = "0000";
		String url = "jdbc:mysql://127.0.0.1:3306/course_selection"
				+ "?useUnicode=true&characterEncoding=utf-8";
		String driver = "com.mysql.jdbc.Driver";
		int row = 0;
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			//与数据库建立连接
			Connection conn = DriverManager.getConnection(url, user, password);
			PreparedStatement stmt = conn.prepareStatement(sql);
					       
			if(params != null){
				for(int i=0;i<params.size();i++){
				     stmt.setString(i+1, params.get(i));
				}
				
				ResultSet rst=stmt.executeQuery();
				//获取查询的列信息
				java.sql.ResultSetMetaData metaData=rst.getMetaData();
				//获取查询的列 数
				int count=metaData.getColumnCount();
				//构建存放 列名的容器 数组
				String[] names =new String[count];
				//获取每一列 的列名
				for (int i = 0; i < count; i++) {
					names[i]=metaData.getColumnLabel(i+1);
				}
				//存放查询的每一行记录
				Map<String, String> map=null;
				while (rst.next()) {
					//构建装载 一行 数据的 容器
					map=new HashMap<String, String>();
//					把每一行 中的每一列 放入Map中
					for (int i = 0; i < count; i++) {
						String name=names[i];
						String value =rst.getString(name);
						map.put(name, value);
					}
					//把该行记录 存入到List 中
					list.add(map);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
