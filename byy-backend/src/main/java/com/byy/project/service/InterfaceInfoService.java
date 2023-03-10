package com.byy.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.byy.byycommon.model.entity.InterfaceInfo;

/**
* @author 60410
* @description 针对表【interface_info(接口信息)】的数据库操作Service
* @createDate 2023-01-23 14:53:22
*/
public interface InterfaceInfoService extends IService<InterfaceInfo> {
     void validInterfaceInfo(InterfaceInfo interfaceInfo, boolean add);
}
