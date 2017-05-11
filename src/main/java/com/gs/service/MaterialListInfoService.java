package com.gs.service;

import com.gs.bean.MaterialListInfo;
import com.gs.bean.User;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Xiao-Qiang on 2017/4/26.
 */
public interface MaterialListInfoService extends BaseService<String, MaterialListInfo>{
    /**根据状态分页*/
    public List<MaterialListInfo> queryByStatus(Pager pager, String status, User user);

    /**根据物料清单条件统计*/
    public int termCount(@Param("userName") String userName, String startTime, String endTime, User user);

    /**根据条件分页*/
    public List<MaterialListInfo> termQueryPager(Pager pager,String userName, String startTime, String endTime, User user);

    /**根据维修记录编号分页*/
    public List<MaterialListInfo> queryBySpeedStatus(Pager pager, String recordId, User user);

    /**根据维修记录编号统计*/
    public int countBySpeedStatus(String recordId, User user);

    /**根据维修记录编号和状态分页*/
    public List<MaterialListInfo> queryBySpeedStatusAndStatus(Pager pager, String recordId, String materialStatus, User user);

    /**根据维修记录编号和状态统计物料清单*/
    public int statusCount(String recordId, String materialStatus, User user);
}
