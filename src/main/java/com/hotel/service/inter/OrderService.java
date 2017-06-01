package com.hotel.service.inter;

import com.hotel.entity.Order;
import com.hotel.entity.QueryItem;

/**
 * Created by Wong on 2017/5/28.
 */
public interface OrderService {

    QueryItem showOrderList(Integer page, Integer rows);

    QueryItem selectOrderByRoomId(Integer page, Integer rows, Integer roomId);

    QueryItem selectOrderByUserId(Integer page, Integer rows, Integer userId);

    Order selectById(Integer id);

    void update(Order order);
}
