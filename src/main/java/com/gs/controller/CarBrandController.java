package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarBrand;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.CarBrandService;
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
 * Created by root on 2017/4/16.
 */
@Controller
@RequestMapping("/carBrand")
public class CarBrandController {

    @Resource
    private CarBrandService carBrandService;
    private Logger logger = (Logger) LoggerFactory.getLogger(CarBrandController.class);

    @ResponseBody
    @RequestMapping(value = "insertCarBrand", method = RequestMethod.POST)
    public ControllerResult insertCarBrand(CarBrand carBrand){
        logger.info("添加汽车品牌成功");
        carBrandService.insert(carBrand);
        return ControllerResult.getSuccessResult("添加汽车品牌成功");
    }

    @ResponseBody
    @RequestMapping(value = "uploadCarBrand",method = RequestMethod.POST)
    public ControllerResult uploadCarBrand(CarBrand carBrand){
            carBrandService.update(carBrand);
            logger.info("更新汽车品牌成功");
            return ControllerResult.getSuccessResult("更新汽车品牌成功");
    }

    @ResponseBody
    @RequestMapping(value = "StatusInactive" , method = RequestMethod.GET)
    public ControllerResult statusInactive(String Id){
        if(Id!=null){
            return ControllerResult.getSuccessResult(",.,.,.,.");
        }
        return ControllerResult.getFailResult("///////////////////");
    }

    @ResponseBody
    @RequestMapping(value = "queryByPager" , method = RequestMethod.GET)
    public Pager4EasyUI<CarBrand> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize){
        Pager pager = new Pager();
        logger.info("分页查询所有车牌");
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carBrandService.count());
        List<CarBrand>carBrandList = carBrandService.queryByPager(pager);
        return new Pager4EasyUI<CarBrand>(pager.getTotalRecords(),carBrandList);
    }

    @ResponseBody
    @RequestMapping(value = "car_brand_all", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryCarBrandAll() {
        logger.info("查询汽车品牌");
        List<CarBrand> carBrands = carBrandService.queryAll();
        List<ComboBox4EasyUI> comboBox4EasyUIs = new ArrayList<ComboBox4EasyUI>();
        for (CarBrand carBrand : carBrands) {
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(carBrand.getBrandId());
            comboBox4EasyUI.setText(carBrand.getBrandName());
            comboBox4EasyUIs.add(comboBox4EasyUI);
        }
        return comboBox4EasyUIs;
    }
}
