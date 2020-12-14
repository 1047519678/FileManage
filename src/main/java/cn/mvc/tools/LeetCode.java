package cn.mvc.tools;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;


public class LeetCode {

    public LeetCode() {
    }

    /**
     * 有效括号的最大深度
     * @param s
     * @return
     */
    public static int isValid(String s) {
        int temp_max = 0;
        if (s == null || "".equals(s)) {
            return 0;
        }
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            switch (c) {
                case '(':
                    stack.push(c);
                    break;
                case '{':
                    stack.push(c);
                    break;
                case '[':
                    stack.push(c);
                    break;
                case ')':
                    if (!stack.empty() && stack.peek() == '(') {
                        temp_max = Math.max(temp_max, stack.size());
                        stack.pop();
                    } else {
                        return 0;
                    }
                    break;
                case '}':
                    if (!stack.empty() && stack.peek() == '{') {
                        temp_max = Math.max(temp_max, stack.size());
                        stack.pop();
                    } else {
                        return 0;
                    }
                    break;
                case ']':
                    if (!stack.empty() && stack.peek() == '[') {
                        temp_max = Math.max(temp_max, stack.size());
                        stack.pop();
                    } else {
                        return 0;
                    }
                    break;
            }
        }
        if (stack.empty())
            return temp_max;
        return 0;
    }

    /**
     * 两数之和
     * @param nums
     * @param target
     * @return
     */
    public static int[] twoSum(int[] nums, int target) {
        for (int i = 0; i < nums.length - 1; i++) {
            for (int j = nums.length - 1; j > i; j--) {
                if (nums[i] + nums[j] == target) {
                    return new int[] {i,j};
                }
            }
        }
        return new int[0];
    }

    /**
     * 数组动态和
     * @param nums
     * @return
     */
    public static int[] runningSum(int[] nums){
        int[] result = new int[nums.length];
        int temp = 0;
        for (int i = 0;i<result.length;i++) {
            temp = temp + nums[i];
            result[i]=temp;
        }
        return result;
    }

    /**
     * 1672.二维数组最大值
     * @param accounts
     * @return
     */
    public static int maximumWealth(int[][] accounts) {
        for (int i = 0;i<accounts.length;i++){
            for (int j = 1;j<accounts[i].length;j++){
                accounts[i][0] += accounts[i][j];
            }
            accounts[0][0] = Math.max(accounts[0][0], accounts[i][0]);
        }
        return accounts[0][0];
    }

    /**
     * 62.一个机器人位于一个 m x n 网格的左上角。
     * 机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角。
     * 问总共有多少条不同的路径？
     * @param m
     * @param n
     * @return
     */
    public static int uniquePaths(int m, int n) {
        int[][] result = new int[m][n];
        for(int i = 0;i < m;i++){
            result[i][0] = 1;
        }
        for(int j = 0;j < n;j++){
            result[0][j] = 1;
        }
        for(int i = 1;i < m;i++){
            for(int j = 1;j < n;j++){
                result[i][j] = result[i-1][j] + result[i][j-1];
            }
        }
        return result[m-1][n-1];
    }

    public static int uniquePathsWithObstacles(int[][] obstacleGrid) {
        int m = obstacleGrid[0].length;
        int[] f = new int[m];
        f[0] = obstacleGrid[0][0] == 0 ? 1 : 0;
        for (int[] ints : obstacleGrid) {
            for (int j = 0; j < m; ++j) {
                if (ints[j] == 1) {
                    f[j] = 0;
                    continue;
                }
                if (j - 1 >= 0 && ints[j - 1] == 0) {
                    f[j] += f[j - 1];
                }
            }
        }
        return f[m - 1];
    }

    /**
     * 给定一个包含非负整数的 m x n 网格 grid ，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。
     * 说明：每次只能向下或者向右移动一步。
     * @param grid
     * @return
     */
    public static int minPathSum(int[][] grid) {
        if (grid == null || grid.length < 1 || grid[0] == null || grid[0].length < 1) {
            return 0;
        }
        int row = grid.length;
        int col = grid[0].length;
        int[][] dp = new int[row][col];
        dp[0][0] = grid[0][0];
        for (int i = 1;i < row;i++) {
            dp[i][0] = dp[i - 1][0] + grid[i][0];
        }
        for (int j = 1;j < col;j++) {
            dp[0][j] = dp[0][j - 1] + grid[0][j];
        }
        for (int i = 1;i < row;i++) {
            for (int j = 1;j < col;j++) {
                dp[i][j] = Math.min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j];
            }
        }
        return dp[row - 1][col - 1];
    }

    public static int minPathSum1(int[][] grid) {
        for(int i = 0; i < grid.length; i++) {
            for(int j = 0; j < grid[0].length; j++) {
                if(i == 0 && j == 0){}
                else if(i == 0)  grid[i][j] = grid[i][j - 1] + grid[i][j];
                else if(j == 0)  grid[i][j] = grid[i - 1][j] + grid[i][j];
                else grid[i][j] = Math.min(grid[i - 1][j], grid[i][j - 1]) + grid[i][j];
            }
        }
        return grid[grid.length - 1][grid[0].length - 1];
    }
}


