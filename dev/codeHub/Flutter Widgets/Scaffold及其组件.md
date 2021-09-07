# Scaffold 及其组件



## snackBar、bottomSheet的使用：

```
@override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
    ...
 body: Builder(//通过Builder传context 不然拿不到context
        builder: (BuildContext context) {
          return _buildBody(context);
        },
      ),
    );
  }
  _buildBody(BuildContext context) {
    return RaisedButton(
                    onPressed: () {
                  //弹出snackBar    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('测试'),
                        ),
                      );
                       //弹出bottomSheet
                       Scaffold.of(context).showBottomSheet((context) => _buildARCodeView(context));
                    },
                  );
    }
```



### FloatingActionButton 

#### 自定义按钮位置：

![](https://gitee.com/balabalaqwq/pics/raw/master/image-20210531134240567.png)

使用方法

```
//参照默认位置点 向上偏移75
floatingActionButtonLocation: CustomFloatingActionButtonLocation(FloatingActionButtonLocation.endFloat, 0, -75),
```

自定义位置

```
import 'package:flutter/material.dart';

///根据参照点位置进行偏移
class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  ///参照点位置
  FloatingActionButtonLocation location;
  ///X方向的偏移量
  double offsetX;
  ///Y方向的偏移量
  double offsetY;

  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}
```