package com.hotel.service.impl;

import com.hotel.dao.AdminMapper;
import com.hotel.entity.Admin;
import com.hotel.service.inter.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Wong on 2017/5/25.
 */

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private AdminMapper mapper;

    @Override
    public Admin check(String name, String password) {
        Admin admin = mapper.selectByName(name);
        if (admin.getPassword().equals(password)) {
            return admin;
        } else {
            return null;
        }
    }
}
