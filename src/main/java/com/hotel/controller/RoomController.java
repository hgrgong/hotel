package com.hotel.controller;

import com.hotel.entity.QueryItem;
import com.hotel.service.inter.RoomService;
import com.hotel.util.Response;
import com.hotel.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
                // keyWord的值：null、notNull
                Integer status = keyWord.equals("null") ? 0 : 1;
                rooms = service.showRoomByStatus(status, page / rows + 1, rows);
                break;
        }
        // 添加到返回对象中
        response.setSelfContent("rows", rooms.getRows());
        response.setSelfContent("total", rooms.getTotal());
        return response.generateInstance();
    }
}
