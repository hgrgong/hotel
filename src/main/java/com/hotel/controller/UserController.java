package com.hotel.controller;

import com.hotel.entity.Order;
import com.hotel.entity.QueryItem;
import com.hotel.service.inter.OrderService;
import com.hotel.service.inter.UserService;
import com.hotel.util.Response;
import com.hotel.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Created by Wong on 2017/6/1.
 */
@RequestMapping("/user")
@Controller
public class UserController {
    @Autowired
    private UserService service;
    @Autowired
    private OrderService oService;
    @Autowired
    private ResponseUtil util;

    @RequestMapping("/showList")
    @ResponseBody
    private Map<String, Object> showUserList(@RequestParam("offset") Integer page,
                                             @RequestParam("limit") Integer rows,
                                             @RequestParam("searchType") String searchType,
                                             @RequestParam("keyWord") String keyWord) {
        // 获取 Response 对象
        Response response = util.newResponseInstance();
        // 获取 QueryItem 对象
        QueryItem item;
        // 根据 searchType 来执行查询, 值有：searchAll、searchByUserID、searchUserByUserName
        if (searchType.equals("searchAll") || searchType.equals("none")) {
            item = service.showUserList(page / rows + 1, rows);
        } else if (searchType.equals("searchByUserID")) {
            item = service.selectUserByUserId(page / rows + 1, rows, Integer.parseInt(keyWord));
        } else {
            item = service.selectUserByUserName(page / rows + 1, rows, keyWord);
        }
        // 添加到返回对象中
        response.setSelfContent("rows", item.getRows());
        response.setSelfContent("total", item.getTotal());
        return response.generateInstance();
    }

    @RequestMapping("/deleteUser")
    @ResponseBody
    private Map<String, Object> deleteUser(@RequestParam("userID") Integer userID) {
        // 获取 Response 对象
        Response response = util.newResponseInstance();
        // 删除之前查看该用户是否有订单
        List<Order> orders = oService.selectByUserId(userID);
        if (orders != null && orders.size() > 0) {
            response.setResponseResult(Response.RESULT_ERROR);
            return response.generateInstance();
        } else {
            response.setResponseResult(Response.RESULT_SUCCESS);
            service.deleteUser(userID);
        }
        return response.generateInstance();
    }
}
