<%--
  Created by IntelliJ IDEA.
  User: xiao-kang
  Date: 2017/4/13
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <title>维修保养记录管理</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/bootstrap-table.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/sweet-alert.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/select2.min.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">

    <link href="<%=path %>/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>


<div class="container">
    <table class="table table-hover" id="cusTable"
           data-pagination="true"
           data-show-refresh="true"
           data-show-toggle="true"
           data-showColumns="true"
           data-height="500">
        <thead>
        <tr>
            <th data-field="state" data-checkbox="true"></th>
            <th data-field="checkin.userName">
                车主姓名
            </th>
            <th data-field="checkin.carPlate">
                登记车牌号
            </th>
            <th data-field="startTime" data-formatter="formatterDate">
                维修保养开始时间
            </th>
            <th data-field="endTime" data-formatter="formatterDate">
                预估结束时间
            </th>
            <th data-field="actualEndTime" data-formatter="formatterDate">
                实际结束时间
            </th>
            <th data-field="recordCreatedTime" data-formatter="formatterDate">
                创建记录时间
            </th>
            <th data-field="pickupTime" data-formatter="formatterDate">
                提车时间
            </th>
            <th data-field="checkin.maintainOrFix">
                保养&nbsp;|&nbsp;维修
            </th>
            <th data-field="trackStatus" data-formatter="formatterTrack">
                是否回访
            </th>
            <th data-field="recordDes">
                记录描述
            </th>
            <th data-field="company.companyName">
                汽修公司
            </th>
            <th data-field="recordStatus" data-formatter="status">
                记录状态
            </th>
            <th data-field="caozuo" data-formatter="operateFormatter" data-events="operateEvents">
                操作
            </th>
        </tr>
        </thead>
        <form id="formSearch" class="form-horizontal">
            <div class="form-group" id="searchDiv" style="margin-top:15px; display: none;">
                <div class="col-sm-2" style="margin-left: -15px;">
                    <input type="text" id="searchUserName" name="userName" class="form-control" placeholder="请输入车主姓名" >
                </div>
                <div class="col-sm-2">
                    <input type="text" id="searchCarPlate" name="carPlate" class="form-control" placeholder="请输入车牌号码">
                </div>
                <div class="col-sm-2">
                    <input type="text" id="searchStartTime" name="startTime" readonly class="form-control searchStartTime" placeholder="开始时间">
                </div>
                <div class="col-sm-2">
                    <select class="js-example-tags form-control" id="searchMaintainOrFix" name="maintainOrFix">
                        <option value="all">维修&nbsp;&&nbsp;保养</option>
                        <option value="维修">维修</option>
                        <option value="保养">保养</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <select class="js-example-tags form-control company" id="searchCompanyId" name="comanyId">
                    </select>
                </div>

                <div class="col-sm-2">
                    <button type="button" onclick="searchCondition()" class="btn btn-primary">
                        查询
                    </button>
                    <button type="button" onclick="closeSearchForm()" class="btn btn-default">
                        关闭
                    </button>
                </div>
            </div>
        </form>
        <tbody>
        <div id="toolbar" class="btn-group">

            <a>
                <button onclick="showEditWin();" type="button" id="edit" class="btn btn-default">
                    <i class="glyphicon glyphicon-pencil"></i> 修改
                </button>
            </a>
            <a>
                <button onclick="searchStatus('/record/pager?status=Y');" type="button" class="btn btn-default">
                    <i class="glyphicon glyphicon-search"></i> 查看可用记录
                </button>
            </a>
            <a>
                <button onclick="searchStatus('/record/pager?status=N');" type="button" class="btn btn-default">
                    <i class="glyphicon glyphicon-search"></i> 查看不可用记录
                </button>
            </a>
            <a>
                <button onclick="searchStatus('/record/pager?status=ALL');" type="button" class="btn btn-default">
                    <i class="glyphicon glyphicon-search"></i> 查看全部
                </button>
            </a>
            <a>
                <button onclick="showSearchForm()" id="showButton" type="button" class="btn btn-primary">
                    <i class="glyphicon glyphicon-search"></i> 查询
                </button>
            </a>

            <a>
                <button onclick="showAddDetailWin();" type="button" class="btn btn-default">
                    <i class="glyphicon glyphicon-glass"></i> 生成明细
                </button>
            </a>

            <a>
                <button onclick="showDetailWin();" type="button" class="btn btn-default">
                    <i class="glyphicon glyphicon-search"></i> 查看明细
                </button>
            </a>

        </div>
        </tbody>

    </table>
