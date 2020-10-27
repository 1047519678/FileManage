package cn.mvc.interceptor;


import cn.mvc.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //获得请求的URL
        String url = httpServletRequest.getRequestURI();
        HttpSession session = httpServletRequest.getSession();
        User user = (User) session.getAttribute("user");
        Map<String, String> permissions = (Map<String, String>) session.getAttribute("permissions");
        if (url.contains("/checkLogin") || url.contains("/userLogin") || url.contains("/css/") || url.contains("/js/") || url.contains("/img/") || url.contains("/layui/")) {
            return true;
        }

        if (user != null) {
            if (url.contains("/jumpFileInfo") || url.contains("/showTable") || url.contains("/selTable")) {
                if (permissions != null && permissions.get("SuperAdmin") != null) {
                    return true;
                } else {
                    //httpServletResponse.setCharacterEncoding("UTF-8");
                    httpServletResponse.setContentType("text/html; charset=utf-8");
                    httpServletResponse.getWriter().write("<script>alert('无此权限！');</script>");
                    httpServletResponse.getWriter().flush();
                    return false;
                }
            } else {
                return true;
            }
            //return true;
        }

        httpServletRequest.setAttribute("msg", "您还没登录，请先登录！");
        httpServletRequest.getRequestDispatcher("/user/userLogin").forward(httpServletRequest, httpServletResponse);
        return false;

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }

}
