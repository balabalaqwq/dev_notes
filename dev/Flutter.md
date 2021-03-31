# Flutter

>  参：
>
>  Flutter中文站：https://book.flutterchina.club/
>
>  恋猫de小郭 ：https://guoshuyu.cn/home/wx/ 

# 一、Dart和Flutter基础
## 1、 环境搭建
> Android studio File->Settings->Plugins: install Flutter + Dart   重启AS

> 如果你想在Windows系统自带命令行运行flutter命令:系统用户变量"Path"添加Flutter SDK 路径(flutter\bin)
>
> 解决创建Flutter缓慢问题（添加镜像）： 在系统环境变量中添加PUB_HOSTED_URL值为https://pub.flutter-io.cn和FLUTTER_STORAGE_BASE_URL值为https://storage.flutter-io.cn

> AS new Flutter Project->...

## 2、Dart

### 2.1、基本类型

> **强类型语言**，但可以用**`var`**声明变量   
> （运行期进行检查，自动推导出数据类型）

- number类型： **int** 和 **double**

- bool类型

- 自带getter和setter *  final和const只有getter

- 在使用动态类型时，需要注意不要把 **number** 类型当做 **String**类型 使用。

  ```dart
  int i = 0; 
  //下面这行报错
  print("aaaa" + i);
  //正确如下
  print("aaaa" + i.toString());
  ```

> switch支持String类型

### 2.2、变量

变量声明： 

var：`var`声明的变量一旦赋值后，变量的数据类型会确定，不可再赋值其他类型的数据。 

```Dart
var tag = 666 
// 下面代码在dart中会报错，因为变量tag的类型已经确定为numbe类型，
// 类型一旦确定后则不能再更改其类型。
tag = "hello world"
```

dynamic：`dynamic`与`var`一样都是关键词,声明的变量可以赋值任意对象，但声明的变量可以在后期改变赋值类型。

Object:  `Object` 是Dart所有对象的根基类，也就是说所有类型都是`Object`的子类(包括Function和Null)，所以任何类型的数据都可以赋值给`Object`声明的对象；而`dynamic`与`Object`相同之处在于,他们声明的变量都可以在后期改变赋值类型。

```dart
 dynamic t;
 Object x;
 t = "hi world";
 x = 'Hello Object';
 //下面代码没有问题
 t = 1000;
 x = 1000;
```

`dynamic`与`Object`不同的是,`dynamic`声明的对象编译器会提供所有可能的组合, 而`Object`声明的对象只能使用Object的属性与方法, 否则编译器会报错。

```dart
 dynamic a;
 Object b;
 main() {
     a = "";
     b = "";
     printLengths();
 }   

 printLengths() {
     // no warning
     print(a.length);
     // warning:
     // The getter 'length' is not defined for the class 'Object'
     print(b.length);
 }
```

- 常量： **`final`**（运行时确定值）和  **`const`**(编译时确定值)  **`static const`**（静态变量）

- 如果您从未打算更改一个变量，那么使用 `final` 或 `const`，不是`var`，也不是一个类型。 一个 `final` 变量只能被设置一次，两者区别在于：`const` 变量是一个编译时常量，`final`变量在第一次使用时被初始化。被`final`或者`const`修饰的变量，变量类型可以省略，如： 

  ```dart
  //可以省略String这个类型声明
  final str = "hi world";
  //final String str = "hi world"; 
  const str1 = "hi world";
  //const String str1 = "hi world";
  ```

  
### 2.3、方法（函数）

Dart是一种真正的`面向对象`的语言，所以即使是函数也是对象，并且有一个类型**`Function`**。这意味着函数可以赋值给变量或作为参数传递给其他函数，这是`函数式编程`的典型特征。



- Dart 不像 Java ，没有关键词 public 、private 等修饰符，`_`下划线直接代表 private ，但是有 `@protected` 注解。

- Dart函数声明如果没有显式声明返回值类型时会默认当做`dynamic`处理，注意，函数返回值没有类型推断：  

  ```dart
  typedef bool CALLBACK();
  
  //不指定返回类型，此时默认为dynamic，不是bool
  isNoble(int atomicNumber) {
    return _nobleGases[atomicNumber] != null;
  }
  
  void test(CALLBACK cb){
     print(cb()); 
  }
  
  //报错，isNoble不是bool类型
  test(isNoble);
  ```

- 对于只包含一个表达式的函数，可以使用简写语法

  ```dart
  bool isNoble (int atomicNumber)=> _nobleGases [ atomicNumber ] ！= null;
  ```

- 函数作为变量

  ```dart
  var say = (str){
    print(str);
  };
  say("hi world");
  ```

  

- 函数作为参数传递

  ```dart
  void execute(var callback) {
      callback();
  }
  execute(() => print("xxx"))
  ```

