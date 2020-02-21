package com.atguigu.crud.controller;
/*
处理员工CRUD请求
 */
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 员工删除方法(包括单个删除和批量删除)
     * 单个删除：1
     * 批量删除：1-2-3
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        //批量删除
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /**
     * 员工更新方法
     * 如果直接发送ajax=PUT请求
     * 封装的数据
     *
     * 问题：
     * 请求体中有数据但是Employee对象封装不上
     * 1.这是Tomcat将请求体中的数据封装为一个map
     * 2.request.getParameter("empName")就会从这个map中取值
     * 3，SpringMVC封装POJO对象的时候会把POJO中每个属性的值，调用request.getParamter("email");
     *
     * 1,Ajax发送PUT请求引发的血案：
     * 2,即便是用HttpServletRequest 中的getParameter("gender")也请求不到任何数据，即便是ajax请求体中封装好了数据
     * 3,PUT请其遗体，请求体中的数据request.getParamter("gender")拿不到
     * 4,根本原因就是Tomcat一看是PUT就不会封装请求体中的数据为map,只有POST形式的请求才封装请求体为map
     *
     * 解决：
     * 1，我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 2，配置上HttpPutFormContentFilter
     * 3，HttpPutFormContentFilter的作用就是将请求体中的数据解析包装成一个map
     * 4，reuqest被重新包装，getParameter（）方法被重写，就会冲自己封装的map中取数据
     *
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){

        employeeService.updateEmp(employee);
        return  Msg.success();
    }

    /**
     * 查询员工
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName){
        //先判断用户是否是合法的表达式
        String regx = "(^[a-zA-Z0-9]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名可以是2-5中文或者6-16位英文和数字的组合(后端校验)");
        }
        //用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用(后端)");
        }
    }

    /**
     * 员工保存
     * 1,支持JSR303校验
     * 2，导入Hibernate-Validator
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验不成功，返回失败,在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors){
                System.out.println("错误的字段名" + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用PageHelper方法，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps =  employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
        //PageInfo封装了详细的分页信息，包括我们查出来的数据，列如，第一页，最后一页,方法内传入的第二个参数，就是连续现实的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo", page);
    }

    //查询员工数据(分页查询)
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用PageHelper方法，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps =  employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
        //PageInfo封装了详细的分页信息，包括我们查出来的数据，列如，第一页，最后一页,方法内传入的第二个参数，就是连续现实的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo", page);
        return "list";
    }

}
