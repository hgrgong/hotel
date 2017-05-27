package com.hotel.util;

import org.apache.commons.collections.map.HashedMap;

import java.util.Map;

/**
 * Created by Wong on 2017/5/27.
 */
public class Response {

    public static final String RESULT_SUCCESS = "success";
    public static final String RESULT_ERROR = "error";
    // optional
    public static final String RESULT = "result";
    public static final String MSG = "msg";
    public static final String DATA = "data";
    public static final String TOTAL = "total";
    // 存储响应信息
    private Map<String, Object> content;
    // 构造器
    Response() {
        this.content = new HashedMap(10);
    }
    // 设置响应的状态，success or error
    public void setResponseResult(String result) {
        content.put(RESULT, result);
    }
    // 设置响应的信息
    public void setResultMSG(String msg) {
        content.put(MSG, msg);
    }
    // 设置响应的数据
    public void setResultData(Object data) {
        content.put(DATA, data);
    }
    // 设置响应携带的数据量
    public void setResultTotal(long total) {
        content.put(TOTAL, total);
    }
    // 自定义响应内容
    public void setSelfContent(String key, Object value) {
        content.put(key, value);
    }
    // 生成response对象
    public Map<String, Object> generateInstance() {
        return content;
    }
}
