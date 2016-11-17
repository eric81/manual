官方网站：http://hessian.caucho.com/

官方介绍：The Hessian binary web service protocol makes web services usable without requiring a large framework, and without learning yet another alphabet soup of protocols. Because it is a binary protocol, it is well-suited to sending binary data without any need to extend the protocol with attachments.

Hessian是二进制的web service协议，官方网站提供Java、Flash/Flex、Python、C++、.NET C#等实现。Hessian和Axis、XFire都能实现web service方式的远程方法调用，区别是Hessian是二进制协议，Axis、XFire则是SOAP协议，所以从性能上说Hessian远优于后两者，并且Hessian的JAVA使用方法非常简单。Hessian由于没有WSDL这种服务描述文件去对实现进行规定，似乎更适合内部分布式系统之间的交互，对外提供服务还是使用后两者更体面些。

JAVA服务端使用步骤：

1)导入Hessian的Jar包

2)设计接口

3)实现接口：必须继承HessianServlet，接口参数对象必须实现序列化

4)配置web.xml

```xml
 <!--参数home-api为接口定义，参数home-class为接口实现-->
 <servlet>
  <servlet-name>WztAdaptorService</servlet-name>
  <servlet-class>
   com.caucho.hessian.server.HessianServlet
  </servlet-class>
  <init-param>
   <param-name>home-class</param-name>
   <param-value>com.mapabc.wzt.adapt.inf.impl.WztSynServiceImpl</param-value>
  </init-param>
  <init-param>
   <param-name>home-api</param-name>
   <param-value>com.mapabc.wzt.adapt.inf.WztSynService</param-value>
  </init-param>
 </servlet>
 <servlet-mapping>
  <servlet-name>WztAdaptorService</servlet-name>
  <url-pattern>/service</url-pattern>
 </servlet-mapping>
``` 
  5)部署发布

JAVA客户端使用步骤：

1)导入Hessian的Jar包

2)导入服务端接口原型Jar包

3)获得服务端接口：
```java
   //infURL为服务端接口服务地址
   HessianProxyFactory factory = new HessianProxyFactory();
   AAAService sv = (AAAService) factory.create(AAAService.class,infURL);
```
4)调用接口方法