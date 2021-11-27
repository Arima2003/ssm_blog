package com.wanghao.ssm.Service;

import com.wanghao.ssm.Dao.DepartmentMapper;
import com.wanghao.ssm.Entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Class-NAME DepartmentService
 * @Author wanghao
 * @Date 2021/11/23
 * @Description:
 **/
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departDao;

    public List<Department> getDeptMessage() {
        List<Department> departments = departDao.selectByExample (null);
        return departments;
    }











}
