package com.hotel.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hotel.dao.OrderMapper;
import com.hotel.entity.Order;
import com.hotel.entity.QueryItem;
import com.hotel.service.inter.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Wong on 2017/5/28.
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper mapper;

    @Override
    public QueryItem showOrderList(Integer page, Integer rows) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<Order> orders = mapper.selectAll();
        PageInfo<Order> info = new PageInfo<>(orders);
        // 获取分页信息
        List<Order> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public QueryItem selectOrderByRoomId(Integer page, Integer rows, Integer roomId) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<Order> orders = mapper.selectByRoomId(roomId);
        PageInfo<Order> info = new PageInfo<>(orders);
        // 获取分页信息
        List<Order> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public QueryItem selectOrderByUserId(Integer page, Integer rows, Integer userId) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<Order> orders = mapper.selectByUserId(userId);
        PageInfo<Order> info = new PageInfo<>(orders);
        // 获取分页信息
        List<Order> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public Order selectById(Integer id) {
        Order order = mapper.selectById(id);
        return order;
    }

    @Override
    public List<Order> selectByUserId(Integer userId) {
        List<Order> orders = mapper.selectByUserId(userId);
        return orders;
    }

    @Override
    public void update(Order order) {
        mapper.update(order);
    }

    @Override
    public void addOrder(Order order) {
        mapper.addOrder(order);
    }

    @Override
    public void deleteOrder(Integer orderId) {
        mapper.delete(orderId);
    }
}