- 可选的位置参数

  包装一组函数参数，用[]标记为可选的位置参数，并放在参数列表的最后面：

  ```dart
  String say(String from, String msg, [String device]) {
    var result = '$from says $msg';
    if (device != null) {
      result = '$result with a $device';
    }
    return result;
  }
  ```

  下面是一个不带可选参数调用这个函数的例子：

  ```dart
  say('Bob', 'Howdy'); //结果是： Bob says Howdy
  ```

  下面是用第三个参数调用这个函数的例子：

  ```dart
  say('Bob', 'Howdy', 'smoke signal'); //结果是：Bob says Howdy with a smoke signal
  ```

- 可选的命名参数

  定义函数时，使用{param1, param2, …}，放在参数列表的最后面，用于指定命名参数。例如：

  ```dart
  //设置[bold]和[hidden]标志
  void enableFlags({bool bold, bool hidden}) {
      // ... 
  }
  ```

  调用函数时，可以使用指定命名参数。例如：`paramName: value`

  ```dart
  enableFlags(bold: true, hidden: false);
  ```

  可选命名参数在Flutter中使用非常多。

  > **注意，不能同时使用可选的位置参数和可选的命名参数**

- 操作符 **??** 和 **??=** :

> 例： 
>
> ```dart
> A ?? "999"; //表示如果A为空，返回999；  
> A ??= "999"; //表示如果A为空，给A赋值为999
> ```
>
> 
- Dart方法可以设置 *参数默认值* 和 *指定名称* 。

> 例：方法定义 ：  

```Dart
getDetail(Sting userName, reposName, {branch = "master"}){} 
```
>*可以不指定参数类型，branch默认为“master”*    方法调用：    

```Dart
getRepositoryDetailDao(“aaa", "bbbb", branch: "dev");
```

- Dart 中多构造函数，可以通过如下代码实现的。默认构造方法只能有一个，而通过Model.empty() 方法可以创建一个空参数的类，其实方法名称随你喜欢，而变量初始化值时，只需要通过 this.name 在构造方法中指定即可

  ```dart
  class ModelA {
    String name;
    String tag;
  
    //默认构造方法，赋值给name和tag
    ModelA(this.name, this.tag);
  
    //返回一个空的ModelA
    ModelA.empty();
  
    //返回一个设置了name的ModelA
    ModelA.forName(this.name);
  }
  ```

  

### 2.4、异步支持

Dart类库有非常多的返回`Future`或者`Stream`对象的函数。 这些函数被称为**异步函数**：它们只会在设置好一些耗时操作之后返回，比如像 IO操作。而不是等到这个操作完成。

`async`和`await`关键词支持了异步编程，允许您写出和同步代码很像的异步代码。

#### Future

与JavaScript中的`Promise`非常相似，表示一个异步操作的最终完成（或失败）及其结果值的表示。简单来说，它就是用于处理异步操作的，异步处理成功了就执行成功的操作，异步处理失败了就捕获错误或者停止后续操作。一个Future只会对应一个结果，要么成功，要么失败。

由于本身功能较多，这里我们只介绍其常用的API及特性。

还有，请记住，`Future` 的所有API的返回值仍然是一个`Future`对象，所以可以很方便的进行链式调用。

#### Future.then

为了方便示例，在本例中我们使用`Future.delayed` 创建了一个延时任务（实际场景会是一个真正的耗时任务，比如一次网络请求），即2秒后返回结果字符串"hi world!"，然后我们在`then`中接收异步结果并打印结果，代码如下：

```dart
Future.delayed(new Duration(seconds: 2),(){
   return "hi world!";
}).then((data){
   print(data);
});
```

#### Future.catchError

如果异步任务发生错误，我们可以在`catchError`中捕获错误，我们将上面示例改为：

```dart
Future.delayed(new Duration(seconds: 2),(){
   //return "hi world!";
   throw AssertionError("Error");  
}).then((data){
   //执行成功会走到这里  
   print("success");
}).catchError((e){
   //执行失败会走到这里  
   print(e);
});
```

在本示例中，我们在异步任务中抛出了一个异常，`then`的回调函数将不会被执行，取而代之的是 `catchError`回调函数将被调用；但是，并不是只有 `catchError`回调才能捕获错误，`then`方法还有一个可选参数`onError`，我们也可以它来捕获异常：

```dart
Future.delayed(new Duration(seconds: 2), () {
    //return "hi world!";
    throw AssertionError("Error");
}).then((data) {
    print("success");
}, onError: (e) {
    print(e);
});
```

#### Future.whenComplete

有些时候，我们会遇到无论异步任务执行成功或失败都需要做一些事的场景，比如在网络请求前弹出加载对话框，在请求结束后关闭对话框。这种场景，有两种方法，第一种是分别在`then`或`catch`中关闭一下对话框，第二种就是使用`Future`的`whenComplete`回调，我们将上面示例改一下：

```dart
Future.delayed(new Duration(seconds: 2),(){
   //return "hi world!";
   throw AssertionError("Error");
}).then((data){
   //执行成功会走到这里 
   print(data);
}).catchError((e){
   //执行失败会走到这里   
   print(e);
}).whenComplete((){
   //无论成功或失败都会走到这里
});
```