</div>

<div id="editWin" style="overflow:scroll" class="modal fade" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">修改维修保养记录</h3>
                        <form role="form" id="editForm">
                            <input type="hidden" attr="record.recordId" name="recordId" class="form-control"/>
                            <input type="hidden" attr="record.checkin.checkinId" name="checkinId" class="form-control"/>
                            <input type="hidden" attr="record.trackStatus" name="trackStatus" class="form-control"/>
                            <div class="form-group">
                                <label>开始时间：</label>
                                <input id="editStartTime" readonly type="text" name="startTime"
                                       class="form-control datetimepicker"/>
                            </div>

                            <div class="form-group">
                                <label>预估结束时间：</label>
                                <input id="editEndTime" readonly type="text" name="endTime"
                                       class="form-control datetimepicker"/>
                            </div>

                            <div class="form-group">
                                <label class="control-label">记录描述：</label>
                                <textarea class="form-control" attr="record.recordDes" type="textarea" name="recordDes"
                                          rows="3"></textarea>
                            </div>


                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <input type="button" onclick="buttonStatus('editForm', 'editButton')" id="editButton" class="btn btn-primary" value="修改">
                                </input>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="detailWin" style="overflow:scroll" class="modal fade" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">生成维修保养明细</h3>
                        <form role="form" id="detailForm">
                            <input type="hidden" attr="record.recordId" name="recordId" class="form-control"/>
                            <div class="form-group">
                                <label class="control-label">维修&nbsp;|&nbsp;保养：</label>
                                <input type="text" id="maintainOrFix" attr="record.checkin.maintainOrFix" readonly class="form-control" />
                            </div>
                            <div class="form-group">
                                <label class="control-label">维修保养项目：</label>
                                <input type="hidden" id="detailMaintainId" name="maintainId" />
                                <input type="text" onclick="choiseMaintain();" id="detailMaintainName" name="maintainName" readonly class="form-control" />
                                <br />
                                <a>
                                    <button onclick="choiseMaintain();" type="button" class="btn btn-primary">
                                        <i class="glyphicon glyphicon-plus"></i> 选择维修保养项目
                                    </button>
                                </a>
                            </div>
                            <div class="form-group">
                                <label class="control-label">折扣&nbsp;|&nbsp;减价：</label>
                                <input type="text" maxlength="4" name="maintainDiscount" class="form-control"/>
                                <span style="font-size: 12px; color: green;">小于1大于0是折扣，大于等于1则是减价</span>
                            </div>

                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <input type="button" id="detailButton" onclick="buttonStatus('detailForm', 'detailButton')" class="btn btn-primary" value="添加">
                                </input>
                                <input type="reset" name="reset" style="display: none;"/>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="searchDetailWin" class="modal fade" aria-hidden="true" style="overflow:scroll">
    <div class="modal-dialog" style="width: 1000px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">查看维修保养明细</h3>
                        <table class="table table-hover" id="detailTable"
                               data-pagination="true"
                               data-show-refresh="true"
                               data-show-toggle="true"
                               data-showColumns="true"
                               data-height="500">
                            <thead>
                            <tr>
                                <th data-field="state" data-checkbox="true"></th>
                                <th data-field="record.checkin.userName">
                                    车主姓名
                                </th>
                                <th data-field="record.checkin.userPhone">
                                    车主电话
                                </th>
                                <th data-field="record.checkin.maintainOrFix">
                                    维修&nbsp;|&nbsp;保养
                                </th>
                                <th data-field="maintain.maintainName">
                                    项目
                                </th>
                                 <th data-field="maintain.maintainMoney" data-formatter="formatterMoney">
                                    原价
                                </th>
                                <th data-field="maintainDiscount" data-formatter="formatterDiscount">
                                    打折&nbsp;|&nbsp;减价
                                </th>
                                 <th data-field="price" data-formatter="formatterPrice">
                                    现价
                                </th>
                                <th data-field="detailCreatedTime" data-formatter="formatterDate">
                                    明细创建时间
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <div id="toolbar1" class="btn-group">

                                <a>
                                    <button onclick="showEditDetailWin();" type="button" id="editDetail" class="btn btn-default">
                                        <i class="glyphicon glyphicon-pencil"></i> 修改
                                    </button>
                                </a>

                            </div>
                            </tbody>

                        </table>
                        <div style="height: 40px;"></div>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">关闭
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="editDetailWin" style="overflow:scroll" class="modal fade" aria-hidden="true" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">修改维修保养记录</h3>
                        <form role="form" id="editDetailForm">
                            <input type="hidden" attr="detail.detailId" name="detailId" class="form-control"/>
                            <input type="hidden" attr="detail.record.recordId" name="recordId" class="form-control"/>
                            <div class="form-group">
                                <label>车主姓名：</label>
                                <input readonly type="text" attr="detail.record.checkin.userName" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label>车主电话：</label>
                                <input readonly type="text" attr="detail.record.checkin.userPhone" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label class="control-label">维修保养项目：</label>
                                <select id="editDetailMaintain" class="js-example-tags form-control maintain_fix" name="maintainId">
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="control-label">折扣&nbsp;|&nbsp;减价：</label>
                                <input type="text" maxlength="4" attr="detail.maintainDiscount" name="maintainDiscount" class="form-control"/>
                                <span style="font-size: 12px; color: green;">小于1大于0是折扣，大于等于1则是减价</span>
                            </div>

                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default" onclick="closeEditDetailWin()">关闭
                                </button>
                                <input type="button" onclick="buttonStatus('editDetailForm', 'editDetailButton')" id="editDetailButton" class="btn btn-primary" value="修改">
                                </input>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="maintainWin" class="modal fade" aria-hidden="true" style="overflow:scroll">
    <div class="modal-dialog" style="width: 1000px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">选择保养项目</h3>
                        <table class="table table-hover" id="maintainTable"
                               data-pagination="true"
                               data-show-refresh="true"
                               data-show-toggle="true"
                               data-showColumns="true"
                               data-height="500">
                            <thead>
                            <tr>
                                <th data-field="state" data-checkbox="true"></th>
                                <th data-field="maintainName" >
                                    保养项目名称
                                </th>
                                <th data-field="maintainHour" >
                                    保养所需工时
                                </th>
                                <th data-field="maintainMoney" >
                                    保养基础费用
                                </th>
                                <th data-field="maintainManHourFee" >
                                    保养工时费
                                </th>
                                <th data-field="maintainDes" >
                                    保养描述
                                </th>
                                <th data-field="company.companyName">
                                    公司名称
                                </th>
                                <th data-field="maintainStatus" data-formatter="status">
                                    保养项目状态
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                        <div style="height: 40px;"></div>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">关闭
                            </button>
                            <input type="button" class="btn btn-primary" onclick="determineMaintain()" value="确定">
                            </input>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="fixWin" class="modal fade" aria-hidden="true" style="overflow:scroll">
    <div class="modal-dialog" style="width: 1000px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">选择维修项目</h3>
                        <table class="table table-hover" id="fixTable"
                               data-pagination="true"
                               data-show-refresh="true"
                               data-show-toggle="true"
                               data-showColumns="true"
                               data-height="500">
                            <thead>
                            <tr>
                                <th data-field="state" data-checkbox="true"></th>
                                <th data-field="maintainName" >
                                    维修项目名称
                                </th>
                                <th data-field="maintainHour" >
                                    维修所需工时
                                </th>
                                <th data-field="maintainMoney" >
                                    维修基础费用
                                </th>
                                <th data-field="maintainManHourFee" >
                                    维修工时费
                                </th>
                                <th data-field="maintainDes" >
                                    维修描述
                                </th>
                                <th data-field="company.companyName">
                                    公司名称
                                </th>
                                <th data-field="maintainStatus" data-formatter="status">
                                    维修项目状态
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                        <div style="height: 40px;"></div>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">关闭
                            </button>
                            <input type="button" class="btn btn-primary" onclick="determineFix()" value="确定">
                            </input>
                        </div>
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
<script src="<%=path %>/js/select2.full.min.js"></script>
<script src="<%=path %>/js/zh-CN.js"></script>
<script src="<%=path %>/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=path %>/js/locales/bootstrap-datetimepicker.fr.js"></script>
<script src="<%=path %>/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path %>/js/main.js"></script>
<script src="<%=path %>/js/maintenanceReception/record.js"></script>
</body>
</html>
