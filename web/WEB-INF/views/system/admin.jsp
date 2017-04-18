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
    <link href="<%=path %>/css/bootstrap-table.min.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/sweet-alert.css" rel="stylesheet" type="text/css">

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
            <th data-field="companyId" >
                公司
            </th>
            <th data-field="userCreatedTime" >
                创建时间
            </th>
            <th data-field="userLoginedTime" >
                最近登陆时间
            </th>
            <th data-field="moduleStatus" data-formatter="userStatus">
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
            <a><button onclick="initTable('cusTable', '/module/query_pager');" type="button" class="btn btn-default" >
                查询全部
            </button></a>
            <a><button onclick="initTable('cusTable', '/module/queryByStatus_module?status=Y');" type="button" class="btn btn-default" >
                查可用模块
            </button></a>
            <a><button onclick="initTable('cusTable', '/module/queryByStatus_module?status=N');" type="button" class="btn btn-default" >
                查不可用模块
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
                                <label>模块名称：</label>
                                <input type="text"   name="moduleName" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label>模块描述：</label>
                                <textarea name="moduleDes" class="form-control"></textarea>
                            </div>
                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <input type="button" class="btn btn-primary" onclick="addModule()" value="添加">
                                </input>
                                <input type="reset" name="reset" style="display: none;" />
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
<script src="<%=path %>/js/bootstrap.min.js"></script>
<script src="<%=path %>/js/bootstrap-table.js"></script>
<script src="<%=path %>/js/bootstrap-table-zh-CN.min.js"></script>
<script src="<%=path %>/js/sweet-alert.min.js"></script>
<script src="<%=path %>/js/jquery.formFill.js"></script>
<script src="<%=path %>/js/system/admin.js"></script>
<script src="<%=path %>/js/main.js"></script>

</body>
</html>