#### Future.wait

有些时候，我们需要等待多个异步任务都执行结束后才进行一些操作，比如我们有一个界面，需要先分别从两个网络接口获取数据，获取成功后，我们需要将两个接口数据进行特定的处理后再显示到UI界面上，应该怎么做？答案是`Future.wait`，它接受一个`Future`数组参数，只有数组中所有`Future`都执行成功后，才会触发`then`的成功回调，只要有一个`Future`执行失败，就会触发错误回调。下面，我们通过模拟`Future.delayed` 来模拟两个数据获取的异步任务，等两个异步任务都执行成功时，将两个异步任务的结果拼接打印出来，代码如下：

```dart
Future.wait([
  // 2秒后返回结果  
  Future.delayed(new Duration(seconds: 2), () {
    return "hello";
  }),
  // 4秒后返回结果  
  Future.delayed(new Duration(seconds: 4), () {
    return " world";
  })
]).then((results){
  print(results[0]+results[1]);
}).catchError((e){
  print(e);
});
```

执行上面代码，4秒后你会在控制台中看到“hello world”。

#### Async/await

Dart中的`async/await` 和JavaScript中的`async/await`功能和用法是一模一样的，如果你已经了解JavaScript中的`async/await`的用法，可以直接跳过本节。

##### 回调地狱(Callback Hell)

如果代码中有大量异步逻辑，并且出现大量异步任务依赖其它异步任务的结果时，必然会出现`Future.then`回调中套回调情况。举个例子，比如现在有个需求场景是用户先登录，登录成功后会获得用户ID，然后通过用户ID，再去请求用户个人信息，获取到用户个人信息后，为了使用方便，我们需要将其缓存在本地文件系统，代码如下：

```dart
//先分别定义各个异步任务
Future<String> login(String userName, String pwd){
    ...
    //用户登录
};
Future<String> getUserInfo(String id){
    ...
    //获取用户信息 
};
Future saveUserInfo(String userInfo){
    ...
    // 保存用户信息 
};
```

接下来，执行整个任务流：

```dart
login("alice","******").then((id){
 //登录成功后通过，id获取用户信息    
 getUserInfo(id).then((userInfo){
    //获取用户信息后保存 
    saveUserInfo(userInfo).then((){
       //保存用户信息，接下来执行其它操作
        ...
    });
  });
})
```

可以感受一下，如果业务逻辑中有大量异步依赖的情况，将会出现上面这种在回调里面套回调的情况，过多的嵌套会导致的代码可读性下降以及出错率提高，并且非常难维护，这个问题被形象的称为**回调地狱（Callback Hell）**。回调地狱问题在之前JavaScript中非常突出，也是JavaScript被吐槽最多的点，但随着ECMAScript6和ECMAScript7标准发布后，这个问题得到了非常好的解决，而解决回调地狱的两大神器正是ECMAScript6引入了`Promise`，以及ECMAScript7中引入的`async/await`。 而在Dart中几乎是完全平移了JavaScript中的这两者：`Future`相当于`Promise`，而`async/await`连名字都没改。接下来我们看看通过`Future`和`async/await`如何消除上面示例中的嵌套问题。

###### 使用Future消除Callback Hell

```dart
login("alice","******").then((id){
      return getUserInfo(id);
}).then((userInfo){
    return saveUserInfo(userInfo);
}).then((e){
   //执行接下来的操作 
}).catchError((e){
  //错误处理  
  print(e);
});
```

正如上文所述， *“`Future` 的所有API的返回值仍然是一个`Future`对象，所以可以很方便的进行链式调用”* ，如果在then中返回的是一个`Future`的话，该`future`会执行，执行结束后会触发后面的`then`回调，这样依次向下，就避免了层层嵌套。

###### 使用async/await消除callback hell

通过`Future`回调中再返回`Future`的方式虽然能避免层层嵌套，但是还是有一层回调，有没有一种方式能够让我们可以像写同步代码那样来执行异步任务而不使用回调的方式？答案是肯定的，这就要使用`async/await`了，下面我们先直接看代码，然后再解释，代码如下：

```dart
task() async {
   try{
    String id = await login("alice","******");
    String userInfo = await getUserInfo(id);
    await saveUserInfo(userInfo);
    //执行接下来的操作   
   } catch(e){
    //错误处理   
    print(e);   
   }  
}
```

- `async`用来表示函数是异步的，定义的函数会返回一个`Future`对象，可以使用then方法添加回调函数。
- `await` 后面是一个`Future`，表示等待该异步任务完成，异步完成后才会往下走；**`await`必须出现在 `async` 函数内部。**

可以看到，我们通过`async/await`将一个异步流用同步的代码表示出来了。

> 其实，无论是在JavaScript还是Dart中，`async/await`都只是一个语法糖，编译器或解释器最终都会将其转化为一个Promise（Future）的调用链。

#### Stream

