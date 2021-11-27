package com.wanghao.ssm.Test;

import com.github.pagehelper.PageInfo;
import com.wanghao.ssm.Entity.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @Class-NAME MVCTest
 * @Author wanghao
 * @Date 2021/11/22
 * @Description:
 **/
@RunWith (SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"classpath:applicationContext.xml","classpath:SpringMVC.xml"})
public class MVCTest {
    //闯入SpringMVC的ioc
    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求 ，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc()
    {
        MockMvc mockMvc = MockMvcBuilders.webAppContextSetup (context).build ();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform (MockMvcRequestBuilders.get ("/emps").param ("pageNo", "1")).andReturn ();
        //请求成功以后，请求域中会有pageInfo，我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest ();
        PageInfo pageInfo =(PageInfo)request.getAttribute ("PageInfo");
        System.out.println ("当前页码："+pageInfo.getPageNum ());
        System.out.println ("总页码："+pageInfo.getPages ());
        System.out.println ("总记录数："+pageInfo.getTotal ());
        System.out.println ("页面的导航页码：");
        int[] navigatepageNums = pageInfo.getNavigatepageNums ();
        for (int navigatepageNum : navigatepageNums) {
            System.out.print (navigatepageNum+" ");
        }
        //获取员工数据
        List<Employee> list = pageInfo.getList ();
        list.forEach (employee -> System.out.println (employee));
    }
}
