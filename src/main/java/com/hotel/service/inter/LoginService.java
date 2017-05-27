package com.hotel.service.inter;

import com.hotel.entity.Admin;

/**
 * Created by Wong on 2017/5/25.
 */
public interface LoginService {

    Admin check(String name);
}
