package com.hotel.controller;

import com.hotel.entity.QueryItem;
import com.hotel.entity.Room;
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
}
