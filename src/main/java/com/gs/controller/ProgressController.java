package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainRecord;
import com.gs.bean.User;
import com.gs.common.Constants;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.CheckRoleUtil;
import com.gs.common.util.SessionGetUtil;
import com.gs.service.MaintainRecordService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 温鑫
 * 维修保养进度管理
 * Created by Star on 2017/4/26.
 */
@Controller
@RequestMapping("progress")
public class ProgressController {


    @Resource
    private MaintainRecordService maintainRecordService;

    private String queryRole = Constants.CAR_OWNER + "," + Constants.COMPANY_RECEIVE + ","
            + Constants.COMPANY_ARTIFICER + "," + "," + Constants.COMPANY_ADMIN;

    private Logger logger = (Logger) LoggerFactory.getLogger(ProgressController.class);

    @RequestMapping(value = "progress_page", method = RequestMethod.GET)
    public String progressInfo() {
        if (SessionGetUtil.isUser()) {
            if (CheckRoleUtil.checkRoles(queryRole)) {
                logger.info(" 维修保养进度页面");
                return "maintenanceProgress/car_maintenance_progress";
            }
            return "error/notPermission";
        } else {
            logger.info("Session已失效，请重新登入");
            return "index/notLogin";
        }
    }

    @ResponseBody
    @RequestMapping(value="progress_pager",method= RequestMethod.GET)
    public Pager4EasyUI<MaintainRecord> queryPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize){
        if (SessionGetUtil.isUser()) {
//            try {
                if (CheckRoleUtil.checkRoles(queryRole)) {
                    logger.info("分页查询进度");
                    User user = SessionGetUtil.getUser();
                    Pager pager = new Pager();
                    pager.setPageNo(Integer.valueOf(pageNumber));
                    pager.setPageSize(Integer.valueOf(pageSize));
                    pager.setTotalRecords(maintainRecordService.countByProgressPager(user));
                    List<MaintainRecord> maintainRecords = maintainRecordService.queryByProgressPager(pager, user);
                    return new Pager4EasyUI<MaintainRecord>(pager.getTotalRecords(), maintainRecords);
                }
                return null;
//            } catch (Exception e) {
//                logger.info("分页查询失败，出现了异常");
//                return null;
//            }
        } else {
            logger.info("Session已失效，请重新登入");
            return null;
        }
    }
}
