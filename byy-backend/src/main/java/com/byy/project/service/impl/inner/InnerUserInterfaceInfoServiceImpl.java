package com.byy.project.service.impl.inner;

import com.byy.byycommon.service.InnerUserInterfaceInfoService;
import com.byy.project.service.UserInterfaceInfoService;
import org.apache.dubbo.config.annotation.DubboService;

import javax.annotation.Resource;

@DubboService
public class InnerUserInterfaceInfoServiceImpl implements InnerUserInterfaceInfoService {

    @Resource
    private UserInterfaceInfoService userInterfaceInfoService;

    @Override
    public boolean invokeCount(long interfaceInfoId, long userId) {
        return userInterfaceInfoService.invokeCount(interfaceInfoId, userId);
    }

    @Override
    public boolean leftNum(long userId) {
        return userInterfaceInfoService.leftNum(userId);
    }
}
