# 项目背景

API接口调用平台，帮助企业、个人统一开放接口，减少沟通成本，避免重复造轮子，为业务高效赋能。

- 普通用户：注册登录，开通接口调用权限，使用接口。
- 后台：调用统计和可视化分析接口调用情况，管理员发布接口、下线接口、新增接口。

主要功能：

- API接入
- 防止攻击（安全性） 
- 不能随便调用（限制、开通） 
- 统计调用次数 
- 计费 
- 流量保护

架构图：
![image.png](https://cdn.nlark.com/yuque/0/2022/png/1518177/1671091690956-6eb1c6d1-07b3-4c12-9257-28b99e63cc52.png#averageHue=%23fcfcfc&clientId=u77cd8f41-c193-4&from=paste&height=612&id=u411e47da&name=image.png&originHeight=612&originWidth=1096&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64160&status=done&style=none&taskId=uc28e9716-c68a-4e00-9ffb-6fd46bb8324&title=&width=1096)
技术选型：
前端：

- Ant Design Pro
- React
- Ant Design Procomponents
- Umi
- Umi Request(Axios的封装)

后端：

- Spring Boot
- Spring Boot Starter(SDK开发)
- Dubbo (RPC)
- Nacos(注册中心)
- Spring Cloud Gateway(网关、限流、日志实现)

启动方式：
后端：

- byy-backend：7529端口，后端接口管理（上传、下线、用户登录）[http://localhost:7529/api/doc.html](http://localhost:7529/api/doc.html)

- byy-gateway：8090端口，网关

- byy-interface：8123端口，提供各种接口服务（可以有很多个且分布在各个服务器）。这里的tests有个发送请求的跑通流程的测试用例。

- byy-client-sdk：客户端SDK，无端口，发送请求到8090端口，由网关进行转发到后端的api-interface

- byy-common:目的是让方法、实体类在多个项目间复用，重复编写

## 二、开发api-interface

byy-interface是我们自定义的api接口

### 调用接口的方式

自定义的api接口，那么其他服务怎么调用呢？

- HttpClient 

- RestTemplate 

- 第三方库(OKHTTP、Hutool)   [https://hutool.cn/docs](https://hutool.cn/docs/#/http/Http%E5%AE%A2%E6%88%B7%E7%AB%AF%E5%B7%A5%E5%85%B7%E7%B1%BB-HttpUtil)
  
  ### API签名认证
  
  为了保证安全性，不能随便访问我们的API接口，所以需要签发签名和使用签名(校验签名)。
  流程：前端通过在请求头带上accessKey参数，后端通过String accessKey = request.getHeader("accessKey"); 方法取出，在数据库内比对secretKey 。一致才让客户访问，并让调用次数+1。

- accessKey：调用的标识userA,userB(复杂、无序、无规律)

- secretKey：密钥（复杂、无序、无规律）该参数不能放到请求头中 

- (两者类似用户名和密码，但是ak、sk是无状态的，要求每次访问都带上)

可以通过md5进行非对称加密生成签名，还可以考虑增加时间戳、随机数进行防重。

```vue
import cn.hutool.crypto.digest.DigestAlgorithm;
import cn.hutool.crypto.digest.Digester;

/**
 * 签名工具
 */
public class SignUtils {
    /**
     * 生成签名
     */
    public static String genSign(String body, String secretKey) {
        Digester md5 = new Digester(DigestAlgorithm.SHA256);
        String content = body + "." + secretKey;
        return md5.digestHex(content);
    }
}
```

### SDK（starter）开发

开发者不需要每次都写一遍签名算法，可以抽取出来做一个单独的starter。以后使用只需要引入并且配置好accessKey 和secretKey 就可以了。
一般分下面几步骤，具体代码参考client-sdk模块。

- 依赖环境写在pom.xml文件，移除build部分

- 编写配置类（启动类）

- 注册配置类（启动类）到resources/META_INF/spring.factories文件中

- mvn install 打包到自己的本地仓库（后续也可以发布到自己的maven网上仓库）
  
  ## 三、开发api-backend
  
  api-backend是本项目的管理后台，上线、下线、接口发布、接口调用分析等功能。
  下面是一个接口的示例：
  
  
  ![274a7116-34a0-459e-b4d3-ca9348c82bc2](file:///C:/Users/60410/Pictures/Typedown/274a7116-34a0-459e-b4d3-ca9348c82bc2.png)
  
  ### 上线和下线接口（管理员）
  
  接口管理，上线和下线功能。仅管理员可以操作。
  后台接口：校验该接口是否存在、判断该接口是否可以调用（调用一次）、修改接口数据库中的状态字段为1 
  下线接口：校验该接口是否存在、修改接口数据库中的状态字段为0
  具体代码参考InterfaceInfoController 
  
  ### 申请签名
  
  用户注册成功的时候，自动分配ak和sk。TODO：可以改成申请的方式。
  
  ### 在线调用
  
  先跑通整个接口流程，再去针对不同的请求头或者接口类型来设计界面和表单，给用户更好的体验。（可以参考 swagger、postman、knife4j) 
  流程： 

- 前端将用户输入的请求参数和要测试的接口发给平台后端 

- (在调用前可以做一些校验) 

- 平台后端去调用模拟接口

![image.png](https://cdn.nlark.com/yuque/0/2022/png/1518177/1671112449314-91566171-5b67-4044-85a9-14a06e4fa2c2.png#averageHue=%23fcfcfc&clientId=u77cd8f41-c193-4&from=paste&height=503&id=u9c7e4ac8&name=image.png&originHeight=503&originWidth=632&originalType=binary&ratio=1&rotation=0&showTitle=false&size=29113&status=done&style=none&taskId=ud14f96b3-71da-423e-baec-a4f64f27c9d&title=&width=632)

## 四、调用统计

### 表格设计

用户和接口的多对多映射表。
![image.png](https://cdn.nlark.com/yuque/0/2022/png/1518177/1671092507156-4e53dc69-e192-4f97-b288-9c00afb5fb23.png#averageHue=%23f6f6f5&clientId=u77cd8f41-c193-4&from=paste&height=246&id=ULWW2&name=image.png&originHeight=246&originWidth=904&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49274&status=done&style=none&taskId=ufe415588-2594-4cff-ac27-45c22bdd8a2&title=&width=904)
为了让用户调用+1的代码复用，一般有拦截器、过滤器、AOP切面等实现方式。但是缺点是只存在于单个项目中，如果每个团队都开发自己的接口，需要重复实现自己的AOP切面。所以我们需要在网关实现！

### 网关学习资料

作用：
1.路由：[https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gateway-request-predicates-factories](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gateway-request-predicates-factories)
2.负载均衡 
3.统一鉴权
4.跨域 [https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#cors-configuration](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#cors-configuration)
5.统一业务处理（缓存） 
6.访问控制 （黑白名单）
7.发布控制（灰度发布） [https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-weight-route-predicate-factory](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-weight-route-predicate-factory)
8.流量染色（给请求头添加一些字段，标明来源）[https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-addrequestheader-gatewayfilter-factory](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-addrequestheader-gatewayfilter-factory)
9.接口保护 

- 限制请求  [https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#requestheadersize-gatewayfilter-factory](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#requestheadersize-gatewayfilter-factory)
- 信息脱敏  [https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-removerequestheader-gatewayfilter-factory](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-removerequestheader-gatewayfilter-factory)
- 降级（熔断）[https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#fallback-headers](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#fallback-headers)
- 限流（令牌桶算法、漏桶算法，RedisLimitHandler可以了解一下）[https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-requestratelimiter-gatewayfilter-factory](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-requestratelimiter-gatewayfilter-factory)
- 超时时间 [https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#http-timeouts-configuration](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#http-timeouts-configuration)
- 重试 [https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-retry-gatewayfilter-factory](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#the-retry-gatewayfilter-factory)

10.统一日志 
11.统一文档，建议用[https://doc.xiaominfo.com/docs/middleware-sources/aggregation-introduction](https://doc.xiaominfo.com/docs/middleware-sources/aggregation-introduction)

技术选型：[https://zhuanlan.zhihu.com/p/500587132](https://zhuanlan.zhihu.com/p/500587132)

- Nginx(全局网关)、Kong网关(API网关，Kong:[https://github.com/Kong/kong),](https://github.com/Kong/kong),)编程成本相对高 
- Spring Cloud Gateway(取代了Zuul)性能高、可以用Java代码来写逻辑，适于学习

本项目网关使用 Spring Cloud Gateway，官方文档如下。
![image.png](https://cdn.nlark.com/yuque/0/2022/png/1518177/1671113345258-d4c10960-5835-4da8-a835-12b12548b1ea.png#averageHue=%23f6f6f6&clientId=u77cd8f41-c193-4&from=paste&height=580&id=u0b746ae8&name=image.png&originHeight=580&originWidth=433&originalType=binary&ratio=1&rotation=0&showTitle=false&size=39995&status=done&style=none&taskId=u603d3525-ea4b-4bbb-8ab0-9beb52cda83&title=&width=433)
两种配置方式，先用配置式，不能满足要求再用编程式。

- 编程式（麻烦但是灵活）[https://spring.io/projects/spring-cloud-gateway/#samples](https://spring.io/projects/spring-cloud-gateway/#samples)
- 配置式（简单）

建议开启网关的级别为trace，方便在开发的过程中代码调试。

```vue
logging:
  level:
    org:
      springframework:
        cloud:
          gateway: trace
```

## 五、开发api-gateway

参考架构图，网关模块。

### 业务逻辑

本项目网关的业务逻辑：
1.用户发送请求到API网关 
2.请求日志 
3.(黑白名单) 
4.用户鉴权（判断ak、sk是否合法）
5.请求的模拟接口是否存在？
6.请求转发，调用模拟接口 
7.响应日志 
8.调用成功，接口调用次数+1
9.调用失败，返回一个规范的错误码

### 具体实现

请求转发使用前缀匹配，例如把所有路径为：/api/**的请求进行转发，转发到http://localhost:8123/api/* 
举个例子：
请求网关：[http://localhost:8090/api/name/get?name=testName]() 
转发到   ：[http://localhost:8123/api/name/get?name=testName](http://localhost:8123/api/name/get?name=testName)

```yaml
server:
  port: 8090

spring:
  cloud:
    gateway:
      routes:
        - id: api_route
          # 把断言成功的转发到哪里
          uri: http://localhost:8123
          # 断言, 预计请求过来的时候的接口是什么样的
          predicates:
            - Path=/api/**
```

代码实现业务逻辑使用了GlobalFilter(编程式)，全局请求拦截处理（类似AOP) 

> 因为网关项目没引入MyBatis等操作数据库的类库，如果该操作较为复杂，可以由backend增删改查项目提供接 口，我们直接调用，不用再重复写逻辑了。调用的方式可以是HTTP请求（用HTTPClient、.用RestTemplate、Feign) 或者用 RPC(Dubbo)

### 遇到问题

预期是等模拟接口调用完成，才记录响应日志、统计调用次数。 但现实是chain.filter方法立刻返回了，直到filter过滤器return后才调用了模拟接口。 原因是：chain.filter是个异步操作，理解为前端的promise 
解决方案：利用response装饰者，增强原有response的处理能力。
了解一下装饰者的设计模式：[抖音-装饰器模式](https://www.douyin.com/user/MS4wLjABAAAAHoc3zNtXsc_XdmD8gZTN3d-Be5Hqcm-jSOIAG7qfpqqVlAGzAF78jBPKFrWfwAoJ?modal_id=7177373131076619531)

## 六、跑通RPC

### 如何调用其他项目的方法

1.复制代码和依赖、环境
2.HTTP请求（提供一个接口，供其他项目调用）
3.RPC
4.把公共的代码打个jar包，其他项目去引用（客户端SDK)

### HTTP请求如何调用

1.提供方开发一个接口（地址、请求方法、参数、返回值）
2.调用方使用HTTP Client之类的代码包去发送HTTP请求

### RPC

作用：像调用本地方法一样调用远程方法。
1.对开发者更透明，减少了很多的沟通成本。
2.RPC向远程服务器发送请求时，未必要使用HTTP（7层）协议，比如还可以用TCP/IP，性能更高。（内部服务更适合）
http不是rpc，rpc可能会用到http协议
![image.png](https://cdn.nlark.com/yuque/0/2023/png/1518177/1673263197638-3b024269-5bcf-42a2-94bd-de114a9a773d.png#averageHue=%23fcfcfc&clientId=u18ed4217-d64d-4&from=paste&height=404&id=u41ec5452&name=image.png&originHeight=404&originWidth=760&originalType=binary&ratio=1&rotation=0&showTitle=false&size=31259&status=done&style=none&taskId=u923a315d-d278-4c19-b40f-ecf99b65291&title=&width=760)

### Dubbo框架(RPC实现)

GRPC、TRPC，最好的学习方式：阅读官方文档[https://dubbo.incubator.apache.org/zh/docs3-v2/java-sdk/quick-start/spring-boot/](https://dubbo.incubator.apache.org/zh/docs3-v2/java-sdk/quick-start/spring-boot/)

两种使用方式：
1.Spring Boot代码（注解+编程式）：写Java接口，服务提供者和消费者都去引用这个接口。
2.IDL接口调用语言)：创建一个公共的接口定义文件（.proto），服务提供者和消费者读取这个文件。优点是跨语言，所有的框架都认识。
![image.png](https://cdn.nlark.com/yuque/0/2023/png/1518177/1673265964602-939b674b-3840-4b0c-ad5f-c55b5b0ec5bb.png#averageHue=%23022d3a&clientId=u18ed4217-d64d-4&from=paste&height=428&id=ua3e095e2&name=image.png&originHeight=428&originWidth=661&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51331&status=done&style=none&taskId=u6a0e550b-b28e-4eed-8b85-7b141be1b9b&title=&width=661)

底层是triple协议：[https://cn.dubbo.apache.org/zh/docs3-v2/java-sdk/concepts-and-architecture/triple/](https://cn.dubbo.apache.org/zh/docs3-v2/java-sdk/concepts-and-architecture/triple/)
示例项目学习zookeeper注册中心（不在本项目使用zk了）：通过内嵌的方式运行，更方便最先启动注册中心，先启动服务提供者，再启动服务消费者。

### 整合运用

1.backend项目作为服务提供者，提供3个方法：
a.实际情况应该是去数据库中查是否已分配给用户
b.从数据库中查询模拟接口是否存在，以及请求方法是否匹配（还可以校验请求参数）
c.调用成功，接口调用次数+1 invokeCount2.gateway项目作为服务调用者，调用这3个方法

[https://dubbo.apache.org/zh/docs3-v2/java-sdk/reference-manual/registry/nacos/](https://dubbo.apache.org/zh/docs3-v2/java-sdk/reference-manual/registry/nacos/)

注意：
1.服务接口类必须要在同一个包下，建议是抽象出一个公共项目（放接口、实体类等）
2.设置注解（比如启动类的EnableDubbo、接口实现类和Bean引用的注解）
3.添加配置
4.服务调用项目和提供者项目尽量引入相同的依赖和配置(避免冲突，尤其是slf4j)

```javascript
<!-- https://mvnrepository.com/artifact/org.apache.dubbo/dubbo -->
<dependency>
    <groupId>org.apache.dubbo</groupId>
    <artifactId>dubbo</artifactId>
    <version>3.0.9</version>
</dependency>
<dependency>
    <groupId>com.alibaba.nacos</groupId>
    <artifactId>nacos-client</artifactId>
    <version>2.1.0</version>
</dependency>
```

## 七、完成项目

### 网关业务逻辑

实际情况应该是去数据库中查是否已分配给用户秘钥(ak、sk是否合法)
1.先根据accessKey判断用户是否存在，查到secretKey.对比secretKey和用户传的加密后的secretKey是否一致
2.从数据库中查询模拟接口是否存在，以及请求方法是否匹配（还可以校验请求参数）
3.todo调用成功，接口调用次数+1 invokeCount
上面这块逻辑写到公共服务里面。

### 公共服务

目的是让方法、实体类在多个项目间复用，重复编写。
1.数据库中查是否已分配给用户秘钥（根据accessKey拿到用户信息，返回用户信息，为空表示不存在）
2.从数据库中查询模拟接口是否存在（请求路径、请求方法、请求参数，返回接口信息，为空表示不存在）
3.接口调用次数+1 invokeCount(accessKey、secretKey(标识用户)，请求接口路径)

步骤：
1.新建干净的maven项目，只保留必要的公共依赖
2.抽取service和实体类
3.install本地maven包
4.让服务提供者引l入common包，测试是否正常运行
5.让服务消费者引入common包

### 问题：如何获取接口转发服务器的地址

网关启动时，获取所有的接口信息，维护到内存的hashmap中；有请求时，根据请求的url路径或者其他参数(比如host请求头)来判断应该转发到哪台服务器、以及用于校验接口是否存在。

### 开发统计分析

#### 需求

各接口的总调用次数占比（饼图）取调用最多的前3个接口，从而分析出哪些接口没有人用（降低资源、或者下线)，高频接口（增加资源、提高收费）

#### 实现

#### 前端

需求：展示饼图推荐要用现成的库！！！
ECharts（推荐）:[https://echarts.apache.org/zh/index.html](https://echarts.apache.org/zh/index.html) 
(AntV:[https://antv.vision/zh(](https://antv.vision/zh()蚂蚁，最推荐)、BizCharts（更炫酷一点）

用法贼简单：
1.看官网
2.找到快速入门、按文档去引入库
3.进入示例页面
4.找到你要的图
5.在线调试
6.复制代码
7.改为真实数据

如果是React项目，用这个库：[https://github.com/hustcc/echarts-for-react](https://github.com/hustcc/echarts-for-react)

#### 后端

写一个接口，得到下列示例数据：
接口A:2次
接口B:3次
1.SQL查询调用数据：select interfacelnfold,sum(totalNum)as totalNum from user_interface_info groupby interfacelnfold order by totalNum desc limit 3;
2.业务层去关联查询接口信息

### 上线

前端：略
后端：

- backend项目：web项目，部署spring boot的jar包（对外的）
- gateway网关项目：web项目，部署spring boot的jar包（对外的）
- interface模拟接口项目：web项目，部署spring boot的jar包（不建议对外暴露的）

关键：网络必须要连通
如果自己学习用：单个服务器部署这三个项目就足够
如果你是搞大事，多个服务器建议在同一内网，内网交互会更快、且更安全

### 扩展

1.怎么让其他用户也上传接口？
a.需要提供一个机制（界面），让用户输入自己的接口host(服务器地址)、接口信息，将接口信息写入数据库。
b.将接口信息写入数据库之前，要对接口进行校验（比如检查他的地址是否遵循规则，测试调用），保证他是正常的。
c.将接口信息写入数据库之前遵循咱们的要求（并且使用咱们的Sdk),在接入时，平台需要测试调用这个接口，保证他是正常的。

2.在interfacelnfo表里加个host字段，区分服务器地址，让接口提供者更灵活地接入系统。

3.网关判断是否还有调用次数

4.网关限流、提高性能等
