package demo_0621_01;

public class StringDemo_01 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String noString="610123123312341234";
		char s=noString.charAt(16);
		//char 类型的数据在算术运算中自动转换为对应的AscII值
		int a=s-48;
		if(s%2==0){
			System.out.println("female");
			
		}
		else {
			System.out.println("male");
		}
		String yString=noString.substring(6,10);
		String mString=noString.substring(10,12);
		String dString=noString.substring(12,14);
		System.out.println(yString+"-"+mString+"-d");
	}

}
