package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Accessories;
import com.gs.bean.AccessoriesType;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.AccessoriesService;
import com.gs.service.AccessoriesTypeService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by GOD on 2017/4/19.
 */
@Controller
@RequestMapping("accessories")
public class AccessoriesController {

    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesController.class);

    @Resource
    private AccessoriesService accessoriesService;

    @RequestMapping(value = "stock", method = RequestMethod.GET)
    private String stock() {
        logger.info("显示配件信息");
        return "accessories/stock";
    }

    @ResponseBody
    @RequestMapping(value = "pager", method = RequestMethod.GET)
    public Pager4EasyUI<Accessories> queryPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(accessoriesService.count());
        List<Accessories> accessories = accessoriesService.queryByPager(pager);
        return new Pager4EasyUI<Accessories>(pager.getTotalRecords(), accessories);
    }

    @ResponseBody
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public ControllerResult addAcc(Accessories accessories) {
        logger.info("添加");
        System.out.println(accessories);
        accessories.setAccStatus("Y");
        accessoriesService.insert(accessories);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult updateAcc(Accessories accessories) {
        logger.info("更新");
        accessories.setAccStatus("Y");
        accessoriesService.update(accessories);
        return ControllerResult.getSuccessResult("修改成功");
    }

    @ResponseBody
    @RequestMapping(value = "update_status", method = RequestMethod.GET)
    public ControllerResult updateStatus(@Param("id") String id, @Param("status") String status) {
        logger.info("更新状态");
        if (status.equals("Y")) {
            accessoriesService.active(id);
        } else if (status.equals("N")) {
            accessoriesService.inactive(id);
        }
        return ControllerResult.getSuccessResult("更新成功");
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}


