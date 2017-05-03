package com.gs.dao;

import com.gs.bean.Checkin;
import com.gs.bean.MaintainRecord;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-14 16:35:15
*/
@Repository
public interface MaintainRecordDAO extends BaseDAO<String, MaintainRecord>{
    /**
     * 根据状态计数
     * @param status
     * @return
     */
    public int countByStatus(String status);

    /**
     * 根据状态分页查询
     * @param pager
     * @param status
     * @return
     */
    public List<MaintainRecord> queryPagerByStatus(@Param("pager") Pager pager, @Param("status") String status);

    /**
     * 根据查询条件计数
     * @param record
     * @return
     */
    public int countByCondition(MaintainRecord record);

    /**
     * 根据查询条件分页查询
     * @param pager
     * @param record
     * @return
     */
    public List<MaintainRecord> queryPagerByCondition(@Param("pager") Pager pager, @Param("record") MaintainRecord record);

    /**
     * 根据状态计数
     * @param status
     * @return
     */
    public int countByTrackStatus(String status);

    /**
     * 根据状态分页查询
     * @param pager
     * @param status
     * @return
     */
    public List<MaintainRecord> queryPagerByTrackStatus(@Param("pager") Pager pager, @Param("status") String status);

    /**
     * 根据状态checkId更新
     * @param checkinId
     * @return
     */
    public void updateTrackStatus(@Param("checkinId") String checkinId);

    /**
     * 根据id更新记录的进度
     * @param speedStatus 当前进度
     * @param id 维修保养记录的id
     * @return
     */
    public int updateSpeedStatusById(@Param("speedStatus") String speedStatus, @Param("id") String id);

    /**
     * 根据进度状态计数
     * @param speedStatus
     * @return
     */
    public int countBySpeedStatus(String[] speedStatus);

    /**
     * 根据进度状态分页查询
     * @param pager
     * @param speedStatus
     * @return
     */
    public List<MaintainRecord> queryPagerBySpeedStatus(@Param("speedStatus") String[] speedStatus, @Param("pager") Pager pager);

}