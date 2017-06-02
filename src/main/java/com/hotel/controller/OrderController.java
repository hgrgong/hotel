package com.hotel.controller;

import com.hotel.entity.Order;
import com.hotel.entity.QueryItem;
import com.hotel.entity.Room;
import com.hotel.entity.User;
import com.hotel.service.inter.OrderService;
import com.hotel.service.inter.RoomService;
import com.hotel.service.inter.UserService;
import com.hotel.util.Response;
import com.hotel.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Created by Wong on 2017/5/31.
 */
@RequestMapping("/order")
@Controller
public class OrderController {

    @Autowired
    private OrderService service;
    @Autowired
    private ResponseUtil util;
    @Autowired
    private RoomService rService;
    @Autowired
    private UserService uService;

    @RequestMapping("/showList")
    @ResponseBody
    private Map<String, Object> showOrderList(@RequestParam("offset") Integer page,
                                              @RequestParam("limit") Integer rows,
                                              @RequestParam("searchType") String searchType,
                                              @RequestParam("keyWord") Integer keyWord) {
        // 获取 Response 对象
        Response response = util.newResponseInstance();
        // 获取 QueryItem 对象
        QueryItem item;
        // 根据 searchType 来执行查询, 值有：searchAll、searchByUserID、searchOrderByRoomId
        if (searchType.equals("searchAll") || searchType.equals("none")) {
            item = service.showOrderList(page / rows + 1, rows);
        } else if (searchType.equals("searchByUserID")) {
            item = service.selectOrderByUserId(page / rows + 1, rows, keyWord);
        } else {
            item = service.selectOrderByRoomId(page / rows + 1, rows, keyWord);
        }
        // 添加到返回对象中
        response.setSelfContent("rows", item.getRows());
        response.setSelfContent("total", item.getTotal());
        return response.generateInstance();
    }

    @RequestMapping("/updateOrder")
    @ResponseBody
    private Map<String, Object> updateOrder(@RequestBody Map<String, Object> data) {

        // 获取 Response 对象
        Response response = util.newResponseInstance();
        // 获取 data 的信息
        Integer roomId = Integer.parseInt((String) data.get("roomId"));
        Integer orderId = (Integer) data.get("orderId");
        Integer livingDays = Integer.parseInt((String) data.get("livingDays"));
        Room room = rService.showRoomById(roomId);
        Order order = service.selectById(orderId);
        if (room.getStatus() == 1) {
            response.setResponseResult(Response.RESULT_ERROR);
            if (order.getRoomId().equals(roomId) && livingDays.equals(order.getLiveDays()) || !(order.getRoomId().equals(roomId))) {
                return response.generateInstance();
            }
        } else {
            // 跟新 Room 表, 把当前房间置为已住
            room.setStatus(1);
            rService.updateStatus(room);
            response.setResponseResult(Response.RESULT_SUCCESS);
        }
        // 跟新 Order 表
        response.setResponseResult(Response.RESULT_SUCCESS);
        if (!order.getRoomId().equals(roomId)) {
            // 跟新 Room 表, 把之间房间置为未住
            room = rService.showRoomById(order.getRoomId());
            room.setStatus(0);
            rService.updateStatus(room);
        }
        order.setRoomId(roomId);
        order.setLiveDays(livingDays);
        service.update(order);
        return response.generateInstance();
    }

    @RequestMapping(value = "/addOrder", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> addOrder(@RequestBody Map<String, Object> data) {
        // 获取 response 对象
        Response response = util.newResponseInstance();
        // 获取 data 中的数据
        Integer userID = Integer.parseInt((String) data.get("userID"));
//        System.out.println(userID);
        Integer roomID = Integer.parseInt((String) data.get("roomID"));
//        System.out.println(roomID);
        Integer livingDays = Integer.parseInt((String) data.get("livingDays"));
//        System.out.println(livingDays);
        // 判断用户是否存在
        QueryItem item = uService.selectUserByUserId(1, 10, userID);
        System.out.println(item.getTotal());
        if (item.getTotal() <= 0 || rService.showRoomById(roomID).getStatus() == 1) {
            response.setResponseResult(Response.RESULT_ERROR);
        } else {
            response.setResponseResult(Response.RESULT_SUCCESS);
            // order 插入记录
            Order order = new Order();
            order.setUserId(userID);
            order.setRoomId(roomID);
            order.setLiveDays(livingDays);
            service.addOrder(order);
            // 跟新 room 表状态
            Room room = rService.showRoomById(roomID);
            room.setStatus(1);
            rService.updateStatus(room);
        }
        return response.generateInstance();
    }

    @RequestMapping(value = "/deleteOrder", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> addOrder(@RequestParam("orderID") Integer orderID) {
        // 获取 response 对象
        Response response = util.newResponseInstance();
        // 跟新房间状态
        Order order = service.selectById(orderID);
        Integer roomId = order.getRoomId();
        Room room = rService.showRoomById(roomId);
        room.setStatus(0);
        rService.updateStatus(room);
        // 删除订单
        service.deleteOrder(orderID);
        response.setResponseResult(Response.RESULT_SUCCESS);
        return response.generateInstance();
    }
}

