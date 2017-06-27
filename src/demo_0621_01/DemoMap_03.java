package demo_0621_01;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import javax.print.DocFlavor.INPUT_STREAM;

public class DemoMap_03 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner scanner=new Scanner(System.in);
		System.out.println("请输入一个字符串");
		
		
		String str=scanner.nextLine();
		Map<String, Integer> map=new HashMap<String, Integer>();
		
		
		for(int i=0;i<str.length();i++){
			
			String n=str.substring(i,i+1);
			Integer cInteger=map.get(n);
			
			
			if(cInteger==null){
				cInteger=1;
			}else {
				cInteger++;
			}
			
			
			map.put(n, cInteger);
			
		}
		for(Map.Entry<String, Integer> entry:map.entrySet()){
			//entry.getkey()   entry.getvalue()
			
			
			String key=entry.getKey();
			Integer value=entry.getValue();
			
			
			System.out.println(key+"="+value);
		}
	}

}
