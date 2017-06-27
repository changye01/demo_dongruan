package demo_0620_list;

import java.util.ArrayList;
import java.util.List;

public class demolist_02 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List list=new ArrayList();
		while(true){
			double r=Math.random()*35+1;
			int n=(int)r;
			
			if(list.contains(n)){
				continue;
			}
			
			list.add(n);
			if(list.size()==10){
				break;
			}
	
			System.out.println("loop");
			for(int i=0;i<list.size();i++){
				System.out.println(list.get(i));
			}
		}
		
	}

}
