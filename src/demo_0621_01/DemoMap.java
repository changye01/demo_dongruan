package demo_0621_01;

import java.util.HashMap;
import java.util.Map;

public class DemoMap {

	public static void main(String[] args){ 
		// TODO Auto-generated method stub
		//null 为不存在
		Map<String, String> map=new HashMap<String,String>();
		map.put("no","T01001");
		map.put("name", "赵日天");
		map.put("age", "888");
		map.put("salary", "666");
		map.put("name", "泰迪");
		
		System.out.println(map.size());
		System.out.println(map);
		
		String no=map.get("no");
		System.out.println(no);
	}

}
