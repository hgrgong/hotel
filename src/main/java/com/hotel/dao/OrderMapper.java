package com.hotel.dao;

import com.hotel.entity.Order;

import java.util.List;

/**
 * Created by Wong on 2017/5/28.
 */
public interface OrderMapper {

    // select all the order
    List<Order> selectAll();

    // select order by roomId
    List<Order> selectByRoomId(Integer roomId);

    // select order by userId
    List<Order> selectByUserId(Integer userId);

    // delete order
    void delete(Integer orderId);
}
