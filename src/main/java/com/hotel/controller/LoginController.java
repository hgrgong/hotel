package com.hotel.controller;

import com.hotel.entity.Admin;
import com.hotel.service.inter.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Wong on 2017/5/25.
 */
@Controller
public class LoginController {

    @Autowired
    private LoginService service;
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    private Admin login(@RequestParam("name") String name, @RequestParam("password") String password) {
        Admin admin = service.check(name, password);
        return admin;
    }
}
