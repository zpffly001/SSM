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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap/js/jquery-3.3.1.min.js"></script>
    <!--使用静态资源库的方法引入bootstrap.min.js-->
    <!--<script> src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"</script>-->
    <script> src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"</script>


</head>
<body>
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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <!--显示表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <!--表格的每一行-->
                    <tr>
                        <!--显示每一行的各个元素-->
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>

                    <c:forEach items="${pageInfo.list}" var="emp">

                        <!--表格的每一行-->
                        <tr>
                            <!--显示每一行的各个元素-->
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>操作</th>
                            <th>
                                <button class="btn btn-primary">
                                    <span class="glyphicon glyphicon-pencil btn-sm" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger">
                                    <span class="glyphicon glyphicon-trash btn-sm" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>

                    </c:forEach>

                </table>
            </div>
        </div>
        <!--显示分页信息-->
        <div class="row">
            <!--分页文字信息-->
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>
            <!--分页条信息-->
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>


</body>
</html>
