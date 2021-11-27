package com.wanghao.ssm.Test;

import com.wanghao.ssm.Dao.DepartmentMapper;
import com.wanghao.ssm.Dao.EmployeeMapper;
import com.wanghao.ssm.Entity.Department;
import com.wanghao.ssm.Entity.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.UUID;

/**
 * @Class-NAME MapperTest
 * @Author wanghao
 * @Date 2021/11/22
 * @Description:测试Dao
 * 可以使用Spring的单元测试,就可以自动注入我们需要的组件
 * 导入spring test的jar包
 * @
 * @ContextConfiguration 指定Spring配置文件的位置
 **/
@RunWith (SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;


    @Test
    public void testInsertDept()
    {
        //创建IOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext ("applicationContext.xml");
        //从IOC容器中获取对象
//        DepartmentMapper departmentMapper = ioc.getBean (DepartmentMapper.class);
//        System.out.println (departmentMapper);

//        departmentMapper.insertSelective (new Department (1,"财务部"));
//        departmentMapper.insertSelective (new Department (null,"人力资源部"));
//        departmentMapper.insertSelective (new Department (null,"后勤部"));
//        departmentMapper.insertSelective (new Department (null,"技术部"));
//        departmentMapper.insertSelective (new Department (null,"安全质量监察部"));
        departmentMapper.insertSelective (new Department (null,"总经理办公室"));

    }

    @Test
    public void insertEmployeeTest()
    {
//        employeeMapper.insertSelective (new Employee(null,"张三","男","12342134@qq.com",1));
//        批量插入
        EmployeeMapper employDao = sqlSession.getMapper (EmployeeMapper.class);
        for(int i=0;i<30;i++)
        {
            String uid = UUID.randomUUID ().toString ().substring (0,4)+i;
            employDao.insertSelective (new Employee (null,uid,"男",uid+i+"@qq.com",2));
        }
    }

}
