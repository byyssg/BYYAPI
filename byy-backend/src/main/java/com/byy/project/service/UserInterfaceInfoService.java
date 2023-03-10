package com.byy.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.byy.byycommon.model.entity.UserInterfaceInfo;

/**
* @author 60410
* @description 针对表【user_interface_info(用户调用接口关系)】的数据库操作Service
* @createDate 2023-02-01 16:58:43
*/
public interface UserInterfaceInfoService extends IService<UserInterfaceInfo> {
     void validUserInterfaceInfo(UserInterfaceInfo userInterfaceInfo, boolean add);
     /**
      * 调用接口统计
      * @param interfaceInfoId
      * @param userId
      * @return
      */
     boolean invokeCount(long interfaceInfoId, long userId );

     boolean leftNum(long userId);
}
