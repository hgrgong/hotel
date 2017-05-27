package com.hotel.controller;

import com.hotel.entity.Admin;
import com.hotel.service.inter.LoginService;
import com.hotel.util.Response;
import com.hotel.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    private Map<String, Object> login(@RequestBody Map<String, Object> user) {
        // 初始化Response
        Response response = reUtil.newResponseInstance();
        String resultStatus = response.RESULT_ERROR;
        String msg = "";

        String name = (String) user.get("name");
        String password = (String) user.get("password");
        Admin admin = service.check(name);
        if (admin == null) {
            msg = "unknownAccount";
        } else if (!admin.getPassword().equals(password)) {
            msg = "wrongPassword";
        } else {
            resultStatus = response.RESULT_SUCCESS;
        }
        response.setResponseResult(resultStatus);
        response.setResultMSG(msg);
        return response.generateInstance();
    }
}
