## SMS：

### 跳转系统群发短信:

android：收件人用;分隔

ios:收件人用\n分隔(换行符)

```
if (Platform.isAndroid) {
// iOS：收件人用;隔开
  var uri =
      "sms:+${"10000;10086;"}?body=${"短信内容"}";
  await launch(uri);
} else if (Platform.isIOS) {
  // iOS：收件人用\n隔开
  var uri =
      'sms:${"10000\n10086\n"}&body=${"短信内容"}';
  await launch(uri);
}
```