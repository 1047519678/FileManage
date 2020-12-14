package cn.mvc.tools;

import sun.applet.Main;

import java.util.Arrays;
import java.util.Scanner;

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
    }
}
