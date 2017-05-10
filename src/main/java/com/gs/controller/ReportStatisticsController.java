package com.gs.controller;

import com.gs.common.util.SessionGetUtil;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import ch.qos.logback.classic.Logger;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by xiao-kang on 2017/4/22.
 */
@Controller
@RequestMapping("/reportStatistics")
public class ReportStatisticsController {

    private Logger logger = (Logger) LoggerFactory.getLogger(ReportStatisticsController.class);

    @RequestMapping(value = "finance_page", method = RequestMethod.GET)
    public String showInOutPage() {
        if(SessionGetUtil.isUser()) {
            logger.info("显示财务统计页面");
            return "reportStatistics/finance_statistics";
        } else{
            logger.info("Session已失效，请重新登入");
            return "index/notLogin";
        }
    }

    @RequestMapping(value = "staff_page", method = RequestMethod.GET)
    public String showStaff() {
        if(SessionGetUtil.isUser()) {
            logger.info("显示员工工单统计页面");
            return "reportStatistics/staff_statistics";
        }else{
            logger.info("Session已失效，请重新登入");
            return "index/notLogin";
        }
    }

    @RequestMapping(value = "order_page", method = RequestMethod.GET)
    public String showOrder() {
        if(SessionGetUtil.isUser()) {
            logger.info("显示下单统计页面");
            return "supply/order_statistics";
        }else{
            logger.info("Session已失效，请重新登入");
            return "index/notLogin";
        }
    }

    @RequestMapping(value = "pay_page", method = RequestMethod.GET)
    public String showPay() {
        if(SessionGetUtil.isUser()) {
            logger.info("显示下单统计页面");
            return "supply/pay_statistics";
        }else{
            logger.info("Session已失效，请重新登入");
            return "index/notLogin";
        }
    }
}
