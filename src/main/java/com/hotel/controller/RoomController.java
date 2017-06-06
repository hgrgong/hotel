package com.hotel.controller;

import com.hotel.entity.QueryItem;
import com.hotel.entity.Room;
import com.hotel.service.inter.RoomService;
import com.hotel.util.Response;
import com.hotel.util.ResponseUtil;
import org.omg.PortableInterceptor.SUCCESSFUL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Created by Wong on 2017/5/29.
 */
@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService service;
    @Autowired
    private ResponseUtil reUtil;

    @RequestMapping("/list")
    @ResponseBody
    private Map<String, Object> showRoomList(@RequestParam("offset") Integer page,
                                             @RequestParam("limit") Integer rows,
                                             @RequestParam("searchType") String searchType,
                                             @RequestParam("keyWord") String keyWord) {
        Response response = reUtil.newResponseInstance();
        // 根据搜索类型，获取查询的分页结果
        QueryItem rooms;
        // searchType的值：searchAll、searchByCategory、searchByStatus
        switch (searchType) {
            case "searchAll":
            case "none":
                rooms = service.roomListinPage(page / rows + 1, rows);
                break;
            case "searchByCategory":
                // keyWord的值：single、double、family
                rooms = service.showRoomByCategory(keyWord, page / rows + 1, rows);
                break;
            default:
                // keyWord的值：null、notNull、noRent
                Integer status;
                if (keyWord.equals("null")) {
                    status = 0;
                } else if (keyWord.equals("notNull")) {
                    status = 1;
                } else {
                    status = 2;
                }
                rooms = service.showRoomByStatus(status, page / rows + 1, rows);
                break;
        }
        // 添加到返回对象中
        response.setSelfContent("rows", rooms.getRows());
        response.setSelfContent("total", rooms.getTotal());
        return response.generateInstance();
    }

    @RequestMapping("/updateRoom")
    @ResponseBody
    private Map<String, Object> updateRoom(@RequestParam("roomID") Integer id) {
        Response response = reUtil.newResponseInstance();
        Room room = service.showRoomById(id);
        if (room.getStatus() == 1) {
            response.setResponseResult(Response.RESULT_ERROR);
            return response.generateInstance();
        }
        room.setStatus(2);
        response.setResponseResult(Response.RESULT_SUCCESS);
        service.updateStatus(room);
        return response.generateInstance();
    }

    @RequestMapping(value = "/updatePrice", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> updatePrice(@RequestBody Map<String, Object> data) {
        // 获取 Response 对象
        Response response = reUtil.newResponseInstance();
        // 获取 data 里的请求参数
        String roomType = (String) data.get("roomType");
        Integer price = Integer.parseInt((String)data.get("price"));
        // 根据roomType查询房价 type: single、double、family
        Integer oldPrice = service.showPriceByCategory(roomType);
        response.setResponseResult(Response.RESULT_ERROR);
        // 取三种房价
        int singlePrice = service.showPriceByCategory("single").intValue();
        int doublePrice = service.showPriceByCategory("double").intValue();
        int familyPrice = service.showPriceByCategory("family").intValue();
        // 简单判断价钱的合理与否
        if (oldPrice.equals(price)) {
            response.setResultMSG("priceNoChange");
            return response.generateInstance();
        }
        if (roomType.equals("single")) {
            if (price <= 0 || price >= doublePrice) {
                response.setResultMSG("priceUnreasonable");
                return response.generateInstance();
            }
        }
        if (roomType.equals("double")) {
            if (price < 100 || price >= familyPrice) {
                response.setResultMSG("priceUnreasonable");
                return response.generateInstance();
            }
        }
        if (roomType.equals("family")){
            if (price <= doublePrice) {
                response.setResultMSG("priceUnreasonable");
                return response.generateInstance();
            }
        }
        service.updatePriceByCategory(price.intValue(), roomType);
        response.setResponseResult(Response.RESULT_SUCCESS);
        return response.generateInstance();
    }

    @RequestMapping(value = "/addRoom", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> addRoom(@RequestParam("roomType") String category) {
        // 获取 Response 对象
        Response response = reUtil.newResponseInstance();
        // 获取 Room 对象，补全属性
        Room room = new Room();
        room.setStatus(0);
        room.setCategory(category);
        room.setPrice(service.showPriceByCategory(category));
        service.addRoom(room);
        response.setResponseResult(Response.RESULT_SUCCESS);
        return response.generateInstance();
    }
}
