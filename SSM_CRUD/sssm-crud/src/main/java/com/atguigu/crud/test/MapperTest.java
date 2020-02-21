package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/*
 测试dao层的工作
 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
  1,导入SpringTest的模块，即：jar包
  2使用@ContextConfiguration注解，指定spring配置文件的位置，自动帮我们创建出ioc容器
  3,直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    //测试DepartmentMapper,在Spring的配置文件中配置了扫描器，自动扫描mapper,能从spring容器中取到mapper文件
    @Test
    public void testCRUD(){
        /*System.out.println("success");
        //1.创建Spring IOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("amapplicationContext");
        System.out.println("success");
        //2.从容器中取出mapper
        DepartmentMapper bean =  ioc.getBean(DepartmentMapper.class);*/
        System.out.println(departmentMapper);
        //1.插入几个部门
        //departmentMapper.insertSelective(new Department(null, "开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));
        //2.生成员工数据,测试员工插入
        //employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));
        //3.批量插入多个员工，批量使用可以执行批量操作的sqlSession
        /*for (){
            employeeMapper.insertSelective(new Employee(null,,"M","Jerry@atguigu.com",1));
        }*/
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
        }

    }
}
