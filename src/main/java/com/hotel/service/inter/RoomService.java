package com.hotel.service.inter;

import com.hotel.entity.QueryItem;

/**
 * Created by Wong on 2017/5/28.
 */
public interface RoomService {
    QueryItem roomListinPage(Integer page, Integer rows);

    QueryItem showRoomByCategory(String category, Integer page, Integer rows);

    QueryItem showRoomByStatus(Integer status, Integer page, Integer rows);
}
