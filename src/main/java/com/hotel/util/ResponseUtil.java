package com.hotel.util;

import org.springframework.stereotype.Component;

/**
 * Created by Wong on 2017/5/27.
 */
@Component
public class ResponseUtil {
    public Response newResponseInstance() {
        return new Response();
    }
}
