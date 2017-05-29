package com.hotel.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hotel.dao.RoomMapper;
import com.hotel.entity.QueryItem;
import com.hotel.entity.Room;
import com.hotel.service.inter.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Wong on 2017/5/28.
 */
@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    private RoomMapper mapper;

    @Override
    public QueryItem roomListinPage(Integer page, Integer rows) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<Room> rooms = mapper.selectAll();
        PageInfo<Room> info = new PageInfo<>(rooms);
        // 获取分页信息
        List<Room> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public QueryItem showRoomByCategory(String category, Integer page, Integer rows) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<Room> rooms = mapper.selectByCategory(category);
        PageInfo<Room> info = new PageInfo<>(rooms);
        // 获取分页信息
        List<Room> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public QueryItem showRoomByStatus(Integer status, Integer page, Integer rows) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<Room> rooms = mapper.selectByStatus(status);
        PageInfo<Room> info = new PageInfo<>(rooms);
        // 获取分页信息
        List<Room> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }
}
