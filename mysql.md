## 卸载

1. 检查mysql状态：`service mysql status`     
![img](http://img1.ph.126.net/PKzZqWVnA5gY8zIJOEUmSA==/6631657103933402710.png)
1. 停止mysql：`service mysql stop`

1. 查看已安装的mysql包：`rpm -qa | grep -i mysql`
![img](http://img2.ph.126.net/qmDlFlR4TZpJ0sip_IbkYA==/6631775851189201922.png)
1. 删除已安装的mysql包：`rpm -ev 包名`

1. 查看mysq残余文件夹：`find / -name mysql`
![img](http://img1.ph.126.net/hqwfqyIwiAS13_Rm_KqGHg==/6631783547770602037.png)
1. 删除mysql残余文件夹

## 安装

1. 安装server端：`rpm -ivh ***.rpm`

1. 安装好后会随机生成root密码，保存在/root/.mysql_secret文件中
![img](http://img1.ph.126.net/g5AJcmCdGPSEV9J9NpZIHA==/6631692288305486410.png)
1. 启动mysql：`/etc/rc.do/init.d/mysql start`

1. 安装client端：`rpm -ivh ***.rpm`

1. 登陆mysql命令行：`mysql -u root -p`

1. 修改root密码：`SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');`

1. 授权远程登录：`grant all PRIVILEGES on *.* to 'root' identified by 'password' WITH GRANT OPTION;`

## 启停

`service mysql start`
`service mysql stop`

## 更改编码

1. 查询服务器编码信息
`SHOW VARIABLES LIKE 'char%'`

1. 配置文件my.ini中的[mysqld]部分增加编码信息
`character_set_server = utf8`