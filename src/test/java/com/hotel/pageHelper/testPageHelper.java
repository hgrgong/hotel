package com.hotel.pageHelper;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hotel.dao.RoomMapper;
import com.hotel.entity.Room;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by Wong on 2017/5/29.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext.xml")
public class testPageHelper {
    @Autowired
    private RoomMapper mapper;
    @Test
    public void test() {
        // 设置分页
        PageHelper.startPage(1, 10);
        // 执行查询
        List<Room> rooms = mapper.selectAll();
        // 获取分页结果
        PageInfo<Room> pageInfo = new PageInfo<Room>(rooms);
        List<Room> list = pageInfo.getList();
        list.forEach(System.out::println);
        System.out.println("Pages: " + pageInfo.getPages());
        System.out.println("PageTotal: " + pageInfo.getTotal());
        System.out.println("PageSize: " + pageInfo.getPageSize());
    }
}
