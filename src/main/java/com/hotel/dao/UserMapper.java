package com.hotel.dao;

import com.hotel.entity.User;

import java.util.List;

/**
 * Created by Wong on 2017/5/24.
 */
public interface UserMapper {
    // select all the user that living in the hotel
    List<User> selectAll();

    // select the specified user by given id
    User selectById(Integer id);

    // select by user by name
    User selectByName(String name);

    // select the users by fuzzy username
    List<User> selectCriteriaUserByName(String name);

    // insert user
    void insert(User user);

    // insert users once
    void insertBatch(List<User> users);

    // update user
    void update(User user);

    // delete user by id
    void deleteById(Integer id);

    // delete by name;
    void deleteByName(String name);
}
