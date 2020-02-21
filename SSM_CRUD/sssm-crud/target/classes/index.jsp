<%--
  Created by IntelliJ IDEA.
  User: 18137
  Date: 2020/2/12
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <!--<script src="${APP_PATH}/static/bootstrap/js/jquery-3.3.1.min.js"></script>
    <script> src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"</script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">-->
    <!-- web路径问题
    1，不以/开始的相对路径，找资源，以当前资源的路径为基准，容易出错
    2，以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:8080),需要加上项目名字本项目名字就是sssm-crud
      http://localhost:8080(服务器路径)/crud(当前资源路径)
    -->
    <!--引入Jquery
    <script src="${APP_PATH}/static/bootstrap/js/jquery-3.3.1.min.js"></script>
    引入样式
    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script> src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"</script> -->
    <!--<link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
    <!--<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>-->
    <!--使用静态资源库的方法引入bootstrap.min.js-->
    <!--<script> src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"</script>-->
</head>
<body>

<!-- Modal模态框-员工修改 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <!--指定使用哪个输入框的id即for="enpName_add_input"-->
                        <!--提交表单时SpringMvc能自动给我们封装为Employee对象，要求是name的值要和javabean中属性名相同-->
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@guigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptNmae</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal模态框-员工添加 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <!--指定使用哪个输入框的id即for="enpName_add_input"-->
                        <!--提交表单时SpringMvc能自动给我们封装为Employee对象，要求是name的值要和javabean中属性名相同-->
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="enpName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@guigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptNmae</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<!--搭建显示页面-->
<div class="container ">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮(两个包括增加和删除)-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <!--表头放在thead中-->
                <thead>
                <!--表格的每一行-->
                <tr>
                    <!--显示每一行的各个元素-->
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area"></div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>

