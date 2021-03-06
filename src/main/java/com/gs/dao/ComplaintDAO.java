package com.gs.dao;

import com.gs.bean.Complaint;
import com.gs.bean.User;
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
public interface ComplaintDAO extends BaseDAO<String, Complaint>{

    /**
     * 回复更新
     *
     */
    public void updateReply(Complaint complaint);

    /**
     * 根据指定的{top}查询前{top}条数据
     * @param top
     * @param user
     * @return
     */
    public List<Complaint> queryByTop(@Param("top") int top, @Param("user") User user);

    /*
    * 车主查询自己的投诉
    * */

    public List<Complaint> queryByPagerUser(@Param("user")User user,@Param("pager")Pager pager);
    public int countByUser(User user);


}