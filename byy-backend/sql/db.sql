
use my_db;

    -- 接口信息
create table if not exists api.`interface_info`
(
    `id` bigint not null auto_increment comment '主键' primary key,
    `name` varchar(256) not null comment '名称',
    `description` varchar(256) null comment '描述',
    `url` varchar(512) not null comment '接口地址',
    `requestParams` text not null comment '请求参数',
    `requestHeader` text null comment '请求头',
    `responseHeader` text null comment '响应头',
    `status` int default 0 not null comment '接口状态（0-关闭，1-开启）',
    `method` varchar(256) not null comment '请求类型',
    `userId` bigint not null comment '创建人',
    `createTime` datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    `updateTime` datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    `isDelete` tinyint default 0 not null comment '是否删除(0-未删, 1-已删)'
    ) comment '接口信息';

insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values
('getPicture', '每日图片', '
http://localhost:8123/api/picture/get', '
{"Content-Type":"application/json"}', '
{"Content-Type":"application/json"}', 0, 'POST', 1);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('段子轩', '谢睿渊', 'www.tracey-ernser.net', '傅乐驹', '龙锦程', 0, '曾鸿涛', 335747354);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('韩靖琪', '万明辉', 'www.morris-hammes.biz', '何越彬', '林泽洋', 0, '侯天宇', 1);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('蒋航', '许黎昕', 'www.marilynn-mitchell.biz', '邵昊焱', '赖智辉', 0, '钱烨伟', 92190);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('郝擎苍', '陆晟睿', 'www.michale-satterfield.net', '尹雪松', '崔思源', 0, '段笑愚', 9908260794);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('张文博', '朱远航', 'www.german-oberbrunner.com', '叶金鑫', '覃煜城', 0, '田擎苍', 43);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('于越彬', '洪鹏', 'www.dino-jones.io', '于雨泽', '戴伟泽', 0, '曾子骞', 680);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('曾凯瑞', '萧文', 'www.huey-bechtelar.info', '赖聪健', '宋伟宸', 0, '陈鹏', 816767973);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('范思聪', '蒋聪健', 'www.murray-kerluke.biz', '姚晓博', '许伟祺', 0, '王思', 16813069);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('曹鹏', '雷浩然', 'www.malcolm-runolfsdottir.biz', '白雪松', '洪懿轩', 0, '钱致远', 160795);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('王弘文', '杜伟诚', 'www.marlin-wilkinson.org', '尹鑫鹏', '孔航', 0, '卢昊强', 30);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('贺雨泽', '沈梓晨', 'www.jefferson-mitchell.org', '段擎宇', '董越彬', 0, '方乐驹', 55988439);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('夏雪松', '冯哲瀚', 'www.catherin-okeefe.biz', '曹彬', '汪致远', 0, '韦展鹏', 2);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('罗正豪', '任苑博', 'www.chad-osinski.io', '龙子骞', '曾健柏', 0, '邵黎昕', 547);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('雷修洁', '王致远', 'www.edmond-howell.io', '何锦程', '胡博超', 0, '袁耀杰', 800079);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('徐振家', '田文博', 'www.abel-bergnaum.name', '郭黎昕', '廖浩然', 0, '龙思淼', 88738099);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('李睿渊', '韩峻熙', 'www.delicia-paucek.biz', '钟驰', '崔笑愚', 0, '张鹭洋', 74701803);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('蔡鹤轩', '严昊天', 'www.bettye-simonis.com', '阎展鹏', '唐荣轩', 0, '江智渊', 6389120279);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('杨航', '石建辉', 'www.marshall-christiansen.net', '唐智辉', '戴君浩', 0, '吴晓博', 83305451);
insert into my_db.`interface_info` (`name`, `description`, `url`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`) values ('吕晓啸', '王鹏', 'www.rubi-kuvalis.com', '金天磊', '金峻熙', 0, '方立辉', 38619);

-- 用户调用接口关系表
create table if not exists my_db.`user_interface_info`
(
    `id` bigint not null auto_increment comment '主键' primary key,
    `userId` bigint not null comment '调用用户 id',
    `interfaceInfoId` bigint not null comment '接口 id',
    `totalNum` int default 0 not null comment '总调用次数',
    `leftNum` int default 0 not null comment '剩余调用次数',
    `status` int default 0 not null comment '0-正常，1-禁用',
    `createTime` datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    `updateTime` datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    `isDelete` tinyint default 0 not null comment '是否删除(0-未删, 1-已删)'
) comment '用户调用接口关系';

