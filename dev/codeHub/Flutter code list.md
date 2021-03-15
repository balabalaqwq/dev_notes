# Flutter codes

### 1.延时执行

### 参考https://developer.aliyun.com/article/769879

```
//Future
	///代码清单 1-1 
    ///方式一
    ///参数一 延时的时间
    ///参数二 延时执行的方法
    Future.delayed(Duration(milliseconds: 1000), () {
      print("延时1秒执行");
    });
    
    ///代码清单 1-2
    ///方式二
    Future.delayed(Duration(milliseconds: 1000)).whenComplete((){
      print("延时1秒执行 whenComplete ");
    });
    
    ///代码清单 1-3
    ///方式二
    Future.delayed(Duration(milliseconds:1000)).then((value){
      print("延时1秒执行 then ");
    });
    
    ///代码清单 1-4 链式调用
    Future.delayed(Duration(milliseconds: 1000), () {
      print("延时1秒执行");
      return Future.value("测试数据");
    }).then((value) {//函数一
      print(" then  $value");
      return Future.value("测试数据 2");
    }).then((value) {///函数二
      print(" then  $value");
      return Future.value("测试数据 2");
    }).then((value) {//函数三
      ///value 就是 函数一中回传的值
      print(" then  $value");
    });
```

```
//Timer
 	///延时2秒
    Timer timer =  new Timer(Duration(milliseconds: 2000), (){

    });
    
    ///2秒周期性执行
    Timer timer = new Timer.periodic(new Duration(seconds: 2), (timer){

    });
```



### 2.文件操作

### 参考https://blog.csdn.net/lxd_love_lgc/article/details/106789500

```
//创建文件夹
	folderExists(String filepath) async {
        var file = Directory(filepath);
        try {
          bool exists = await file.exists();
          if (!exists) {
            await file.create();
          }
        } catch (e) {
          print(e);
        }
    }
```

```
//创建文件
 	Future<File> getFile(String path,String fileName) async {
        final filePath = path+"/"+fileName;
        return new File(filePath);
    }
```

```
//删除文件
 	Directory directory = new Directory(path);
    if (directory.existsSync()) {
        List<FileSystemEntity> files = directory.listSync();
        if (files.length > 0) {
          files.forEach((file) {
            file.deleteSync();
          });
        }
        directory.deleteSync();
	}
```

### 3.多选/全选

### 参考

```
//初始化  Customer数据类   
	List<Customer> customerList = [];//数据列表
  	List<Customer> selectedCustomerList = [];//已选数据列表
  	@override
    void initState() {
      super.initState();
      getAllCustomer();//加载数据操作
      selectedCustomerList.clear();//清空已选 条件筛选等操作时也需清空
    }
```

```
//选择/取消 操作
 	if (selectedCustomerList.contains(customer)) {           selectedCustomerList.remove(customer);
    } else {
      selectedCustomerList.add(customer);
    }
```

```
//判断是否全选
 	selectedCustomerList.length == customerList.length;
```

### 4.返回键拦截（再按一次退出APP）

### 参考https://blog.csdn.net/weixin_33788244/article/details/94247886

SystemNavigator.pop退出应用需导入：

```
import 'package:flutter/services.dart';
```

使用WillPopScope()包裹应用首页，然后自定义返回键操作

```dart
 DateTime lastPopTime;//记录退出操作时间
 @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return WillPopScope(
      child: Scaffold(
      ),
      onWillPop: () async{
        // 点击返回键的操作 设置2s内再次返回才退出APP
        if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
          lastPopTime = DateTime.now();
          Fluttertoast.showToast(msg: '再按一次退出');
        }else{
          lastPopTime = DateTime.now();
          // 退出app
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
    );
  }

```



### 5.倒计时

```
//倒计时方法
startCountdown() {
  //倒计时时间
  countdownTime = 60;
  final call = (timer) {
    if (countdownTime < 1) {
      setState(() {
        verifybordercolor = ColorConfig.border_blue;
        smsCodeText = "获取验证码";
        autofocus = true;
      });
    } else {
      if (countdownTime > 0) {
        setState(() {
          verifybordercolor = ColorConfig.home_hint_gray;
          smsCodeText = countdownTime.toString() + "秒后重发";
          autofocus = false;
        });
      }
      setState(() {
        countdownTime -= 1;
      });
    }
  };
  if (timer == null) {
    timer = Timer.periodic(Duration(seconds: 1), call);
  }
}
```

### 5.手机号判断

```
RegExp exp = RegExp(
    r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
bool matched = exp.hasMatch(mobilePhone);
```

### 3.播报

```
Swiper(
  itemBuilder: (BuildContext context, int index) {
    return content();
  },
  autoplayDisableOnInteraction: false,
  loop: true,
  itemCount: broadcastList.length,
  control: null,
  duration: 500,
  //禁用手势
  physics: new NeverScrollableScrollPhysics(),
  //水平方向
  scrollDirection: Axis.horizontal,
  viewportFraction: 0.95,
  autoplay: true,
  //点击响应
  onTap: (int) {},
)
```