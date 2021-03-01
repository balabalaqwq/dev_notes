# < Flutter > ListView 局部刷新

实现改变ListView中item状态（例如点赞）

![Video_20201224_111841_368](D:\QQ文件\文档\1255824627\FileRecv\MobileFile\Video_20201224_111841_368.gif)

### 使用GlobalObjectKey

完整代码

```dart
class ListViewWidget extends StatefulWidget {
  @override
  createState() => ListViewWidgetState();
}

class ListViewWidgetState extends State<ListViewWidget> {
  List<String> list = ["1", "2", "3", "4"];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < list.length; i++) buildItem(list[i], i),
      ],
    );
  }

  //构建item
  Widget buildItem(String data, int index) {
    GlobalObjectKey<TestWidgetState> refreshKey =
        GlobalObjectKey<TestWidgetState>(index);//TestWidget为需要刷新的封装组件
    return Row(
      children: [
        TestWidget(refreshKey),
        FlatButton(
          height: 50,
          color: Colors.white,
          onPressed: () {
            refreshKey.currentState.changeColor();
          },
          child: Text(data),
        )
      ],
    );
  }
}

//封装需要刷新的组件
class TestWidget extends StatefulWidget {
  final Key key;

  TestWidget(this.key);

  @override
  createState() => TestWidgetState();
}

class TestWidgetState extends State<TestWidget> {
  bool isPink = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration:
          BoxDecoration(color: isPink ? Colors.greenAccent : Colors.pinkAccent),
    );
  }

  //通过key调用改变状态
  void changeColor() {
    setState(() => isPink = !isPink);
  }
}
```