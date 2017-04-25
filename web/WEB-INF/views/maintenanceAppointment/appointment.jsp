<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>预约管理</title>

    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=path %>/css/bootstrap-table.css" rel="stylesheet" type="text/css">
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
           data-showColumns="true">
        <thead>
        <tr>
            <th data-field="tater" data-checkbox="true"></th>
            <th data-field="userName">
                车主姓名
            </th>
            <th data-field="userPhone">
                车主电话
            </th>
            <th data-field="brand.brandName">
                汽车品牌
            </th>
            <th data-field="color.colorName">
                汽车颜色
            </th>
            <th data-field="model.modelName">
                汽车车型
            </th>
            <th data-field="plate.plateName">
                汽车车牌
            </th>
            <th data-field="carPlate">
                车牌号码
            </th>
            <th data-field="arriveTime" data-formatter="formatterDate">
                预计到店时间
            </th>
            <th data-field="maintainOrFix">
                维修&nbsp;|&nbsp;保养
            </th>
            <th data-field="appCreatedTime" data-formatter="formatterDate">
                预约创建时间
            </th>
            <th data-field="company.companyName">
                汽修公司
            </th>
            <th data-field="appoitmentStatus" data-formatter="status">
                预约状态
            </th>
            <th data-field="operate" data-formatter="operateFormatter" data-events="operateEvents">
                操作
            </th>
        </thead>

        <div id="toolbar" class="btn-group">
            <a>
                <button onclick="showAddWin();" type="button" id="add" class="btn btn-default">
                    <i class="glyphicon glyphicon-plus"></i> 添加
                </button>
            </a>
            <a>
                <button onclick="showEditWin();" type="button" id="edit" class="btn btn-default">
                    <i class="glyphicon glyphicon-pencil"></i> 修改
                </button>
            </a>
        </div>
    </table>
</div>

<div id="editWin"  style="overflow:scroll" class="modal fade" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">修改预约</h3>
                        <form role="form" id="editForm">

                            <div class="form-group">
                                <input type="hidden" attr="appointment.appointmentId" name="appointmentId" class="form-control"/>
                                <label>车主姓名：</label>
                                <input type="text" attr="appointment.userName" name="userName" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label>车主电话：</label>
                                <input type="text" attr="appointment.userPhone" name="userPhone" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label>汽车品牌：</label>
                                <select id="editCarBrand" class="js-example-tags form-control car_brand" onchange="editCheckBrand(this)" name="brandId">
                                </select>
                            </div>

                            <div class="form-group">
                                <label>汽车车型：</label>
                                <select id="editCarModel" class="js-example-tags form-control car_model" name="modelId">
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="control-label">汽车颜色：</label>
                                <select id="editCarColor" class="js-example-tags form-control car_color" name="colorId">
                                </select>
                            </div>

                            <div class="form-group">
                                <label>汽车车牌：</label>
                                <select id="editCarPlate" class="js-example-tags form-control car_plate" name="plateId">
                                </select>
                            </div>

                            <div class="form-group">
                                <label>车牌号码：</label>
                                <input type="text" attr="appointment.carPlate" name="carPlate" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label>预估到店时间：</label>
                                <input id="editDatetimepicker" readonly type="text" name="arriveTime"
                                       class="form-control datetimepicker"/>
                            </div>
                            <div class="form-group">
                                <label>保养&nbsp;|&nbsp;维修：</label>
                                <select class="js-example-tags form-control" attr="appointment.maintainOrFix" type="select-one" name="maintainOrFix">
                                    <option value="保养">保养</option>
                                    <option value="维修">维修</option>
                                </select>
                            </div>

                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <input type="button" onclick="edit()" id="editButton" class="btn btn-primary" value="修改">
                                </input>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="addWin" class="modal fade" style="overflow:scroll" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">添加预约</h3>
                        <form role="form" id="addForm">
                            <div class="form-group">
                                <label>车主姓名：</label>
                                <input type="text" id="addUserName" name="userName" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label>车主电话：</label>
                                <input type="text" id="addUserPhone" name="userPhone" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label>汽车品牌：</label>
                                <select id="addCarBrand" class="js-example-tags form-control car_brand" onchange="checkBrand(this)" name="brandId">
                                </select>
                            </div>

                            <div class="form-group" id="carModelDiv" style="display: none;">
                                <label>汽车车型：</label>
                                <select id="addCarModel" class="js-example-tags form-control car_model" name="modelId">
                                </select>
                            </div>

                            <div class="form-group">
                                <label>汽车颜色：</label>
                                <select id="addCarColor" class="js-example-tags form-control car_color" name="colorId">
                                </select>
                            </div>

                            <div class="form-group">
                                <label>汽车车牌：</label>
                                <select id="addCarPlate" class="js-example-tags form-control car_plate" name="plateId">
                                </select>
                            </div>


                            <div class="form-group">
                                <label>车牌号码：</label>
                                <input type="text" name="carPlate" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <label>预估到店时间：</label>
                                <input id="editDatetimepicker" readonly type="text" name="arriveTime"
                                       class="form-control datetimepicker"/>
                            </div>

                            <div class="form-group">
                                <label>保养&nbsp;|&nbsp;维修：</label>
                                <select id="addMaintainOrFix" class="js-example-tags form-control" name="maintainOrFix">
                                    <option value="保养">保养</option>
                                    <option value="维修">维修</option>
                                </select>
                            </div>
                            <div class="modal-footer" style="overflow:hidden;">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <input type="button" id="addButton" class="btn btn-primary" onclick="add()" value="添加">
                                </input>
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
<script src="<%=path %>/js/select2.full.min.js"></script>
<script src="<%=path %>/js/zh-CN.js"></script>
<script src="<%=path %>/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=path %>/js/locales/bootstrap-datetimepicker.fr.js"></script>
<script src="<%=path %>/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path %>/js/main.js"></script>
<script src="<%=path%>/js/appointment/appointment.js"></script>
</body>
</html>