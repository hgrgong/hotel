package com.hotel.controller;

import com.hotel.entity.Order;
import com.hotel.entity.QueryItem;
import com.hotel.entity.Room;
import com.hotel.service.inter.OrderService;
import com.hotel.service.inter.RoomService;
import com.hotel.util.Response;
import com.hotel.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
}

