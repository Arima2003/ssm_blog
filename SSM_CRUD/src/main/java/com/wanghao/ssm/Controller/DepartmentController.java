package com.wanghao.ssm.Controller;

import com.wanghao.ssm.Entity.Department;
import com.wanghao.ssm.Entity.Message;
import com.wanghao.ssm.Service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Class-NAME DepartmentController
 * @Author wanghao
 * @Date 2021/11/23
 * @Description:
 * 处理和部门相关的请求
 **/
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Message getDeptMsg()
    {
        List<Department> deptMessage = departmentService.getDeptMessage ();
        //响应给服务器查询到的部门信息
        return Message.Success ().add ("deptMsg",deptMessage);
    }



}















