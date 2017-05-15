package com.gs.service;

import com.gs.bean.Accessories;
import com.gs.bean.AccessoriesType;
import com.gs.bean.User;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-14 16:36:51
*/
public interface AccessoriesService extends BaseService<String, Accessories>{

    public List<Accessories> queryByStatusPager(String accStatus, Pager pager, User user);

    public int countByStatus(String status, User user);

    public List<Accessories> queryByIdPager(@Param("id") String id, @Param("pager") Pager pager, User user);

    public int countByTypeId(String accTypeId, User user);

    public int countByCondition(Accessories accessories, User user);

    public List<Accessories> queryByCondition(Pager pager, Accessories accessories, User user);

    public void updateIdle(@Param("id") String id, @Param("lastCount") int lastCount, User user);

    /**领料申请同意后批量更新最近领料时间及库存*/
    public void updateTotalAndIdle(List<Accessories> accessories);

    /**查询出对应配件编号对应的库存及可用数量*/
    public Accessories queryByIdTotalAndIdle(String accId);

}