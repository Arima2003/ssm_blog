package com.wanghao.ssm.Controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xpath.internal.operations.Mod;
import com.wanghao.ssm.Entity.Employee;
import com.wanghao.ssm.Entity.Message;
import com.wanghao.ssm.Service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Class-NAME EmployeeController
 * @Author wanghao
 * @Date 2021/11/22
 * @Description:
 * 处理员工的CRUD请求
 **/
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;
    /**
     * 显示全部员工信息
     * 导入jackSon包
     * @param pageNo
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody //自动将字符串解析为Json格式
    public Message getEmpsWithJson(@RequestParam(value = "pageNo",defaultValue = "1") Integer pageNo)
    {
        //引入PageHelper分页插件
        PageHelper.startPage (pageNo,8);
        List<Employee> employees = employeeService.getAllEmployee ();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面,pageInfo封装了详细的信息,导航栏页数为5页
        PageInfo pageInfo = new PageInfo (employees,5);
        return Message.Success ().add ("pageInfo",pageInfo);
    }


    /**
     * 添加员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Message saveDept(@Valid Employee employee, BindingResult result)
    {
        if(result.hasErrors ())
        {
            Map<String,Object> map = new HashMap ();
            List<FieldError> fieldErrors = result.getFieldErrors ();
            fieldErrors.forEach (fieldError -> {
                System.out.println (fieldError);
                map.put (fieldError.getField (),fieldError.getDefaultMessage ());
            });
            return Message.Failure ().add ("errorFields",map);
        }else {
            employeeService.saveEmployee (employee);
            return Message.Success ();
        }
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkEmpname")
    @ResponseBody
    public Message checkEmpname(@RequestParam("empName") String empName)
    {
        String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches (reg))
        {
            return Message.Failure ().add ("va_msg","用户名不可用！");
        }
        boolean checkEmpoyee = employeeService.checkEmpoyee (empName);
        if(checkEmpoyee)
        {
            return Message.Success ();
        }else{
            return Message.Failure ();
        }
    }

    /**
     * 查询修改的员工信息，显示在修改模态框中
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Message GetEmp(@PathVariable("id") Integer id)
    {
        Employee employee = employeeService.getEmp (id);
        return Message.Success ().add ("Employee",employee);
    }

    /**
     * 更新员工信息
     * 当Ajax直接发送PUT请求之时，会无法封装请求体中的数据 生成pojo
     *
     * Ajax  不能直接发送PUT请求
     * 原因：
     * Tomcat会将请求体中的数据封装成一个Map
     * 当SpringMVC封装pojo对象的时候
     * 通过getParameter获取 请求域的值 赋值给 pojo的属性
     * 但是 Tomcat一看是PUT请求便不会将请求体中的数据进行封装，只有POST请求才会被封装为Map
     *
     * 解决：
     * 在web.xml文件中 配置 过滤器 HttpPutFormContentFilter
     * 会将请求体中的数据解析包装为一个map，request被重新包装，request.getParameter被重写
     *
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Message saveEmp(Employee employee)
    {
        int updateEmp = employeeService.updateEmp (employee);
        return Message.Success ();
    }

    /**
     * 删除员工 /可批量删除
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Message delEmployee(@PathVariable("ids") String ids)
    {
        if(ids.contains ("-"))
        {
            //批量删除
            String[] str_ids = ids.split ("-");
            List<Integer> deList = new ArrayList<> ();
            for (String str_id : str_ids) {
                deList.add (Integer.parseInt (str_id));
            }
            employeeService.delBatch(deList);
            return Message.Success ();
        }else {
            //单个删除
            Integer id = Integer.parseInt (ids);
            int delEmpoyeeInfo = employeeService.delEmpoyeeInfo (id);
            return Message.Success ();
        }
    }

}

















