package demo_0620_list;

import java.util.ArrayList;
import java.util.List;

public class demolist {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<String> list=new ArrayList<String>();
		
		list.add("你老子");
		list.add("你爸");
		list.add("你爹");
		list.add("你老子");
		//可重复
		//加入char
		//list.add(a+"")
		
		String str=list.get(0);
		System.out.println(str);

		for(int i=0;i<list.size();i++){
			
			String n=list.get(i);
			System.out.println(n);
		}
	}

}
