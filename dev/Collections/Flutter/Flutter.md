源：https://zhuoyuan.blog.csdn.net/article/details/106826648



## Widget

Widget是不可变的.
Widget 是 描述 Element的配置 , 告诉 Element 这个实例如何去渲染。
Widget 和 Element 之间是一对多的关系 .
每当Widget插入到树中,就会生成一个对应的Element.
Widget 可能被复用到树的多个部分，对应产生多个 Element 对象。

## RenderObject

RenderObject是渲染树中的对象,所以它才是实际的渲染对象
RenderObject 涉及到布局、计算、绘制等流程

## Element

在树中的特定位置实例化[Widget]。
Element 持有 RenderObject 和 Widget。
Element充当Widget和RenderObject的桥梁， State 就是保存在 Element 中。
Flutter 中的 BuildContext 只是接口，而 Element 实现了它。

配置文件 Widget 生成了 Element，而后创建 RenderObject 关联到 Element 的内部 renderObject 对象上，最后Flutter 通过 RenderObject
数据来布局和绘制。

Flutter 中默认主要通过 runtimeType 和 key 判断更新

在 newWidget 与oldWidget 的 runtimeType 和 key 相等时会选择使用 newWidget 去更新已经存在的 Element 对象，不然就选择重新创建新的 Element。

Widget 重新创建，Element 树和 RenderObject 树并不会完全重新创建

Flutter 中的 Dart 的线程是以事件循环和消息队列的形式存在，包含两个任务队列，一个是 microtask 内部队列，一个是 event 外部队列，而 microtask 的优先级又高于 event 。

因为 microtask 的优先级又高于 event， 同时会阻塞event 队列，所以如果 microtask 太多就可能会对触摸、绘制等外部事件造成阻塞卡顿哦。

Flutter 中存在四大线程，分别为 UI Runner、GPU Runner、IO Runner， Platform Runner（原生主线程） ，同时在 Flutter 中可以通过 isolate 或者 compute 执行真正的跨线程异步操作。

Flutter 的 Debug 下是 JIT 模式，release下是AOT模式。

Flutter 中可以通过 mixins AutomaticKeepAliveClientMixin ，然后重写 wantKeepAlive 保持住页面，记得在被保持住的页面 build 中调用 super.build 。（因为 mixins 特性）。

Platform Channel
Flutter 中可以通过 Platform Channel 让 Dart 代码和原生代码通信的：
BasicMessageChannel ：用于传递字符串和半结构化的信息。
MethodChannel ：用于传递方法调用（method invocation）。
EventChanne l: 用于数据流（event streams）的通信。

**问题 1 :setState是立即生效的吗?**
答: 不是.
Flutter 中 setState 其实是调用了 markNeedsBuild ，该方法内部标记此Element 为 Dirty ，然后在下一帧 WidgetsBinding.drawFrame 才会被绘制，这可以看出 setState 并不是立即生效的。

widget的root节点是 `renderView` .

```dart
  void attachRootWidget(Widget rootWidget) {
    _readyToProduceFrames = true;
    _renderViewElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: renderView,
      debugShortDescription: '[root]',
      child: rootWidget,
    ).attachToRenderTree(buildOwner, renderViewElement as RenderObjectToWidgetElement<RenderBox>);
  }
12345678
```

dart在基本数据类型是值传递,对象是 引用传递.

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200624210604532.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTEyNzI3OTU=,size_16,color_FFFFFF,t_70)
**问题 2 为什么Flutter可以媲美原生的性能?**

![image-20200627001149709](https://imgconvert.csdnimg.cn/aHR0cDovL3BpY3R1cmVzLXVweXVuLnRlc3QudXBjZG4ubmV0L2ltZy9pbWFnZS0yMDIwMDYyNzAwMTE0OTcwOS5wbmc?x-oss-process=image/format,png)

1.一般我们说的Flutter的性能可以媲美原生是图形渲染

一个Android原生App在绘图的时候首先是要调用Android框架的java代码, 然后再调用Skia(C/C++)绘图引擎的代码,最后生成CPU/GPU指令,在设备上完成绘图.

Flutter的App在绘图的时候首先调用Flutter框架的dart代码,然后直接调用Skia(C/C++)绘图引擎的代码,最后生成CPU/GPU指令,在设备上完成绘图.

可以看到Flutter的框架dart代码完全取代了Android框架的Java代码,所以当flutter框架dart代码的效率可以媲美原生Android框架java的时候,那么总体的flutter App的性能就可以媲美原生的App.

而其他框架,比如RN,首先会调用JS代码,然后再调用Android的代码…

这里比原生的App严格多出了一个步骤,所以它的性能肯定不及原生App.

2.在Android原生App或者其他的跨平台框架中,它们所使用的的Skia都是Android操作系统的一部分,只有当Android系统升级的时候,Skia才会升级.

在Flutter中,Skia是Flutter SDK的一部分,只要Flutter SDK升级, Skia就会升级.

所以当Skia有性能上的改进,那么Flutter App很快就会得到性能上的改进,而其他框架甚至原生Android应用要等到系统升级, 而老旧的Android设备可能这辈子都不会升级.

Flutter可以使用最新的Skia, 对于性能来说肯定是有非常大的帮助的.