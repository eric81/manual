#### 端口占用
```
lsof -i:80 
kill -9 110
```

#### linux shell 删除某个目录下n天前的文档  
```
find /opt/log -type f -mtime -print +4 -exec rm -rf {} \;
```
>该命令将打印/opt/log目录下四天前的所有文件，并将这些文件全部删除。
>注意：结尾必须为{} \; 括号和反斜杠之间有空格，否则会报如下错误：“find: 遗漏“-exec”的参数”
>如果将+4变为-4则为4天内的文档