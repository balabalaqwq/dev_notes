# Utils

```
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vma_edu/dialog/IosLoadingDialog.dart';
import 'dart:io';

import 'package:vma_ky/Utils/ToastUtil.dart';

class CommonUtil {
  /// 函数防抖 过滤重复点击
  ///
  /// [func]: 要执行的方法
  /// [delay]: 要迟延的时长
  static Function debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 1000),
  ]) {
    Timer timer;
    Function target = () {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () {
        func?.call();
      });
    };
    return target;
  }

  /// 函数节流
  ///
  /// [func]: 要执行的方法
  static Function throttle(
    Future Function() func,
  ) {
    if (func == null) {
      return func;
    }
    bool enable = true;
    Function target = () {
      if (enable == true) {
        enable = false;
        func().then((_) {
          enable = true;
        });
      }
    };
    return target;
  }

  /// 复制文本到剪切板
  static copyText(String text) {
    Clipboard.setData(ClipboardData(
        text: text))
        .then(ToastUtil.showToast('已复制到剪切板'));
  }
  
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Future requestPermission(Permission permission) async {
    PermissionStatus permissionStatus;
    // 申请权限
    if (Platform.isAndroid) {
      await [permission].request().then((value) {
        permissionStatus = value[permission];
        if (permissionStatus != PermissionStatus.granted) {
          Fluttertoast.showToast(msg: "权限请求失败！");
        }
      });
      debugPrint("请求权限,并获取权限:$permissionStatus");
    }
  }

  static toastWithCatch(String error) {
    List<String> list = error.split(',');
    for (int i = 0; i < list.length; i++) {
      if (list[i].contains('errorMessage')) {
        ToastUtil.showToast(list[i + 1]);
        break;
      }
    }
  }

  static Widget getW_Magin(double w) {
    return Container(
      width: w,
      height: 1,
    );
  }

  static Widget getH_Magin(double h) {
    return Container(
      width: 1,
      height: h,
    );
  }

  static void push(BuildContext context, Widget page) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return page;
    }));
  }

  static saveImgToLocal(
    BuildContext c,
    String url,
  ) async {
    IosLoadingDialog.showLoading(c);
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 80,
    );
    print(result);
    IosLoadingDialog.dismiss(c);
    if (result.toString().contains('true')) {
      ToastUtil.showToast('保存图片成功');
    } else {
      ToastUtil.showToast('保存图片失败');
    }
  }
}

```



## ToastUtil  (待完善)

```
import 'package:fluttertoast/fluttertoast.dart';
class ToastUtil {

  static showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      // 消息框弹出的位置
      timeInSecForIosWeb: 1,
      // 消息框持续的时间（目前的版本只有ios有效）
    );
  }

}
```

