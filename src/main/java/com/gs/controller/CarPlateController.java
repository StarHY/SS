package com.gs.controller;

import com.gs.bean.CarPlate;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.CarPlateService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by root on 2017/4/17.
 */
@Controller
@RequestMapping("/carPlate")
public class CarPlateController {
    private Logger logger = (Logger) LoggerFactory.getLogger(CarPlateController.class);

    @Resource
    private CarPlateService carPlateService;

    @ResponseBody
    @RequestMapping(value = "car_plate_all", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryCarModelAll() {
        logger.info("查询汽车车型");
        List<CarPlate> CarModels = carPlateService.queryAll();
        List<ComboBox4EasyUI> comboBox4EasyUIs = new ArrayList<ComboBox4EasyUI>();
        for (CarPlate carPlatel : CarModels) {
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(carPlatel.getPlateId());
            comboBox4EasyUI.setText(carPlatel.getPlateName());
            comboBox4EasyUIs.add(comboBox4EasyUI);
        }
        return comboBox4EasyUIs;
    }

    @ResponseBody
    @RequestMapping(value = "insertCarPlate", method = RequestMethod.POST)
    public ControllerResult insertCarModel(CarPlate carPlate) {
        logger.info("添加车牌成功");
        System.out.println(carPlate);
        carPlateService.insert(carPlate);
        return ControllerResult.getSuccessResult("添加车牌成功");
    }

    @ResponseBody
    @RequestMapping(value = "uploadCarPlate", method = RequestMethod.POST)
    public ControllerResult uploadCarModel(CarPlate carPlate) {
        carPlateService.update(carPlate);
        logger.info("更新车牌成功");
        return ControllerResult.getSuccessResult("更新车牌成功");
    }

    @ResponseBody
    @RequestMapping(value = "queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<CarPlate> queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        logger.info("分页查询所有车牌");
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carPlateService.count());
        List<CarPlate> carModelList = carPlateService.queryByPager(pager);
        return new Pager4EasyUI<CarPlate>(pager.getTotalRecords(), carModelList);
    }

    @ResponseBody
    @RequestMapping(value="plateStatusModify",method = RequestMethod.GET)
    public ControllerResult colorStatusModify(@Param("id") String id,@Param("status") String status){
        if(status.equals("Y")){
            logger.info("车牌冻结成功");
            carPlateService.inactive(id);
            return ControllerResult.getSuccessResult("车牌冻结成功");
        }else if(status.equals("N")){
            logger.info("车牌激活成功");
            carPlateService.active(id);
            return ControllerResult.getSuccessResult("车牌激活成功");
        }
        logger.info("车牌激活失败");
        return ControllerResult.getFailResult("颜色修改失败");
    }

    @ResponseBody
    @RequestMapping(value="statusPager",method = RequestMethod.GET)
    public Pager4EasyUI<CarPlate> statusPager(@Param("status")String status,@Param("pageNumber") String pageNumber, @Param("pageSize")String pageSize){
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carPlateService.countStatus(status));
        List<CarPlate>carPlates = carPlateService.byStatusPager(status,pager);
        return new Pager4EasyUI<CarPlate>(pager.getTotalRecords(),carPlates);
    }

    @ResponseBody
    @RequestMapping(value="searchPager",method = RequestMethod.GET)
    public Pager4EasyUI<CarPlate> searchPager(@Param("plateName")String plateName,@Param("pageNumber") String pageNumber, @Param("pageSize")String pageSize){
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carPlateService.searchCount(plateName));
        List<CarPlate>carPlates = carPlateService.searchByPager(plateName,pager);
        return new Pager4EasyUI<CarPlate>(pager.getTotalRecords(),carPlates);
    }
}
