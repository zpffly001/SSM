package com.atguigu.crud.dao;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);

    //新增查询接口
    //也要在javabean里面新增属性来对应我们存储员工部门，并生成对应的get,set方法
    //还要在对应的mapper配置文件中编写与之对应的sql语句
    List<Employee> selectByExampleWithDept(EmployeeExample example);

    //新增查询接口
    //也要在javabean里面新增属性来对应我们存储员工部门，并生成对应的get,set方法
    //还要在对应的mapper配置文件中编写与之对应的sql语句
    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}