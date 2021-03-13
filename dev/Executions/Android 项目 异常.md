## CLEARTEXT communication to " + host + " not permitted by network security policy

参考https://www.jianshu.com/p/02956bdddd2d

### 报错信息

```
java.net.UnknownServiceException: CLEARTEXT communication to 47.92.0.113 not permitted by network security policy
```

### 原因

由于 Android P 限制了明文流量的网络请求，非加密的流量请求都会被系统禁止掉。

如果当前应用的请求是 htttp 请求，而非 https ,这样就会导系统禁止当前应用进行该请求，如果 WebView 的 url 用 http 协议，同样会出现加载失败，https 不受影响。

为此，OkHttp3 做了检查，所以如果使用了明文流量，默认情况下，在 Android P 版本 OkHttp3 就抛出异常: CLEARTEXT communication to " + host + " not permitted by network security policy

### 解决办法（四种）

方法1.在AndroidManifest.xml中application配置上添加

```bash
android:usesCleartextTraffic="true"
```

方法2.在 res 下新建一个 xml 目录，然后创建一个名为：network_security_config.xml 文件 ，该文件内容如下：



```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true" />
</network-security-config>
```

然后在 AndroidManifest.xml application 标签内应用上面的xml配置：



```bash
android:networkSecurityConfig="@xml/network_security_config"
```

方法3.服务器和本地应用都改用 https (推荐)

方法4.targetSdkVersion 降级回到 27