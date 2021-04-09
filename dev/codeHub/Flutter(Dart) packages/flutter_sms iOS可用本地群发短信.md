# flutter_sms

导入 包

```
import 'package:flutter_sms/flutter_sms.dart';
```

创建群发对象 List<String>参数

```
List<String> recipentsIos = List();
```

具体方法：

```
void _sendSMSIos(String message, List<String> recipents) async {
  String _result =
      await FlutterSms.sendSMS(message: message, recipients: recipents)
          .catchError((onError) {
    print('===onError:$onError');
  });
  print(_result);
}
```