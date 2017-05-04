/**
 * Created by Administrator on 2017-04-30.
 */
$(document).ready(function () {
    //调用函数，初始化表格
    var speedStatus = "未提醒";
    initTable("cusTable", "/record/pager_speedStatus?speedStatus=" + speedStatus);

    initSelect2("company", "请选择汽修公司", "/company/company_all", "150");
    initDateTimePicker("datetimepicker", "chargeTime", "addForm");

    $(".remindMethod").select2({
        // enable tagging
        tags: false,
        width: '565px',
        language: 'zh-CN',
        minimumResultsForSearch: -1,
        placeholder: "提醒方式",
        multiple: true
    });

    destoryValidator("addWin", "addForm");
    destoryValidator("remindWin", "remindForm");
});

/** 显示是否回访 */
function formatterTrack(value, row, index) {
    if (value == "Y") {
        return "是";
    } else {
        return "<span style='color: red'>否</span>";
    }
}

/** 根据条件搜索 */
function searchCondition() {
    var userName = $("#searchUserName").val();
    var carPlate = $("#searchCarPlate").val();
    var maintainOrFix = $("#searchMaintainOrFix").val();
    var companyId = $("#searchCompanyId").val();
    var speedStatus = "待结算";
    initTable("cusTable", "/record/condition_pager?userName=" + userName + "&carPlate=" + carPlate + "&maintainOrFix=" + maintainOrFix + "&companyId=" + companyId + "&speedStatus=" + speedStatus);

}

/** 关闭搜索的form */
function closeSearchForm() {
    $("#searchUserName").val('');
    $("#searchCarPlate").val('');
    $("#searchMaintainOrFix").val('all');
    $('#searchCompanyId').html('').trigger("change");
    $("#searchDiv").hide();
    $("#showButton").show();
}

/** 给datetimepicker添加默认值 */
function getDate() {

    $("#addChargeTime").val(new Date());
}

/** 查看未提醒 */
function notRemind() {
    initTable("cusTable", "/record/pager_speedStatus?speedStatus=未提醒");
}
/** 查看已提醒 */
function alreadyRemind() {
    initTable("cusTable", "/record/pager_speedStatus?speedStatus=已提醒");
}
/** 查看全部 */
function allRemind() {
    var speedStatus = "已提醒,未提醒";
    initTable("cusTable", "/record/pager_speedStatus?speedStatus=" + speedStatus);
}

/** 显示结算提车的win，添加收费单据的win */
function showAddWin() {
    validator("addForm");
    var selectRow = $("#cusTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('结算失败', "只能选择一条维修保养记录", "error");
        return false;
    } else {
        var record = selectRow[0];
        $("#addForm").fill(record);
        $("#addWin").modal('show');
        $("input[type=reset]").trigger("click");
    }
}

/** 显示提车提醒的win */
function showRemindWin() {
    validator("remindForm");
    var selectRow = $("#cusTable").bootstrapTable('getSelections');
    if (selectRow.length < 1) {
        swal('提醒失败', "至少要选择一条记录", "error");
        return false;
    } else {
        var len = selectRow.length;
        var ids = "";
        var flag = true;
        var lastSpeedStatus = "";
        var recordIds = "";
        var carPlate = "";
        for (var i = 0; i < len; i++) {
            var record = selectRow[i];
            lastSpeedStatus = record.speedStatus;
            if (selectRow[0].speedStatus != selectRow[i].speedStatus) {
                flag = false;
            } else {
                if (selectRow[i].speedStatus == "已提醒") {
                    flag = false;
                }
            }
            if (ids == "") {
                ids = record.checkin.userId;
                recordIds = record.recordId;
                carPlate = record.checkin.carPlate;
            } else {
                ids += "," + record.checkin.userId;
                recordIds += "," + record.recordId;
                carPlate += "," + record.checkin.carPlate;
            }

        }
        if (flag) {
            $("#remindUserId").val(ids);
            $("#remindRecordId").val(recordIds);
            $("#remindCarPlate").val(carPlate);
            $("#remindWin").modal('show');
        } else {
            swal('提醒失败', "只能选择未提醒的记录", "error");
        }

    }
}

/** 表单验证 */
function validator(formId) {
    $("#addButton").removeAttr("disabled");
    $("#remindButton").removeAttr("disabled");
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            chargeBillMoney: {
                validators: {
                    notEmpty: {
                        message: '总金额不能为空'
                    },
                    stringLength: {
                        min: 0,
                        max: 5,
                        message: '总金额的长度不能超过5位'
                    }
                }
            },
            actualPayment: {
                validators: {
                    notEmpty: {
                        message: '车主实际付款不能为空'
                    },
                    stringLength: {
                        min: 0,
                        max: 5,
                        message: '实际付款金额不能超过5位'
                    }
                }
            },
            chargeTime: {
                validators: {
                    notEmpty: {
                        message: '付款时间不能为空'
                    }

                }
            },
            chargeBillDes: {
                validators: {
                    stringLength: {
                        min: 0,
                        max: 500,
                        message: '描述不能超过500个字'
                    }

                }
            },
            remindTitle: {
                validators: {
                    notEmpty: {
                        message: '提醒标题不能为空'
                    }

                }
            },
            remindMethod: {
                validators: {
                    notEmpty: {
                        message: '至少选择一种提醒方式'
                    }

                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/bill/add", formId, "addWin");

            } else if (formId == "remindForm") {
                formSubmit("/record/send_remind", formId, "remindWin");
            }


        })
}
