package com.hotel.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hotel.dao.UserMapper;
import com.hotel.entity.User;
import com.hotel.entity.QueryItem;
import com.hotel.service.inter.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wong on 2017/5/25.
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper mapper;
    @Override
    public QueryItem showUserList(Integer page, Integer rows) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<User> users = mapper.selectAll();
        PageInfo<User> info = new PageInfo<>(users);
        // 获取分页信息
        List<User> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public QueryItem selectUserByUserName(Integer page, Integer rows, String name) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<User> users = mapper.selectCriteriaUserByName(name);
//        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + users.get(0));
        PageInfo<User> info = new PageInfo<>(users);
        // 获取分页信息
        List<User> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public QueryItem selectUserByUserId(Integer page, Integer rows, Integer userId) {
        // 设置分页
        PageHelper.startPage(page, rows);
        // 执行查询
        List<User> users = mapper.selectById(userId);
//        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + users.get(0));
        PageInfo<User> info = new PageInfo<>(users);
        // 获取分页信息
        List<User> list = info.getList();
        long total = info.getTotal();
        // 添加到 QueryItem 对象中
        QueryItem item = new QueryItem();
        item.setRows(list);
        item.setTotal(total);
        return item;
    }

    @Override
    public List<User> selectUserById(Integer id) {
        List<User> users = mapper.selectById(id);
        return users;
    }

    @Override
    public void deleteUser(Integer id) {
        mapper.deleteById(id);
    }
}
