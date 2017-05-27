package com.hotel.mysql;

import com.hotel.dao.UserMapper;
import com.hotel.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import java.util.List;

/**
 * Created by Wong on 2017/5/24.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext.xml")
public class Connect {

/*    private ApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring/" +
                                            "spring-dao.xml");*/
    @Autowired
    private UserMapper userMapper;

    @Test
    public void testQueryAll() {
        List<User> users = userMapper.selectAll();
        users.forEach(System.out::println);
    }

    @Test
    public void testQuery() {
        User user = userMapper.selectById(2);
        System.out.println(user);
/*        User user = new User();
        user.setName("UncleStan");
        user.setGender("man");
        user.setPassword("twins");
        user.setMobile("18237927384");
        user.setEmail("stan@163.com");
        userMapper.insert(user);*/
    }
}
