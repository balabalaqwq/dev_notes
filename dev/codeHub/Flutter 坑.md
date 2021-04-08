### 1.TextField未失去焦点时跳转页面后，返回页面会弹出键盘

参考https://segmentfault.com/a/1190000022495736

#### 原理：回调didChangeMetrics可以监听界面高度的变化，通过监听键盘的弹出和收起（都属于高度的变化）



#### 要点：WidgetsBindingObserver & didChangeMetrics



```dart
class _InputState extends State<Input> with WidgetsBindingObserver {
  // 输入框的焦点实例
  FocusNode _focusNode;
  // 当前键盘是否是激活状态
  bool isKeyboardActived = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
   // 监听输入框焦点变化
    _focusNode.addListener(_onFocus);
    // 创建一个界面变化的观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 当前是安卓系统并且在焦点聚焦的情况下
      if (Platform.isAndroid && _focusNode.hasFocus) {
        if (isKeyboardActived) {
          isKeyboardActived = false;
          // 使输入框失去焦点
          _focusNode.unfocus();
          return;
        }
        isKeyboardActived = true;
      }
    });
  }

  // 既然有监听当然也要有卸载，防止内存泄漏嘛
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // 焦点变化时触发的函数
  _onFocus() {
    if (_focusNode.hasFocus) {
      // 聚焦时候的操作
      return;
    }
    
    // 失去焦点时候的操作
    isKeyboardActived = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      textInputAction: TextInputAction.done,
    );
  }
}
```

### 2.点击空白收起键盘 （TextField失去焦点）

声明FocusNode：

```
final FocusNode focusNode = new FocusNode();
```

在body外层加GestureDetector()：

```
 GestureDetector(
  behavior: HitTestBehavior.translucent,
  onTap: () {
    //失去TextField焦点
    focusNode.unfocus();
  },
  child: _buildBody(),
),
```

在TextField()添加配置：

```
focusNode: focusNode,
```



### 3.Flutter使用 floatingActionButton和 Textfield时，输入时底部界面被收缩

https://stackoverflow.com/questions/60224672/flutter-floatingactionbutton-with-textfield-is-not-fully-above-keyboard-need-so

如图：

bug界面：

![aea8b0024d79f37e82628461c96c9c4](https://gitee.com/balabalaqwq/pics/raw/master/aea8b0024d79f37e82628461c96c9c4.jpg)

原界面：

![bf43c7a06444cf75c6a683889637ae0](https://gitee.com/balabalaqwq/pics/raw/master/bf43c7a06444cf75c6a683889637ae0.jpg)



#### 解决办法：

界面body使用 scroll view （可滚动布局）