`Stream` 也是用于接收异步事件数据，和`Future` 不同的是，它可以接收多个异步操作的结果（成功或失败）。 也就是说，在执行异步任务时，可以通过多次触发成功或失败事件来传递结果数据或错误异常。 `Stream` 常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。举个例子：

```dart
Stream.fromFutures([
  // 1秒后返回结果
  Future.delayed(new Duration(seconds: 1), () {
    return "hello 1";
  }),
  // 抛出一个异常
  Future.delayed(new Duration(seconds: 2),(){
    throw AssertionError("Error");
  }),
  // 3秒后返回结果
  Future.delayed(new Duration(seconds: 3), () {
    return "hello 3";
  })
]).listen((data){
   print(data);
}, onError: (e){
   print(e.message);
},onDone: (){

});
```

上面的代码依次会输出：

```
I/flutter (17666): hello 1
I/flutter (17666): Error
I/flutter (17666): hello 3
```

代码很简单，就不赘述了。

> 思考题：既然Stream可以接收多次事件，那能不能用Stream来实现一个订阅者模式的事件总线？

## 3、Flutter 

### 3.1、Flutter简介

Flutter 是 Google推出并开源的移动应用开发框架，主打跨平台、高保真、高性能。开发者可以通过 Dart语言开发 App，一套代码同时运行在 iOS 和 Android平台。 Flutter提供了丰富的组件、接口，开发者可以很快地为 Flutter添加 native扩展。同时 Flutter还使用 Native引擎渲染视图，这无疑能为用户提供良好的体验。

#### 跨平台自绘引擎

Flutter与用于构建移动应用程序的其它大多数框架不同, Flutter既不使用WebView，也不使用操作系统的原生控件。 相反，Flutter使用自己的高性能渲染引擎来绘制widget。这样不仅可以保证在Android和iOS上UI的一致性，而且也可以避免对原生控件依赖而带来的限制及高昂的维护成本。

Flutter使用Skia作为其2D渲染引擎，Skia是Google的一个2D图形处理函数库，包含字型、坐标转换，以及点阵图都有高效能且简洁的表现，Skia是跨平台的，并提供了非常友好的API，目前Google Chrome浏览器和Android均采用Skia作为其绘图引擎。

目前Flutter默认支持iOS、Android、Fuchsia（Google新的自研操作系统）三个移动平台。但Flutter亦可支持Web开发（Flutter for web）和PC开发。

#### 高性能

Flutter高性能主要靠两点来保证，首先，Flutter APP采用Dart语言开发。Dart在 JIT（即时编译）模式下，速度与 JavaScript基本持平。但是 Dart支持 AOT，当以 AOT模式运行时，JavaScript便远远追不上了。速度的提升对高帧率下的视图数据计算很有帮助。其次，Flutter使用自己的渲染引擎来绘制UI，布局数据等由Dart语言直接控制，所以在布局过程中不需要像RN那样要在JavaScript和Native之间通信，这在一些滑动和拖动的场景下具有明显优势，因为在滑动和拖动过程往往都会引起布局发生变化，所以JavaScript需要和Native之间不停的同步布局信息，这和在浏览器中要JavaScript频繁操作DOM所带来的问题是相同的，都会带来比较可观的性能开销。

#### 采用Dart语言开发

这是一个很有意思，但也很有争议的问题，在了解Flutter为什么选择了 Dart而不是 JavaScript之前我们先来介绍两个概念：JIT和AOT。

目前，程序主要有两种运行方式：静态编译与动态解释。静态编译的程序在执行前全部被翻译为机器码，通常将这种类型称为**AOT** （Ahead of time）即 “提前编译”；而解释执行的则是一句一句边翻译边运行，通常将这种类型称为**JIT**（Just-in-time）即“即时编译”。AOT程序的典型代表是用C/C++开发的应用，它们必须在执行前编译成机器码，而JIT的代表则非常多，如JavaScript、python等，事实上，所有脚本语言都支持JIT模式。但需要注意的是JIT和AOT指的是程序运行方式，和编程语言并非强关联的，有些语言既可以以JIT方式运行也可以以AOT方式运行，如Java、Python，它们可以在第一次执行时编译成中间字节码、然后在之后执行时可以直接执行字节码，也许有人会说，中间字节码并非机器码，在程序执行时仍然需要动态将字节码转为机器码，是的，这没有错，不过通常我们区分是否为AOT的标准就是看代码在执行之前是否需要编译，只要需要编译，无论其编译产物是字节码还是机器码，都属于AOT。在此，读者不必纠结于概念，概念就是为了传达精神而发明的，只要读者能够理解其原理即可，得其神忘其形。

现在我们看看Flutter为什么选择Dart语言？笔者根据官方解释以及自己对Flutter的理解总结了以下几条（由于其它跨平台框架都将JavaScript作为其开发语言，所以主要将Dart和JavaScript做一个对比）：

