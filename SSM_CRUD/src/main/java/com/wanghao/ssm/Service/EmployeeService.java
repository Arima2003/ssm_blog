package com.wanghao.ssm.Service;

import com.wanghao.ssm.Dao.EmployeeMapper;
import com.wanghao.ssm.Entity.Employee;
import com.wanghao.ssm.Entity.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Class-NAME EmployeeService
 * @Author wanghao
 * @Date 2021/11/22
 * @Description:
 **/
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeDao;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAllEmployee() {
        return employeeDao.selectByExampleWithDept (null);
    }

    public void saveEmployee(Employee employee) {
        employeeDao.insertSelective (employee);
    }

    public boolean checkEmpoyee(String empName) {
        EmployeeExample example = new EmployeeExample ();
        EmployeeExample.Criteria criteria = example.createCriteria ();
        criteria.andEmpNameEqualTo (empName);
        long countByExample = employeeDao.countByExample (example);
        return countByExample==0;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeDao.selectByPrimaryKey (id);
        return employee;
    }

    public int updateEmp(Employee employee) {
        int update = employeeDao.updateByPrimaryKeySelective (employee);
        return update;
    }

    public int delEmpoyeeInfo(Integer id) {
        int del = employeeDao.deleteByPrimaryKey (id);
        return del;
    }

    public int delBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample ();
        EmployeeExample.Criteria criteria = example.createCriteria ();
        //delete form xx where id in(id1,id2,id3...)
        criteria.andEmpIdIn (ids);
        int delete = employeeDao.deleteByExample (example);
        return delete;
    }
}








