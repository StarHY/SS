package com.gs.service;

import com.gs.bean.Permission;
import com.gs.common.bean.Pager;

import java.util.List;

/**
 * 由Wjhsmart技术支持
 *
 * @author Wjhsmart
 * @since 2017-04-14 16:36:52
 */
public interface PermissionService extends BaseService<String, Permission> {

    /**根据模块编号来查询权限*/
    public List<Permission> queryByModuleId(String moduleId);

    /**根据模块编号来分页*/
    public List<Permission> queryByModulePager(String moduleId, Pager pager);

    /**根据状态来分页*/
    public List<Permission> queryByStatusPager(String status, Pager pager);

    /**根据模块编号来统计*/
    public int countModule(String moduleId);

    /**根据状态来统计*/
    public int countStatus(String status);

    /**根据一段字符串查询权限表是否有这个权限名*/
    public int queryPNIsExist(String pName);

    /**根据一段字符串查询权限表是否有这个中文权限名*/
    public int queryPZHNExist(String zhName);
}