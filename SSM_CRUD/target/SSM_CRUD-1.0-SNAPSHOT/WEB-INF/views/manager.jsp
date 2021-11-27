<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wangziao
  Date: 2021/11/22
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        pageContext.setAttribute ("BasePath", request.getContextPath ());
    %>
    <title>员工信息列表</title>
    <%--引入jquery--%>
    <script type="text/javascript" src="${BasePath}/static/js/jquery-1.12.4.min.js"></script>
    <%--引入样式--%>
    <link rel="stylesheet" href="${BasePath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${BasePath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工修改的模态框--%>
<!-- Modal -->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel_update">修改员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_update_form">
                    <div class="form-group">
                        <label for="add_empName" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <%--显示错误信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_empEmail" class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="update_empEmail"
                                   placeholder="请输入员工邮箱">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender"  value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender"  value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-10">
                            <%--提交部门 下拉列表--%>
                            <select class="form-control" name="dId" id="select_deptName"></select>
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


<%--员工添加的模态框--%>
<!-- Modal -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel_add">添加员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_add_form">
                    <div class="form-group">
                        <label for="add_empName" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input name="empName" type="text" class="form-control" id="add_empName"
                                   placeholder="请输入员工姓名" >
                            <%--显示错误信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="add_empEmail" class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="add_empEmail"
                                   placeholder="请输入员工邮箱">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="choice_gender1" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="choice_gender2" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-10">
                            <%--提交部门 下拉列表--%>
                            <select class="form-control" name="dId" id="select_deptName"></select>
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

<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <h1 class="col-md-12">员工管理</h1>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-6"></div>
        <button class="btn btn-primary"><span class="glyphicon glyphicon-plus" id="emp_add_model_btn"></span>添加</button>
        <button class="btn btn-danger"><span class="glyphicon glyphicon-trash" id="emp_del_all_btn"></span>删除</button>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="checkAll"/>全选
                    </th>
                    <th>员工编号</th>
                    <th>员工姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <%--员工数据--通过ajax获得--%>
                <tbody>

                </tbody>


            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"/>
    </div>
    <%--分页导航信息--%>
    <div class="col-md-6" id="page_nav_area"/>
