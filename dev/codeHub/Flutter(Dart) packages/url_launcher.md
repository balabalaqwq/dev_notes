## SMS：

### 跳转系统群发短信（iOS不可用）:

android：收件人用;分隔

ios:见flutter_sms

```
if (Platform.isAndroid) {
// Android：收件人用;隔开
  var uri =
      "sms:+${"10000;10086;"}?body=${"短信内容"}";
  await launch(uri);
} else if (Platform.isIOS) {
  // iOS：收件人群发不可用
}
```