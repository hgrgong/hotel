package com.hotel.dao;

import com.hotel.entity.Admin;

/**
 * Created by Wong on 2017/5/25.
 */
public interface AdminMapper {

    // select admin by name
    Admin selectByName(String name);
    // update admin by name
    void update(Admin admin);
}