</div>
<script type="text/javascript">
    var totalRecord;
    var currentPage;
    //页面加载完成后，发送ajax请求，服务端响应json数据，js解析json转化为json对象，将数据显示到视图页面上
    $(function () {
        to_page(1);
    });

    //获取分页数据 触发ajax请求
    function to_page(pageNo) {
        $.ajax({
            url: "${BasePath}/emps",//请求的地址
            data: "pageNo=" + pageNo,//发送的请求数据
            type: "get", //请求方式
            //请求成功后的回调函数
            success: function (result) { //result是服务器响应给浏览器的数据
                console.log(result)
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);
            }
        });
    }


    function build_emps_table(result) {
        //每次点击导航页，都要清空之前的页面显示信息 否则信息会叠加 达不到分页的效果
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            // alert(item.empName);
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empgenderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-info edit_btn").append($("<span></span>")
                .addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("EmpId",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger del_btn").append($("<span></span>")
                .addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("EmpId",item.empId);
            var BtnTd = $("<td></td>").append(editBtn).append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empgenderTd)
                .append(emailTd)
                .append(deptNameTd).append(BtnTd).appendTo("#emps_table tbody");
        })
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前位于第" + result.extend.pageInfo.pageNum + "页，" + "总共" + result.extend.pageInfo.pages + "页,"
            + "共" + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi)
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }



    //获取部门信息显示在下拉列表中
    function getDeptName(ele) {
        $(ele).empty();
        $.ajax({
            url: "${BasePath}/depts", //获取部门信息
            type: "GET",
            success: function (result) {
                // console.log(result);
                $.each(result.extend.deptMsg, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        });
    }

    function reset_form(ele){
        //重置表单内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //添加员工信息 弹出模态框
    $("#emp_add_model_btn").click(function () {
        //清楚上一次遗留的表单样式和数据
        reset_form("#empAddModel form");

        //获取部门信息显示在下拉列表中
        getDeptName("#empAddModel select");

        $("#empAddModel").modal({
            backdrop: 'static'
        });
    });

    //校验表单数据
    function validate_add_form() {
        var empName = $("#add_empName").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名不合规范，请输入2-5位中文子符或是6-16位英文数字组合！");
            //由于addClass 可能会添加在上一次的样式之上 造成错误，所以每次调用函数之时都应该清空上一次的样式或数据

            show_validate_msg("#add_empName", "error", "用户名不合规范，请输入2-5位中文子符或是6-16位英文数字组合");
            return false;
        } else {
            show_validate_msg("#add_empName", "success", "");
        }
        var email = $("#add_empEmail").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确！");
            show_validate_msg("#add_empEmail", "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg("#add_empEmail", "success", "");
        }
        return true;
    }

    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //发送Ajax请求校验用户名是否可用
    $("#add_empName").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${BasePath}/checkEmpname",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code == 200)
                {
                    show_validate_msg("#add_empName","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#add_empName","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        })
    });

    //保存按钮
    $("#emp_save_btn").click(function () {
        //将模态框中添加的员工信息提交给服务器进行保存
        //先进行数据格式校验
        if (!validate_add_form()) {
            return false; //格式不对 结束函数
        }
        //判断之前的用户名校验是否成功
       if($(this).attr("ajax-va")=="error")
       {
           return false;
       }
        //发送ajax请求
        //将表单中的name属性对应的信息序列化后传给服务器，服务器会自动将其封装成与之对应的javabean对象
        $.ajax({
            url: "${BasePath}/emp",
            type: "POST",
            data: $("#emp_add_form").serialize(),
            success: function (result) {
                // alert(result.msg);
                //添加后 关闭模态框，来到最后一页显示刚刚添加的员工信息
                if(result.code == 200) {
                    //1、关闭模态框
                    $("#empAddModel").modal('hide');
                    //2、发送ajax，显示最后一页的请求
                    to_page(totalRecord);
                }else{
                   alert("出错啦"); //此处由于我太懒，不想多写了
                }

            }
        })
    })

//    绑定 点击触发编辑的模态框 的事件
    //但是由于我们的编辑按钮是在页面加载完成之后才有的，所以单纯的 用click是不行的，jquery中提供了on用来处理这一问题
    $(document).on("click",".edit_btn",function () {
        //查出部门信息显示下拉列表
        getDeptName("#empUpdateModel select");
        //查出员工信息，显示员工列表
        getEmp($(this).attr("EmpId"));
        //吧员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("EmpId",$(this).attr("EmpId"));
        $("#empUpdateModel").modal({
            backdrop:"static"
        });

        function  getEmp(id) {
            $.ajax({
                url:"${BasePath}/emp/"+id,
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    var empEle = result.extend.Employee;
                    $("#empName_update_static").text(empEle.empName);
                    $("#update_empEmail").val(empEle.email);
                    $("#empUpdateModel input[name=gender]").val([empEle.gender]);
                    $("#empUpdateModel select").val([empEle.dId]);
                }
            });
        }

        //更新员工信息，绑定点击事件
        $("#emp_update_btn").click(function () {
            //验证邮箱 这里我懒得写
            $.ajax({
                url:"${BasePath}/emp/"+$(this).attr("EmpId"),
                type:"POST",
                data:$("#empUpdateModel form").serialize()+"&_method=PUT",
                success:function (result) {
                    // alert(result.msg)
                    if(result.code == 200) {
                        //1、关闭模态框
                        $("#empUpdateModel").modal('hide');
                        //2、发送ajax，显示最后一页的请求
                        to_page(currentPage);
                    }else{
                        alert("出错啦"); //此处由于我太懒，不想多写了
                    }

                }
            })

        });


    })

    //绑定触发删除的单击事件 删除单个员工
    $(document).on("click",".del_btn",function () {
        //弹出是否确认删除的提示框
       var empName = $(this).parents("tr").find("td:eq(2)").text();
       var empId = $(this).attr("EmpId");
       if(confirm("确认删除【"+empName+"】吗"))
       {
            //发送ajax请求删除员工
           $.ajax({
               url:"${BasePath}/emp/"+empId,
               type:"DELETE",
               success:function (result) {
                   if(result.code == 200) {
                       alert("删除成功");
                       to_page(currentPage);
                   }else{
                       alert("出错啦"); //此处由于我太懒，不想多写了
                   }
               }

           })
       }

    })

    //全选、全不选
    $("#checkAll").click(function () {
        //使用prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));

    })

    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#checkAll").prop("checked",flag);
    })
    
    $("#emp_del_all_btn").click(function () {
        var empNames="";
        var ids="";
        $.each($(".check_item:checked"),function () {
          empNames += $(this).parents("tr").find("td:eq(2)").text()+","
            ids += $(this).parents("tr").find("td:eq(1)").text()+"-"
        });
        empNames.substring(0,empNames.length-1);
        ids.substring(0,ids.length-1);
        if(confirm("确认删除【"+empNames+"】吗"))
        {
            //发送ajax请求进行批量删除
            $.ajax(
                {
                    url:"${BasePath}/emp/"+ids,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                }
            )
        }
    });
    



</script>
</body>
</html>






















