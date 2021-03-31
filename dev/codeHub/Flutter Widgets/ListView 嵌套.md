

https://www.jianshu.com/p/f942a90aa42c

实现ListView中嵌套ListView

![Video_20210224_060853_179](https://gitee.com/balabalaqwq/pics/raw/master/Video_20210224_060853_179.gif)

外部ListView:

```dart
ListView.builder(
  itemBuilder: (context, int index) =>
      item(index),
  itemCount: list1.length,
),
```



内嵌套ListView：

```dart
item(int index) {
	return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        itemBuilder: (context, int index) =>
        item(index),
        itemCount: list2.length,
	);
}
```

主要设置内嵌套ListView的

shrinkWrap: true及
physics: NeverScrollableScrollPhysics()