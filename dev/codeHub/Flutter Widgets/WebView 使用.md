依赖



导入

```
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
```

主要代码（加载URL、富文本、响应拨打电话）

```

String webUrl = "url";//外链url
String content = "<p>html content<p>";//富文本内容
String url = "";
bool loadFinish = false;//loading状态
@override
  void initState() {
    super.initState();
    url = widget.advInfo.url ?? Uri.dataFromString(widget.advInfo?.content,mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString();//需import 'dart:convert'
  }
	... 
  //webview配置
  Widget getWebView() {
  return Stack(
    children: [
      if (url != "")
        WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) async {
          	///响应拨打手机launch 依赖url_launcher: ^5.1.2
            if(request.url.contains("tel")) {
              await launch(request.url);
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (url) {
            debugPrint("输出结果${url}");
            if (mounted) {
              setState(() {
                loadFinish = true;
              });
            }
          },
        ),
      Visibility(
          visible: !loadFinish,
          child: Container(
              alignment: Alignment.center,
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 50.h, //flutter_screenutil适配方案
                height: 50.h,
              ))),
    ],
  );
}
```