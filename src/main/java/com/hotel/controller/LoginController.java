package com.hotel.controller;

import com.hotel.entity.Admin;
import com.hotel.service.inter.LoginService;
import com.hotel.util.Response;
import com.hotel.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Created by Wong on 2017/5/25.
 */
@Controller
@RequestMapping("/account")
public class LoginController {

    @Autowired
    private ResponseUtil reUtil;
    @Autowired
    private LoginService service;
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> login(@RequestBody Map<String, Object> user, HttpServletRequest request) {
        // 初始化Response
        Response response = reUtil.newResponseInstance();
        String resultStatus = response.RESULT_ERROR;
        String msg = "";

        String name = (String) user.get("name");
        String password = (String) user.get("password");
        Admin admin = service.getAdmin(name);
        if (admin == null) {
            msg = "unknownAccount";
        } else if (!admin.getPassword().equals(password)) {
            msg = "wrongPassword";
        } else {
            resultStatus = response.RESULT_SUCCESS;
        }
        HttpSession session = request.getSession();
        session.setAttribute("userName", name);
        response.setResponseResult(resultStatus);
        response.setResultMSG(msg);
        return response.generateInstance();
    }

    @RequestMapping("/logout")
    @ResponseBody
    private Map<String, Object> logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        session.removeAttribute("userName");
        Response response = reUtil.newResponseInstance();
        response.setResponseResult(response.RESULT_SUCCESS);
        return response.generateInstance();
    }

    @RequestMapping(value = "/changePassword", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> changePassword(@RequestBody Map<String, Object> data,
                                               HttpServletRequest request) {
        // 获取 Response 对象
        Response response = reUtil.newResponseInstance();
        response.setResponseResult(Response.RESULT_ERROR);
        // 通过 session 获取要修改密码的用户名
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        // 查询获得 Admin 对象
        Admin admin = service.getAdmin(userName);
        // 获得用户原来的密码
        String passwd = admin.getPassword();
        // 对比原来密码与用户提交的旧密码
        String oldPassword = (String) data.get("oldPassword");
        String newPassword = (String) data.get("newPassword");
        if (!passwd.equals(oldPassword)) {
            response.setResultMSG("passwordError");
        } else if(passwd.equals(newPassword)) {
            response.setResultMSG("passwordNotChange");
        } else {
            admin.setPassword(newPassword);
            service.changePassword(admin);
            response.setResponseResult(Response.RESULT_SUCCESS);
        }

        return response.generateInstance();
    }
}
