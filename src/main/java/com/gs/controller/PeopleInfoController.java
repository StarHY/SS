package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.*;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.RoleService;
import com.gs.service.UserRoleService;
import com.gs.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 温鑫
 * 人员基本信息
 * Created by Star on 2017/4/17.
 */

@Controller
@RequestMapping("peopleManage")
public class PeopleInfoController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IncomingTypeController.class);

    @Resource
    private UserService userService;

    @Resource
    private RoleService roleService;


    @RequestMapping(value = "people_info", method = RequestMethod.GET)
    private String peopleInfo() {
        logger.info(" 人员基本信息页面");
        return "peopleManage/people_info";
    }
    @ResponseBody
    @RequestMapping(value = "peopleInfo_insert", method = RequestMethod.POST)
    public ControllerResult infoInsert(User user){
        logger.info("信息添加");

        user.setCompanyId("65dc09ac-23e2-11e7-ba3e-juyhgt91a73a");
        userService.insert(user);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "peopleInfo_pager", method= RequestMethod.GET)
    public Pager4EasyUI<User> info_pager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize){
        logger.info("分页查询所有员工");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(userService.count());
        List<User> users = userService.queryByPager(pager);
        return new Pager4EasyUI<User>(pager.getTotalRecords(), users);
    }

    @ResponseBody
    @RequestMapping(value = "peopleInfo_update", method = RequestMethod.POST)
    public ControllerResult info_update(User user){
        logger.info("信息修改");
        user.setCompanyId("65dc09ac-23e2-11e7-ba3e-juyhgt91a73a");
        userService.update(user);
        return ControllerResult.getSuccessResult(" 修改成功");
    }

    @ResponseBody
    @RequestMapping(value = "peopleInfo_status", method = RequestMethod.GET)
    public ControllerResult info_status(@Param("id")String id, @Param("status")String status){
        logger.info("状态修改");
        if(status.equals("Y")){
            userService.inactive(id);
        } else {
            userService.active(id);
        }
        return ControllerResult.getSuccessResult(" 修改成功");
    }

    @ResponseBody
    @RequestMapping(value = "user_all", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryUserAll() {
        logger.info("查询员工");
        List<User> users = userService.queryAll();
        List<ComboBox4EasyUI> comboBox4EasyUIs = new ArrayList<ComboBox4EasyUI>();
        for (User user : users) {
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(user.getUserId());
            comboBox4EasyUI.setText(user.getUserName());
            comboBox4EasyUIs.add(comboBox4EasyUI);
        }
        return comboBox4EasyUIs;
    }


    @ResponseBody
    @RequestMapping(value = "query_user", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryByUser(String companyId) {
        logger.info("查询自己公司所有员工");
        List<User> users = userService.queryByUser("65dc09ac-23e2-11e7-ba3e-juyhgt91a73a"); // session里面的companyId
        List<ComboBox4EasyUI> comboBox4EasyUIs = new ArrayList<ComboBox4EasyUI>();
        for (User user : users) {
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(user.getUserId());
            comboBox4EasyUI.setText(user.getUserName());
            comboBox4EasyUIs.add(comboBox4EasyUI);
        }
        return comboBox4EasyUIs;
    }
}