<script type="text/javascript">

    var totalRecore,currentPage;

    //1页面加载完成后，直接发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_Page(1);
    });

    function to_Page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            //result就是服务器响应给浏览器的数据
            success:function (result) {
                //console.log(result);
                //1解析并显示员工数据
                build_emps_table(result);
                //2解析并显示分页信息
                buid_page_info(result);
                //3解析显示分页条信息
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var result = JSON.parse(result);
        //var emps = result.extend.pageInfo.list[1].dId;
        var emps = result.extend.pageInfo.list;
        //list包含了当前页的5个员工的数据,我们用jquery中自带的each()方法遍历，传入的第一个参数就是要遍历的元素即emps,第二个是每次遍历的回调函数
        //回调函数function中包含两个参数，第一个就是索引，第二个就是当前对象
        //每一个item就是list中的一个员工对象
        //$.each(emps, function (index, item) {
           // alert(item.empName);
        //});
        $.each(emps,function (index,item) {
            //单元格，即每一个员工的属性
            var checkBoxId = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            //构建按钮
            /**
             * <button class="btn btn-primary">
             <span class="glyphicon glyphicon-pencil btn-sm" aria-hidden="true"></span>
             编辑
             </button>
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加一个自定义的属性，来表示当前员工id
            delBtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append执行完成以后返回的还是原来的元素，所以能够链式操作
            $("<tr></tr>").append(checkBoxId)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function buid_page_info(result) {
        $("#page_info_area").empty();
        var result = JSON.parse(result);
        //找到这个<div>
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,总"+
            result.extend.pageInfo.pages +"页,总"+
            result.extend.pageInfo.total +"条记录");
        totalRecore = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var result = JSON.parse(result);
        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加单击翻页的事件
            firstPageLi.click(function () {
                to_Page(1);
            });
            prePageLi.click(function () {
                to_Page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if (result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            lastPageLi.click(function () {
                to_Page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_Page(result.extend.pageInfo.pageNum+1);
            });
        }

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);

        //1,2,3小页码,遍历ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_Page(item);
            });
            ul.append(numLi);
        })
        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul添加到nav
        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    //重置表单内容和样式
    function reset_form(ele){
        //重置表单内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清楚上一次提交的数据(表单重置)，要完整重置，输入框下面不能有上一次的校验信息(表单数据，表单的样式)
        reset_form("#empAddModal form");
        //$("#empAddModal form")[0].reset();
        //点击新增按钮之前因该向服务器ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //查出所有的部门信息，显示在下拉列表中
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                var result = JSON.parse(result);
                //显示部门信息的下拉列表
                //$("#empAddModal select").append()
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据
    function validate_add_from(){
        //1,拿到要校验的数据，使用正则表达式
        var empName = $("#enpName_add_input").val();
        var regName = /(^[a-zA-Z0-9]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)){
            //alert("用户名可以是2-5中文或者6-16位英文和数字的组合");
            //应该清空这个元素之前的样式
            show_validate_msg("#enpName_add_input","error","用户名可以是2-5中文或者6-16位英文和数字的组合");
            /*$("#enpName_add_input").parent().addClass("has-error");
            $("#enpName_add_input").next("span").text("用户名可以是2-5中文或者6-16位英文和数字的组合");*/
            return false;
        }else {
            show_validate_msg("#enpName_add_input","success","");
            /*$("#enpName_add_input").parent().addClass("has-success");
            $("#enpName_add_input").next("span").text("");*/
        }

        //2校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");*/
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
            /*$("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");*/
        }
        return true;
    }

    //显示当前结果校验信息
    function show_validate_msg(ele,status,msg){
        //清除当前元素校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if ("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用,当框中内容发生改变发送ajax请求
    $("#enpName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        //ajax要传给服务器的名称的值，就是当前输入框的值
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                var result = JSON.parse(result);
                if(result.code == 100){
                    show_validate_msg("#enpName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validate_msg("#enpName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //点击保存员工
    $("#emp_save_btn").click(function () {
        //1,模态框中填写的表单数据提交给服务器进行保存
        //1校验表单数据
        if (!validate_add_from()){
            return false;
        };
        //1判断之前的ajax用户名校验是否成功了，如果成功了，才往下继续走
       if ($(this).attr("ajax-va") == "error") {
           return false;
       }
        //2.发送ajax请求保存员工

        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                var result = JSON.parse(result);
                if (result.code == 100){
                    //员工保存成功后
                    //1，关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页，显示刚才保存的数据
                    to_Page(totalRecore);
                }else {
                    //显示失败信息
                    //有哪个字段的错误信息就显示哪个字段的
                    if (undefined != result.extend.errorFields.email){
                        //员工的邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName){
                        //员工的名字错误信息
                        show_validate_msg("#enpName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }
        });
    });

    //1.我们是按钮创建之前就绑定了click所以是绑定不上单击事件的
    //（1）我们可以在创建按钮的时候绑定事件（2）绑定单击事件.live()这是jquery中的方法，即使你后来添加新元素也行
    //jquery新版本没有live()，用On()进行替代
    $(document).on("click", ".edit_btn",function () {
        //1，查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        //2，查出员工信息
        getEmp($(this).attr("edit-id"));
        //3把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    })

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var result = JSON.parse(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name = gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId])
            }
        })
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        //1，校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");*/
            return false;
        }else {
            show_validate_msg("#email_update_input","success","");
            /*$("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");*/
        }

        //2，发送ajax请求保存跟新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+ $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                var result = JSON.parse(result);
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2，回到原本页面
                to_Page(currentPage);
            }
        })

    })

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        //1弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if (confirm("确认删除【" +empName+ "】 吗?")){
            //确认，发送ajax请求即可
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    var result = JSON.parse(result);
                    alert(result.msg);
                    //回到本页
                    to_Page(currentPage);
                }
            });
        }
    });

    //完成全选/全不选
    $("#check_all").click(function () {
        //attr获取checked是undefined
        //我们这些dom原生的属性用prop获取；attr获取自定义属性的值
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选择的元素个数是否为5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        //$(".check_item:checked")
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            //组装了提示员工信息字符串
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除empNames中多余的,
        empNames = empNames.substring(0, empNames.length-1);
        //去除要删除id中多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length-1);
        if (confirm("确认删除【" +empNames+ "】")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/" + del_idstr,
                type:"DELETE",
                success:function (result) {
                    var result = JSON.parse(result);
                    alert(result.msg);
                    //回到当前页面
                    to_Page(currentPage);
                }
            })
        }
    });

</script>

</body>
</html>
