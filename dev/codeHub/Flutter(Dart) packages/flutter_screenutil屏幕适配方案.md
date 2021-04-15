# flutter_screenutil



### 使用

```
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

在override的build方法下添加配置 如下设定750*1334为设计稿大小

```
@override
  Widget build(BuildContext context) {
  ///在每个页面中添加配置
  ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
  return Scaffold(...);
}
```

#### 具体使用：

设置宽度（或高度）width：

width: 100.w,//按照设计稿宽度进行适配

width: 100.h,//按照设计稿高度进行适配

设置字体大小fontsize：

fontsize: 100.sp,

### 注意

适配值不是常量，不能用const修饰