package demo_0621_01;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class DemoMap_02 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner inputScanner=new Scanner(System.in);
		
		//用于存放所有的学生信息
		List<Map<String, String>> stusList=new ArrayList<Map<String,String>>();
		for(int i=0;i<2;i++){
			System.out.println("请输入第<"+i+">个学生的信息");
			System.out.println("学号");
			String noString=inputScanner.next();
			System.out.println("name");
			String nameString=inputScanner.next();
			System.out.println("gender");
			String sexString=inputScanner.next();
			System.out.println("WeChat");
			String wechatsString=inputScanner.next();
			Map<String, String> stu=new HashMap<String, String>();
			
			stu.put("no", noString);
			stu.put("name", nameString);
			stu.put("gender", sexString);
			stu.put("wechat", wechatsString);
			//添加的容器中
			stusList.add(stu);
			
			
		}
		System.out.println("学生信息如下");
		System.out.println("学号\t姓名\t性别\t微信");
		for(Map<String, String> stu:stusList){
			String n=stu.get("no");
			String xm=stu.get("name");
			String sex=stu.get("gender");
			String wx=stu.get("wechat");
			System.out.println(n+"\t"+xm+"\t"+sex+"\t"+wx+"\t");
		}
	}

}
