package com.hotel.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Wong on 2017/6/12.
 */
public class FirstInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
//        System.out.println("Hello");
        String username =  (String)request.getSession().getAttribute("userName");
        if(username == null){
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
            return false;
        }else
            return true;
    }
}
