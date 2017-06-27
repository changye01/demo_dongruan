package demo_0626_02;

import java.util.ArrayList;
import java.util.List;

public class Testbasedao {

	public static void main(String[] args) {
		String sqlString = "insert into course_info(c_name,c_grade)"
				+ " values (?,?)";
		List<String> paramsList = new ArrayList<String>();
		paramsList.add("android");
		paramsList.add("10");
        BaseDao dao = new BaseDao();
        int row = dao.excuteUpdate(sqlString, paramsList);
        System.out.println(row);
	}


}
