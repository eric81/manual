# linux下关闭启动weblogic

## 启动weblogic：
1. 进入目录：`cd /weblogic/wlserver/user_projects/domains/base_domain/bin`

1. 执行 `nohup ./startWebLogic.sh &`（nohup的作用是让weblogic启动在后台运行）

1. 查看启动日志：`tail -f nohup.out`

## 停止weblocgic：

1. 查看后台进程 ：`ps -ef|grep weblogic`

1. 得到如下内容
    `weblogic 22621 22559  0 10:57        00:01:38 /data/weblogic/jdk1.6.0_25/bin/java`

1. 杀后台进程 ：`kill -9 22621`

#Editing weblogic close Hostname Verification(weblogic 关闭证书验证)

生成环境weblogic出现了ca ssl等相关的错误，如：
```
<Notice> <Security> <BEA-090898> <Ignoring the trusted CA certificate
 "CN=GlobalSign,O=GlobalSign,OU=GlobalSign Root CA - R3".
 The loading of the trusted certificate list raised a certificate parsing
 exception PKIX: Unsupported OID in the AlgorithmIdentifier
 object: 1.2.840.113549.1.1.11.> 
```

出现类似和CA相关的错误，可以关闭weblog证书校验去解决。

关闭办法：weblogic控制台，服务器配置中的SSL项， 主机名验证配置改为：“无”

![img](http://img1.ph.126.net/5PW6EgMAt3r1-nuHy7NqpA==/6631805538003723766.png)