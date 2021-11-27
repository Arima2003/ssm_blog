package com.wanghao.ssm.Test;

import com.github.pagehelper.PageHelper;
import com.wanghao.ssm.Dao.DepartmentMapper;
import com.wanghao.ssm.Dao.EmployeeMapper;
import com.wanghao.ssm.Entity.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @Class-NAME pageTest
 * @Author wanghao
 * @Date 2021/11/22
 * @Description:
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class pageTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void selectAllStuByPage()
    {

        EmployeeMapper employeeDao = sqlSession.getMapper (EmployeeMapper.class);
        //3.调用PageHelper的方法进行分页
        PageHelper.startPage (1,3);
        List<Employee> employees = employeeDao.selectByExampleWithDept (null);
        employees.forEach (employee -> System.out.println (employee));

    }


    //    /**
//     * 查询员工数据 (使用分页查询)
//     * @return
//     */
//    @RequestMapping("/emps")
//    public String getEmployees(@RequestParam(value = "pageNo",defaultValue = "1") Integer pageNo, Model model)//获取pageNo 当前页数
//    {
//        //引入PageHelper分页插件
//        PageHelper.startPage (pageNo,5);
//        List<Employee> employees = employeeService.getAllEmployee ();
//        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面,pageInfo封装了详细的信息,导航栏页数为5页
//        PageInfo pageInfo = new PageInfo (employees,5);
//        model.addAttribute ("PageInfo",pageInfo);
//        return "list";
//    }


}
