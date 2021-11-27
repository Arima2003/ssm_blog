package com.wanghao.ssm.Dao;

import com.wanghao.ssm.Entity.User;

/**
 * @Class-NAME UserMapper
 * @Author wanghao
 * @Date 2021/11/25
 * @Description:
 **/
public interface UserMapper {
    User IsContainUser(String userName);
}
