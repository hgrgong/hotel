package com.hotel.dao;

import com.hotel.entity.User;

import java.util.List;

/**
 * Created by Wong on 2017/5/24.
 */
public interface UserMapper {
    List<User> selectAll();
}
