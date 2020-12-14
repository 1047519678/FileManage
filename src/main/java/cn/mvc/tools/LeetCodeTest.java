package cn.mvc.tools;

import cn.mvc.pojo.Email;
import sun.applet.Main;

import java.util.*;
import java.util.stream.Collectors;

public class LeetCodeTest {
    public static void main(String[] args) {
        // 字符串排序
        /*String sortStr = "azxcvGSDFbnm,gd313";
        char[] arrayCh = sortStr.toCharArray();
        Arrays.sort(arrayCh);
        String sortedStr=new String(arrayCh);
        System.out.println(sortedStr);*/
        /*Scanner in = new Scanner(System.in);
        int deepth = LeetCode.isValid(in.nextLine()) ;
        System.out.println(deepth) ;*/
        int[] a = {2,7,8,6,3,4,11,15};
        int[][] b = {{18,5,9},{5,9,7},{4,11,15}};
        int[][] c = {{0,1,0},{0,0,0},{0,0,0},{1,0,0},{0,0,0}};
        int[][] d = {{1,2,3},{3,5,1},{2,1,1},{4,6,2},{8,3,1}};
        System.out.println(Arrays.toString(LeetCode.runningSum(a)));
        System.out.println(LeetCode.maximumWealth(b));
        System.out.println(LeetCode.uniquePaths(4,5));
        System.out.println(LeetCode.uniquePathsWithObstacles(c));
        System.out.println(LeetCode.minPathSum1(d));


        List<String> list1 = new ArrayList<>();
        list1.add("123");
        list1.add("123");
        list1.add("456");
        list1.add("456");
        list1.add("789");
        list1.add("789");
        Email email1 = new Email();
        email1.setEmail("1324");
        email1.setCreateId(123);
        email1.setCreateTime("456");
        email1.setRank(123);
        Email email2 = new Email();
        email2.setEmail("123");
        email2.setCreateId(123);
        email2.setCreateTime("456");
        email2.setRank(123);
        List<Email> list2 = new ArrayList<>();
        list2.add(email1);
        list2.add(email2);
        List<String> list = new ArrayList<>(new LinkedHashSet<>(list1));
        List<String> myList = list1.stream().distinct().collect(Collectors.toList());
        List<Email> mapList =  list2.stream().filter(l -> l.getEmail().equals("123")).collect(Collectors.toList());
        System.out.println(list1);
        System.out.println(list);
        System.out.println(myList);
        System.out.println(mapList);
    }
}
