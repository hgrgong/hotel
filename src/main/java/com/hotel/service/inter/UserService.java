package com.hotel.service.inter;

import com.hotel.entity.QueryItem;
import com.hotel.entity.User;

import java.util.List;

/**
 * Created by Wong on 2017/5/25.
 */
public interface UserService {

    QueryItem showUserList(Integer page, Integer rows);

    QueryItem selectUserByUserName(Integer page, Integer rows, String name);

    QueryItem selectUserByUserId(Integer page, Integer rows, Integer userId);

    List<User> selectUserById(Integer id);

    void deleteUser(Integer id);
}