1. **开发效率高**

   Dart运行时和编译器支持Flutter的两个关键特性的组合：

   **`基于JIT的快速开发周期`**：Flutter在开发阶段采用，采用JIT模式，这样就避免了每次改动都要进行编译，极大的节省了开发时间；

   **`基于AOT的发布包`**: Flutter在发布时可以通过AOT生成高效的ARM代码以保证应用性能。而JavaScript则不具有这个能力。

2. **高性能**

   Flutter旨在提供流畅、高保真的的UI体验。为了实现这一点，Flutter中需要能够在每个动画帧中运行大量的代码。这意味着需要一种既能提供高性能的语言，而不会出现会丢帧的周期性暂停，而Dart支持AOT，在这一点上可以做的比JavaScript更好。

3. **快速内存分配**

   Flutter框架使用函数式流，这使得它在很大程度上依赖于底层的内存分配器。因此，拥有一个能够有效地处理琐碎任务的内存分配器将显得十分重要，在缺乏此功能的语言中，Flutter将无法有效地工作。当然Chrome V8的JavaScript引擎在内存分配上也已经做的很好，事实上Dart开发团队的很多成员都是来自Chrome团队的，所以在内存分配上Dart并不能作为超越JavaScript的优势，而对于Flutter来说，它需要这样的特性，而Dart也正好满足而已。

4. **类型安全**

   由于Dart是类型安全的语言，支持静态类型检测，所以可以在编译前发现一些类型的错误，并排除潜在问题，这一点对于前端开发者来说可能会更具有吸引力。与之不同的，JavaScript是一个弱类型语言，也因此前端社区出现了很多给JavaScript代码添加静态类型检测的扩展语言和工具，如：微软的TypeScript以及Facebook的Flow。相比之下，Dart本身就支持静态类型，这是它的一个重要优势。

5. **Dart团队就在你身边**

   看似不起眼，实则举足轻重。由于有Dart团队的积极投入，Flutter团队可以获得更多、更方便的支持，正如Flutter官网所述“我们正与Dart社区进行密切合作，以改进Dart在Flutter中的使用。例如，当我们最初采用Dart时，该语言并没有提供生成原生二进制文件的工具链（这对于实现可预测的高性能具有很大的帮助），但是现在它实现了，因为Dart团队专门为Flutter构建了它。同样，Dart VM之前已经针对吞吐量进行了优化，但团队现在正在优化VM的延迟时间，这对于Flutter的工作负载更为重要。”

#### Flutter框架结构

本节我们先对Flutter的框架做一个整体介绍，旨在让读者心中有一个整体的印象，这对初学者来说非常重要。如果一下子便深入到Flutter中，就会像是一个在沙漠中没有地图的人，即使可以找到一个绿洲，但是他也不会知道下一个绿洲在哪。因此，无论学什么技术，都要先有一张清晰的“地图”，而我们的学习过程就是“按图索骥”，这样我们才不会陷于细节而“目无全牛”。言归正传，我们看一下Flutter官方提供的Flutter框架图，如图1-1所示：

