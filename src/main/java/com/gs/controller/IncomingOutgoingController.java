package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingOutgoing;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.IncomingOutgoingService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiao-kang on 2017/4/18.
 */
@Controller
@RequestMapping("/incomingOutgoing")
public class IncomingOutgoingController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IncomingOutgoingController.class);

    @Resource
    private IncomingOutgoingService incomingOutgoingService;

    @RequestMapping(value = "show_incomingOutgoing", method = RequestMethod.GET)
    public String incomingType() {
        logger.info("显示收支管理页面");
        return "financeManage/incoming_outgoing";
    }

    @ResponseBody
    @RequestMapping(value="query_pager",method= RequestMethod.GET)
    public Pager4EasyUI<IncomingOutgoing> queryPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize){
        logger.info("分页查询所有收支记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(incomingOutgoingService.count());
        List<IncomingOutgoing> incomingTypes = incomingOutgoingService.queryByPager(pager);
        return new Pager4EasyUI<IncomingOutgoing>(pager.getTotalRecords(), incomingTypes);
    }

    @ResponseBody
    @RequestMapping(value="update_inOut", method=RequestMethod.POST)
    public ControllerResult incomingUpdate(IncomingOutgoing incomingOutgoing){
        logger.info("更新收支记录");
        incomingOutgoingService.update(incomingOutgoing);
        return ControllerResult.getSuccessResult("更新成功");
    }

    @ResponseBody
    @RequestMapping(value="update_status", method=RequestMethod.GET)
    public ControllerResult updateStatus(@Param("id") String id, @Param("status")String status){
        logger.info("更新收入类型状态");
        if(status.equals("Y")){
            incomingOutgoingService.active(id);
        }else if(status.equals("N")){
            incomingOutgoingService.inactive(id);
        }
        return ControllerResult.getSuccessResult("更新成功");
    }


    @ResponseBody
    @RequestMapping(value="query_inOutType",method= RequestMethod.GET)
    public Pager4EasyUI<IncomingOutgoing> queryByInOutType(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize,@Param("type")String type){
        logger.info("分页查询所有收支记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        IncomingOutgoing incomingOutgoing = new IncomingOutgoing();
        incomingOutgoing.setInOutType(type);
        pager.setTotalRecords(incomingOutgoingService.countByInOutType(incomingOutgoing));
        List<IncomingOutgoing> incomingTypes = incomingOutgoingService.queryByInOutType(pager,incomingOutgoing);
        return new Pager4EasyUI<IncomingOutgoing>(pager.getTotalRecords(), incomingTypes);
    }

}
