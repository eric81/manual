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