![图1-1](https://pcdn.flutterchina.club/imgs/1-1.png)

#### Flutter Framework

这是一个纯 Dart实现的 SDK，它实现了一套基础库，自底向上，我们来简单介绍一下：

- 底下两层（Foundation和Animation、Painting、Gestures）在Google的一些视频中被合并为一个dart UI层，对应的是Flutter中的`dart:ui`包，它是Flutter引擎暴露的底层UI库，提供动画、手势及绘制能力。
- Rendering层，这一层是一个抽象的布局层，它依赖于dart UI层，Rendering层会构建一个UI树，当UI树有变化时，会计算出有变化的部分，然后更新UI树，最终将UI树绘制到屏幕上，这个过程类似于React中的虚拟DOM。Rendering层可以说是Flutter UI框架最核心的部分，它除了确定每个UI元素的位置、大小之外还要进行坐标变换、绘制(调用底层dart:ui)。
- Widgets层是Flutter提供的的一套基础组件库，在基础组件库之上，Flutter还提供了 Material 和Cupertino两种视觉风格的组件库。而**我们Flutter开发的大多数场景，只是和这两层打交道**。

#### Flutter Engine

这是一个纯 C++实现的 SDK，其中包括了 Skia引擎、Dart运行时、文字排版引擎等。在代码调用 `dart:ui`库时，调用最终会走到Engine层，然后实现真正的绘制逻辑。

#### Flutter框架本身有着良好的分层设计

### 3.2、Flutter Widget

Flutter 中一切皆 **`Widget`** 呈现，通过 `build`方法返回 Widget。

#### 3.2.1 Widget 与 Element

在Flutter中，Widget的功能是“描述一个UI元素的配置数据”，实际上，Flutter中真正代表屏幕上显示元素的类是`Element`，也就是说Widget只是描述Element的配置数据！

>   **Widget只是UI元素的一个配置数据，并且一个Widget可以对应多个`Element`。**

这是因为同一个Widget对象可以被添加到UI树的不同部分，而真正渲染时，UI树的每一个`Element`节点都会对应一个Widget对象。总结一下：

- **Widget实际上就是Element的配置数据，Widget树实际上是一个配置树，而真正的UI渲染树是由Element构成；不过，由于Element是通过Widget生成的，所以它们之间有对应关系，在大多数场景，我们可以宽泛地认为Widget树就是指UI控件树或UI渲染树。**
- **一个Widget对象可以对应多个Element对象。这很好理解，根据同一份配置（Widget），可以创建多个实例（Element）。**

#### 3.2.2 Widget简介

在 Flutter 中几乎所有的对象都是一个 Widget ，Widget 是一切的基础，利用响应式模式进行渲染。与原生开发中“控件”不同的是，Flutter中的Widget的概念更广泛， *它不仅可以表示UI元素，也可以表示一些功能性的组件*   如：用于手势检测的 `GestureDetector` widget、用于APP主题数据传递的`Theme`等等，而原生开发中的控件通常只是指UI元素。

我们可以通过修改数据，再用setState 设置数据，Flutter 会自动通过绑定的数据更新 Widget ， 所以你需要做的就是实现 Widget 界面，并且和数据绑定起来。

`Widget`类本身是一个抽象类，其中最核心的就是定义了`createElement()`接口。

在Flutter开发中，我们一般都不用直接继承`Widget`类来实现一个新组件，通常会通过继承`StatelessWidget`或`StatefulWidget`来间接继承`Widget`类来实现。

Widget 分为 有状态 和 无状态 两种，在 Flutter 中每个页面都是一帧，无状态就是保持在那一帧，而有状态的 Widget 当数据更新时，其实是创建了新的 Widget，只是 State 实现了跨帧的数据同步保存。

* Widget 和 Widget 之间通过 child: 进行嵌套。其中有的 Widget 只能有一个 child；有的 Widget 可以多个 child ，也就是children。

>这里有个小 Tip ，当代码框里输入 stl 的时候，可以自动弹出创建无状态控件的模板选项，而输入 stf 的时，就会弹出创建有状态 Widget 的模板选项。  
>代码格式化的时候，括号内外的逗号都会影响格式化时换行的位置。  
>如果觉得默认换行的线太短，可以在设置-Editor-Code Style-Dart-Wrapping and Braces-Hard wrap at 设置你接受的数值。

##### 无状态StatelessWidget

继承自`Widget`类，重写了`createElement()`方法：

```dart
@override
StatelessElement createElement() => new StatelessElement(this);
```

* `StatelessElement` 间接继承自`Element`类，与`StatelessWidget`相对应（作为其配置数据）。

可以通过继承 StatelessWidget，使用 build 方法返回一个布局好的控件

##### 有状态StatefulWidge

`StatefulWidget`也是继承自`Widget`类，并重写了`createElement()`方法，不同的是返回的`Element` 对象不同；另外`StatefulWidget`类中添加了一个新的接口`createState()`。

* `StatefulElement` 间接继承自`Element`类，与StatefulWidget相对应（作为其配置数据）。`StatefulElement`中可能会多次调用`createState()`来创建状态(State)对象。
* `createState()` 用于创建和Stateful widget相关的状态，它在Stateful widget的生命周期中可能会被多次调用。例如，当一个Stateful widget同时插入到widget树的多个位置时，Flutter framework就会调用该方法为每一个位置生成一个独立的State实例，其实，本质上就是一个`StatefulElement`对应一个State实例。

你需要创建管理的是主要是 State ， 通过 State 的 build 方法去构建控件。在 State 中，你可以动态改变数据，在 setState 之后，改变的数据会触发 Widget 重新构建刷新。

> 你需要的就是在 build 中堆积你的布局，然后把数据添加到 Widget 中，最后通过 setState 改变数据，从而实现画面变化。

#### 3.2.3 State

一个StatefulWidget类会对应一个State类，State表示与其对应的StatefulWidget要维护的状态，State中的保存的状态信息可以：

1. 在widget 构建时可以被同步读取。
2. 在widget生命周期中可以被改变，当State被改变时，可以手动调用其`setState()`方法通知Flutter framework状态发生改变，Flutter framework在收到消息后，会重新调用其`build`方法重新构建widget树，从而达到更新UI的目的。

State中有两个常用属性：

1. `widget`，它表示与该State实例关联的widget实例，由Flutter framework动态设置。注意，这种关联并非永久的，因为在应用生命周期中，UI树上的某一个节点的widget实例在重新构建时可能会变化，但State实例只会在第一次插入到树中时被创建，当在重新构建时，如果widget被修改了，Flutter framework会动态设置State.widget为新的widget实例。
2. `context`。StatefulWidget对应的BuildContext，作用同StatelessWidget的BuildContext。

下面我们来看看各个回调函数：

- `initState`：当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter framework只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。不能在该回调中调用`BuildContext.dependOnInheritedWidgetOfExactType`（该方法用于在Widget树上获取离当前widget最近的一个父级`InheritFromWidget`，原因是在初始化完成后，Widget树中的`InheritFromWidget`也可能会发生变化，所以正确的做法应该在在`build（）`方法或`didChangeDependencies()`中调用它。
- `didChangeDependencies()`：当State对象的依赖发生变化时会被调用；典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
- `build()`：它主要是用于构建Widget子树的，会在如下场景被调用：
  1. 在调用`initState()`之后。
  2. 在调用`didUpdateWidget()`之后。
  3. 在调用`setState()`之后。
  4. 在调用`didChangeDependencies()`之后。
  5. 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
- `reassemble()`：此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
- `didUpdateWidget()`：在widget重新构建时，Flutter framework会调用`Widget.canUpdate`来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，如果`Widget.canUpdate`返回`true`则会调用此回调。正如之前所述，`Widget.canUpdate`会在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时相等时`didUpdateWidget()`就会被调用。
- `deactivate()`：当State对象从树中被移除时，会调用此回调。在一些场景下，Flutter framework会将State对象重新插到树中，如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。如果移除后没有重新插入到树中则紧接着会调用`dispose()`方法。
- `dispose()`：当State对象从树中被永久移除时调用；通常在此回调中释放资源。

StatefulWidget生命周期如图所示：

![图3-2](https://pcdn.flutterchina.club/imgs/3-2.jpg)

> **注意**：在继承`StatefulWidget`重写其方法时，对于包含`@mustCallSuper`标注的父类方法，都要在子类方法中先调用父类方法。

> State中主要的声明周期：
>
> - **initState** ：初始化。对于每个State对象只会调用一次
> - **didChangeDependencies** : 在initState之后调用，此时可获取其它State。
> - **dispose** ： 销毁，只会调用一次。

##### 在Widget树中获取State对象

###### 通过Context获取

`context`对象有一个`findAncestorStateOfType()`方法，该方法可以从当前节点沿着widget树向上查找指定类型的StatefulWidget对应的State对象。

###### 通过GlobalKey

Flutter还有一种通用的获取`State`对象的方法——通过GlobalKey来获取！ 步骤分两步：

1. 给目标`StatefulWidget`添加`GlobalKey`。
2. 通过`GlobalKey`来获取`State`对象

GlobalKey是Flutter提供的一种在整个APP中引用element的机制。如果一个widget设置了`GlobalKey`，那么我们便可以通过`globalKey.currentWidget`获得该widget对象、`globalKey.currentElement`来获得widget对应的element对象，如果当前widget是`StatefulWidget`，则可以通过`globalKey.currentState`来获得该widget对应的state对象。

>  注意：使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。

#### 3.2.4 Context

`build`方法有一个`context`参数，它是`BuildContext`类的一个实例，表示当前widget在widget树中的上下文，每一个widget都会对应一个context对象（因为每一个widget都是widget树上的一个节点）。实际上，`context`是当前widget在widget树中位置中执行”相关操作“的一个句柄，比如它提供了从当前widget开始向上遍历widget树以及按照widget类型查找父级widget的方法。



### 3.3 、 状态管理

#### 管理状态的最常见的方法：

- Widget管理自己的状态。
- Widget管理子Widget状态。
- 混合管理（父Widget和子Widget都管理状态）。

官方给出的一些原则：

- 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父Widget管理。
- 如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由Widget本身来管理。
- 如果某一个状态是不同Widget共享的则最好由它们共同的父Widget管理。

在Widget内部管理状态封装性会好一些，而在父Widget中管理会比较灵活。有些时候，如果不确定到底该怎么管理状态，那么推荐的首选是在父widget中管理（灵活会显得更重要一些）。

#### 全局状态管理

当应用中需要一些跨组件（包括跨路由）的状态需要同步时，上面介绍的方法便很难胜任了。比如，我们有一个设置页，里面可以设置应用的语言，我们为了让设置实时生效，我们期望在语言状态发生改变时，APP中依赖应用语言的组件能够重新build一下，但这些依赖应用语言的组件和设置页并不在一起，所以这种情况用上面的方法很难管理。这时，正确的做法是通过一个全局状态管理器来处理这种相距较远的组件之间的通信。目前主要有两种办法：

1. 实现一个全局的事件总线，将语言状态改变对应为一个事件，然后在APP中依赖应用语言的组件的`initState` 方法中订阅语言改变的事件。当用户在设置页切换语言后，我们发布语言改变事件，而订阅了此事件的组件就会收到通知，收到通知后调用`setState(...)`方法重新`build`一下自身即可。
2. 使用一些专门用于状态管理的包，如Provider、Redux，

### 3.4、 Flutter布局

在Flutter中，根据Widget是否需要包含子节点将Widget分为了三类，分别对应三种Element，如下表：

| Widget                        | 对应的Element                  | 用途                                                         |
| :---------------------------- | :----------------------------- | ------------------------------------------------------------ |
| LeafRenderObjectWidget        | LeafRenderObjectElement        | Widget树的叶子节点，用于没有子节点的widget，通常基础组件都属于这一类，如Image。 |
| SingleChildRenderObjectWidget | SingleChildRenderObjectElement | 包含一个子Widget，如：ConstrainedBox、DecoratedBox等         |
| MultiChildRenderObjectWidget  | MultiChildRenderObjectElement  | 包含多个子Widget，一般都有一个children参数，接受一个Widget数组。如Row、Column、Stack等 |

> 注意，Flutter中的很多Widget是直接继承自StatelessWidget或StatefulWidget，然后在`build()`方法中构建真正的RenderObjectWidget，如Text，它其实是继承自StatelessWidget，然后在`build()`方法中通过RichText来构建其子树，而RichText才是继承自MultiChildRenderObjectWidget。所以为了方便叙述，我们也可以直接说Text属于MultiChildRenderObjectWidget（其它widget也可以这么描述），这才是本质。读到这里我们也会发现，其实**StatelessWidget和StatefulWidget就是两个用于组合Widget的基类，它们本身并不关联最终的渲染对象（RenderObjectWidget）**。

布局类组件就是指直接或间接继承(包含)`MultiChildRenderObjectWidget`的Widget，它们一般都会有一个`children`属性用于接收子Widget。继承关系 Widget > RenderObjectWidget > (Leaf/SingleChild/MultiChild)RenderObjectWidget 。

`RenderObjectWidget`类中定义了创建、更新`RenderObject`的方法，子类必须实现他们。

Flutter 中拥有需要将近30种内置的 布局Widget，其中常用有 Container、Padding、Center、Flex、Stack、Row、Column、ListView 等。

常见组件：

| 类型                             | 组件名称              | 作用特点                                                     |
| -------------------------------- | --------------------- | ------------------------------------------------------------ |
| 容器类                           | Container             | 只有一个子 Widget。默认充满，包含了padding、margin、color、宽高、decoration 等配置。 |
|                                  | Padding               | 只有一个子 Widget。只用于设置Padding，常用于嵌套child，给child设置padding。 |
| /                                | Center                | 只有一个子 Widget。只用于居中显示，常用于嵌套child，给child设置居中。 |
| 层叠布局                         | Stack                 | 可以有多个子 Widget。 允许子Widget堆叠在一起。               |
|                                  | Positioned            | 可以有多个子 Widget。根据父布局四角来确定子组件位置。        |
| 线性布局                         | Column                | 可以有多个子 Widget。垂直布局。                              |
|                                  | Row                   | 可以有多个子 Widget。水平布局。                              |
| 流式布局                         | Wrap                  | 可以有多个子 Widget。                                        |
|                                  | Flow                  | 可以有多个子 Widget。(不常用，复杂，可以自定义布局策略。)    |
| 弹性布局                         | Flex                  | 可以有多个子 Widget。Column和Row的父类，可以配合Expanded来实现弹性布局。 |
|                                  | Expanded              | 只有一个子 Widget。在 Column 和 Row 中充满。可以按比例“扩伸” `Row`、`Column`和`Flex`子组件所占用的空间。 |
| 可滚动                           | Scrollbar             | Material风格滚动条，只用将Scrollbar作为可滚动组件的父级。    |
| 支持Sliver延迟构建               | ListView              | 可以有多个子 Widget。                                        |
|                                  | GridView              | 可以有多个子Widget。                                         |
|                                  | CustomScrollView      | 可以包含多个滚动模型。                                       |
| 不支持基于Sliver的延迟实例化模型 | SingleChildScrollView | 只有一个子 Widget。期望内容不多时使用，过多导致性能差        |

![](https://gitee.com/balabalaqwq/pics/raw/master/widget%E5%9B%BE%E9%89%B4_1.png)

![widget图鉴_2](https://gitee.com/balabalaqwq/pics/raw/master/widget%E5%9B%BE%E9%89%B4_2%20(Large).png)

### 3.4、Flutter页面

Flutter 中除了布局的 Widget，还有交互显示的 Widget 和完整页面呈现的Widget，其中常见的有 MaterialApp、Scaffold、Appbar、Text、Image、FlatButton等。

| 类型        | 作用特点                                                     |
| ----------- | ------------------------------------------------------------ |
| MaterialApp | 一般作为APP顶层的主页入口，可配置主题，多语言，路由等        |
| Scaffold    | 一般用户页面的承载Widget，包含appbar、snackbar、drawer等material design的设定。 |
| Appbar      | 一般用于Scaffold的appbar ，内有标题，二级页面返回按键等，当然不止这些，tabbar等也会需要它 。 |
| Text        | 显示文本，几乎都会用到，主要是通过style设置TextStyle来设置字体样式等。 |
| RichText    | 富文本，通过设置TextSpan，可以拼接出富文本场景。             |
| TextField   | 文本输入框 ：new TextField(controller: //文本控制器, obscureText: "hint文本"); |
| Image       | 图片加载: new FadeInImage.assetNetwork( placeholder: "预览图", fit: BoxFit.fitWidth, image: "url"); |
| FlatButton  | 按键点击: new FlatButton(onPressed: () {},child: new Container()); |

 ...

 