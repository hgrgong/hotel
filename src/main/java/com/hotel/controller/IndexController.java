package com.hotel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Wong on 2017/5/25.
 */

@Controller
public class IndexController {

    @RequestMapping("/")
    private String showIndex() {
        return "login";
    }

    @RequestMapping("/{page}")
    private String page(@PathVariable String page) {
        return page;
    }
}
