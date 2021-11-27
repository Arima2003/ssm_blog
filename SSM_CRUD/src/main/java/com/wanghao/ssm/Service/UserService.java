package com.wanghao.ssm.Service;

import com.wanghao.ssm.Dao.UserMapper;
import com.wanghao.ssm.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Class-NAME UserService
 * @Author wanghao
 * @Date 2021/11/25
 * @Description:
 **/
@Service
public class UserService {
    @Autowired
    private UserMapper userDao;


    public User IsContainUser(String userName) {
        User user = userDao.IsContainUser (userName);
        return user;
    }
}
