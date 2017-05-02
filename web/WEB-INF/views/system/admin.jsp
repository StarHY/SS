<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-14
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>管理员管理</title>
    <link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/bootstrap-table.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/sweet-alert.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/font-awesome.min93e3.css" rel="stylesheet">

</head>
<body>

<div class="container">
    <table class="table table-hover" id="cusTable"
           data-pagination="true"
           data-show-refresh="true"
           data-show-toggle="true"
           data-showColumns="true"
           data-height="610">
        <thead>
        <tr>
            <th data-field="state" data-checkbox="true"></th>
            <th data-field="userEmail" >
                邮箱
            </th>
            <th data-field="userPhone" >
                手机
            </th>
            <th data-field="userNickname" >
                昵称
            </th>
            <th data-field="userIdentity" >
                身份证
            </th>
            <th data-field="userName" >
                姓名
            </th>
            <th data-field="userGender" >
                性别
            </th>
            <th data-field="userBirthday" >
                生日
            </th>
            <th data-field="userAddress" >
                地址
            </th>
            <th data-field="qqOpenId" >
                QQ
            </th>
            <th data-field="weiboOpenId" >
                微博
            </th>
            <th data-field="wechatOpenId" >
                微信
            </th>
            <th data-field="userDes" >
                描述
            </th>
            <th data-field="company.companyName" >
                公司
            </th>
            <th data-field="userCreatedTime" >
                创建时间
            </th>
            <th data-field="userLoginedTime" >
                最近登陆时间
            </th>
            <th data-field="userStatus" data-formatter="status">
                状态
            </th>
            <th data-field="caozuo" data-formatter="operateFormatter" data-events="operateEvents">
                操作
            </th>
        </tr>
        </thead>
        <tbody>
        <div id="toolbar" class="btn-group">
            <a href="#addWin" data-toggle="modal"><button type="button" id="add" class="btn btn-default" >
                <i class="glyphicon glyphicon-plus"></i> 添加
            </button></a>
            <a><button onclick="showEditWin();" type="button" id="edit" class="btn btn-default">
                <i class="glyphicon glyphicon-pencil"></i> 修改
            </button></a>
            <a><button onclick="queryAll();" type="button" class="btn btn-default" >
                查询全部
            </button></a>
            <a><button onclick="querySystem();" type="button" class="btn btn-default" >
                系统管理员
            </button></a>
            <a><button onclick="queryCompany();" type="button" class="btn btn-default" >
                公司管理员
            </button></a>
        </div>
        </tbody>

    </table>
</div>



<div id="editWin" class="modal fade" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">修改模块信息</h3>
                        <form role="form" id="updateForm" >
                            <input type="hidden" attr="module.moduleId" name="moduleId" />
                            <div class="form-group">
                                <label>模块名称：</label>
                                <input type="text" attr="module.moduleName" name="moduleName"  class="form-control"/>

                                <label>模块描述：</label>
                                <textarea attr="module.moduleDes"  type="textarea" name="moduleDes" class="form-control"></textarea>
                            </div>

                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <input type="button" class="btn btn-primary" value="修改" onclick="updateModule()">
                                </input>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="addWin" class="modal fade" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">添加模块</h3>
                        <form role="form" id="addForm">
                            <div class="form-group">
                                <label class="control-label">姓名：</label>
                                <input type="text"  name="userName" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label class="control-label">邮箱：</label>
                                <input type="email" name="userEmail"
                                       class="form-control"/>
                            </div>
                            <div class="form-group">
                                <p><label class="control-label">密码：</label></p>
                                <input type="password" id="pwd" name="userPwd"
                                       class="form-control" style="width: 75%; display: initial;"/>
                                <button type="button" onclick="defaultPwd()"style="float: right" class="btn btn-success" data-toggle="tooltip" data-placement="top" title="默认密码为123456">使用默认密码</button>
                            </div>
                            <div class="form-group">
                                <label class="control-label">性别：</label>
                                <select class="form-control" name="userGender">
                                    <option value="N" selected = "selected">未知</option>
                                    <option value="M">男</option>
                                    <option value="F">女</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="control-label">手机号：</label>
                                <input type="text" name="userPhone"
                                       class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label class="control-label">基本工资：</label>
                                <input type="text" name="userSalary"
                                       class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label class="control-label">居住地址：</label>
                                <div style="position: relative;">
                                    <input data-toggle="city-picker" class="address" name="userAddress">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label">身份证：</label>
                                <input type="text" name="userIdentity"
                                       class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label class="control-label">所属公司：</label>
                                <select id="addCompany" class="js-example-tags form-control user_company" name="companyId"></select>
                            </div>
                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <input type="button" id="addButton"id="destroy" class="btn btn-primary" onclick="add()" value="添加"/>
                                </input>
                                <input type="reset" name="reset" style="display: none"/>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/rightMenu.jsp" %>
<script src="<%=path %>/js/contextmenu.js"></script>
<script src="<%=path %>/js/jquery.min.js"></script>
<script src="<%=path %>/js/bootstrapValidator.js"></script>
<script src="<%=path %>/js/bootstrap.min.js"></script>
<script src="<%=path %>/js/bootstrap-table.js"></script>
<script src="<%=path %>/js/bootstrap-table-zh-CN.min.js"></script>
<script src="<%=path %>/js/sweet-alert.min.js"></script>
<script src="<%=path %>/js/jquery.formFill.js"></script>
<script src="<%=path %>/js/system/admin.js"></script>
<script src="<%=path %>/js/main.js"></script>

</body>
</html>
