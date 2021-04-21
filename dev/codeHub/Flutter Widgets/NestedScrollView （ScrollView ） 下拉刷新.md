## NestedScrollView （ScrollView ）下拉刷新

参考及引用https://blog.csdn.net/zl18603543572/article/details/104035299

![image-20210331203216514](https://gitee.com/balabalaqwq/pics/raw/master/image-20210331203216514.png)

默认RefreshIndicator内层为列表才生效 ，使第二种可行需设置 notificationPredicate 方案见引用 ：

https://biglead.blog.csdn.net/article/details/109477589

例：

> 注意：_buildNestedScrollView()不能为SingleChildScrollView()，可用
>
> CustomScrollView(
>       slivers: [
>         SliverToBoxAdapter(
>           child: _buildBody();
>           ),
>      ]
>
> )
>
> 代替

```
Scaffold(
  appBar: AppBar(
    centerTitle: true,
    brightness: Brightness.light,
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Image.asset(
        'images/icon_back.png',
        width: 40.h,
        height: 40.h,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Container(
      width: 500.w,
      child: new TabBar(
        controller: tabController,
        tabs: _tabs.map((f) => Tab(text: f)).toList(),
        indicatorColor: Color(0xff2F5AFE),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Color(0xFF999999),
        labelColor: Color(0xff2F5AFE),
        unselectedLabelStyle: TextStyle(
            fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: false),
            fontWeight: FontWeight.normal),
        labelStyle: TextStyle(
            fontSize: ScreenUtil().setSp(36, allowFontScalingSelf: false),
            fontWeight: FontWeight.bold),
      ),
    ),
  ),
  backgroundColor: Colors.white,
  body: RefreshIndicator(
    //可滚动组件在滚动时会发送ScrollNotification类型的通知
    notificationPredicate: (ScrollNotification notifation) {
      //该属性包含当前ViewPort及滚动位置等信息
      ScrollMetrics scrollMetrics = notifation.metrics;
      if (scrollMetrics.minScrollExtent == 0) {
        return true;
      } else {
        return false;
      }
    },
    //下拉刷新回调方法
    onRefresh: () async {
    //模拟耗时
      await Future.delayed(Duration(milliseconds: 1000), () {
        
      });
      //返回值以结束刷新
      return Future.value(true);
    },
    child: _buildNestedScrollView(),
  ),
);
```