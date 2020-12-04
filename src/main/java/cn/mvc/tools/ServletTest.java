package cn.mvc.tools;

import cn.mvc.pojo.FileData;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ServletTest extends HttpServlet {
    private static final long serialVersionUID = -3975198861489446336L;
    private String message;

    public void init() throws ServletException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> json = new HashMap<>();
        String userName = request.getParameter("userName");
        String passWord = request.getParameter("passWord");
        List<Object> dataList = new ArrayList<>();
        dataList.add(userName);
        dataList.add(passWord);
        json.put("code", 1);
        json.put("msg", "API TEST！");
        json.put("count", "API TEST！");
        json.put("data", dataList);
        response.getWriter().println(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> json = new HashMap<>();
        String userName = request.getParameter("userName");
        String passWord = request.getParameter("passWord");
        List<Object> dataList = new ArrayList<>();
        dataList.add(userName);
        dataList.add(passWord);
        json.put("code", 1);
        json.put("msg", "API TEST！");
        json.put("count", "API TEST！");
        json.put("data", dataList);
        response.getWriter().println(json);
    }
}
