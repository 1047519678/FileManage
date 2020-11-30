package cn.mvc.tools;

import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/hello1")
public class ServletTest extends HttpServlet {

    private static final long serialVersionUID = -7474770400283877799L;

    public void init() throws ServletException {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置响应内容类型
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        System.out.println(JSONObject.toJSONString(""));
        response.getWriter().println(JSONObject.toJSONString(""));

    }
}
