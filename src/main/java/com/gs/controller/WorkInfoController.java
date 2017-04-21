package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.bean.WorkInfo;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.UserService;
import com.gs.service.WorkInfoService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 温鑫
 * Created by Star on 2017/4/21.
 */
@Controller
@RequestMapping("peopleManage")
public class WorkInfoController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IncomingTypeController.class);

    @Resource
    private WorkInfoService workInfoService;


    @RequestMapping(value = "work", method = RequestMethod.GET)
    private String workInfo() {
        logger.info(" 工单显示");
        return "peopleManage/work";
    }

    @ResponseBody
    @RequestMapping(value = "workInfo_insert", method = RequestMethod.POST)
    public ControllerResult infoInsert(WorkInfo workInfo){
        logger.info("工单添加");
        workInfoService.insert(workInfo);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "workInfo_pager", method= RequestMethod.GET)
    public Pager4EasyUI<WorkInfo> info_pager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize){
        logger.info("分页查询所有工单");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(workInfoService.count());
        List<WorkInfo> workInfos = workInfoService.queryByPager(pager);
        return new Pager4EasyUI<WorkInfo>(pager.getTotalRecords(), workInfos);
    }
}