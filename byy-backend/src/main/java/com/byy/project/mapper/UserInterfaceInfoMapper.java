package com.byy.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.byy.byycommon.model.entity.UserInterfaceInfo;

import java.util.List;

/**
* @author 60410
* @description 针对表【user_interface_info(用户调用接口关系)】的数据库操作Mapper
* @createDate 2023-02-01 16:58:43
* @Entity generator.domain.UserInterfaceInfo
*/
public interface UserInterfaceInfoMapper extends BaseMapper<UserInterfaceInfo> {
    List<UserInterfaceInfo> listTopInvokeInterfaceInfo(int limit);
}




