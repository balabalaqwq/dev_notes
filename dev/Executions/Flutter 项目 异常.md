

# Flutter 项目 异常

## 1.运行异常Execution failed for task ':app:compileFlutterBuildDebug'.

### 报错信息：

```
FAILURE: Build failed with an exception.

* Where:
  Script 'D:\Flutter\flutter\packages\flutter_tools\gradle\flutter.gradle' line: 908

* What went wrong:
  Execution failed for task ':app:compileFlutterBuildDebug'.

> Process 'command 'D:\Flutter\flutter\bin\flutter.bat'' finished with non-zero exit value 1

* Try:
  Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 28s
Exception: Gradle task assembleDebug failed with exit code 1
```

### 造成原因：

flutter本地引入库文件更新后未重新构建

### 解决方法：

1.地址https://github.com/RichsJeson/fengwuxp_dart_basic

库路径下运行依次以下两个命令

```
flutter packages pub run build_runner watch
flutter packages pub run build_runner build test --delete-conflicting-outputs
```

2.打开库pubspec.yaml文件

进行`pub get`

3.打开项目pubspec.yaml文件

进行`pub get`

4.运行项目

## 2.运行异常Execution failed for task ':app:mergeDebugNativeLibs'

- ### 报错信息：

  ```
  FAILURE: Build failed with an exception.
  
  * Where:
   A failure occurred while executing com.android.build.gradle.internal.tasks.Workers$ActionFacade File 'com.android.builder.files.ZipCentralDirectory@48b70346' was deleted, but previous version not found in cache
  ```

  ### 造成原因：

  flutter插件版本问题

  ### 解决方法：

  地址https://stackoverflow.com/questions/62760392/flutter-failed-for-task-appmergedebugnativelibs-and-appmergedebugjavaresource/65278248#65278248

  1. Close your project and close your code editor
  2. Open Task Manager
  3. Finish all vscode-related tasks you see (or related to the IDE you are using)
  4. Finish all Java-related tasks, inclidung **OpenJDK Platform binary** (there are usually two of these; finish both)
  5. Go to your project's root folder and delete the **build** folder
  6. Open your project again and run

## 3.运行异常Execution failed for task ':app:processDebugResources'.

- ### 报错信息：

  ```
  FAILURE: Build failed with an exception.
  
  * What went wrong:
  Execution failed for task ':app:processDebugResources'.
  > A failure occurred while executing com.android.build.gradle.internal.tasks.Workers$ActionFacade
     > Android resource linking failed
       D:\workspace\vma\super_sale\build\file_picker\intermediates\library_manifest\debug\AndroidManifest.xml:9:5-15:15: AAPT: error: unexpected element <queries> found in <manifest>.
       
       
  * Try:
  Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.
  
  * Get more help at https://help.gradle.org
  
  BUILD FAILED in 1m 16s
  The built failed likely due to AndroidX incompatibilities in a plugin. The tool is about to try using Jetfier to solve the incompatibility.
  Building plugin amap_core_fluttify...
  Running Gradle task 'assembleAarRelease'...
  
  
  FAILURE: Build failed with an exception.
  
  * Where:
  Build file 'C:\Users\卐\AppData\Local\Pub\Cache\hosted\pub.flutter-io.cn\amap_core_fluttify-0.14.0\android\build.gradle' line: 32
  
  * What went wrong:
  A problem occurred evaluating root project 'amap_core_fluttify'.
  > Failed to apply plugin [id 'com.android.library']
     > Your project path contains non-ASCII characters. This will most likely cause the build to fail on Windows. Please move your project to a different directory. See http://b.android.com/95744 for details. This warning can be disabled by adding the line 'android.overridePathCheck=true' to gradle.properties file in the project directory.
  
  * Try:
  Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.
  
  * Get more help at https://help.gradle.org
  
  BUILD FAILED in 2s
  
  Exception: The plugin amap_core_fluttify could not be built due to the issue above.
  
  ```

  ### 造成原因：

  地址https://www.jianshu.com/p/632dfa9fbb57

  stackoverflow地址https://stackoverflow.com/questions/65126025/file-picker-unexpected-element-queries-found-in-manifest

  ### 解决方法：

  地址https://github.com/miguelpruivo/flutter_file_picker/wiki/Troubleshooting#-issue

  更改项目下-android->build.gradle 

  ```
  dependencies {
      classpath 'com.android.tools.build:gradle:3.5.4'
      //支持3.3.3、3.4.3、3.5.4、3.6.4、4.0.1
      ...
      }
  ```

## 4.运行异常Could not create service of type FileHasher using .createCachingFileHasher().

- ### 报错信息：

  ```
  FAILURE: Build failed with an exception.
  
  * What went wrong:
  Could not create service of type FileHasher using .createCachingFileHasher().
  > Timeout waiting to lock file hash cache (C:\Users\�e\.gradle\caches\6.1.1\fileHashes). It is currently in use by another Gradle instance.
    Owner PID: 3712
    Our PID: 5600
    Owner Operation: 
    Our operation: 
    Lock file: C:\Users\�e\.gradle\caches\6.1.1\fileHashes\fileHashes.lock
  
  * Try:
  Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.
  
  * Get more help at https://help.gradle.org
  
  BUILD FAILED in 1m 35s
  ```

  ### 造成原因：

  

  ### 解决方法：

  重启电脑。。

## 5.flutter运行闪退Could not update files on device: HttpException: Connection closed before full header was received, uri = http://127.0.0.1:27975/aUGLHym0g2Y=/



闪退时出现错误：

```
Lost connection to device.
Could not update files on device: HttpException: Connection closed before full header was received, uri = http://127.0.0.1:27975/aUGLHym0g2Y=/
```

可能原因：

1.遇到具体原因：

启动页图片太大（尺寸、大小），手机无法适应，应用出现闪退



## 6.Scaffold.of() called with a context that does not contain a Scaffold.

- 使用Scaffold的snackbar、BottomSheet等组件时找不到context.

- 例如：

- ```
  Scaffold.of(context).showBottomSheet((context) => _buildARCodeView(context));
  ```

  

- ### 报错信息：

  ```
  ======== Exception caught by gesture ===============================================================
  The following assertion was thrown while handling a gesture:
  Scaffold.of() called with a context that does not contain a Scaffold.
  
  No Scaffold ancestor could be found starting from the context that was passed to Scaffold.of(). This usually happens when the context provided is from the same StatefulWidget as that whose build function actually creates the Scaffold widget being sought.
  
  There are several ways to avoid this problem. The simplest is to use a Builder to get a context that is "under" the Scaffold. For an example of this, please see the documentation for Scaffold.of():
    https://api.flutter.dev/flutter/material/Scaffold/of.html
  A more efficient solution is to split your build function into several widgets. This introduces a new context from which you can obtain the Scaffold. In this solution, you would have an outer widget that creates the Scaffold populated by instances of your new inner widgets, and then in these inner widgets you would use Scaffold.of().
  A less elegant but more expedient solution is assign a GlobalKey to the Scaffold, then use the key.currentState property to obtain the ScaffoldState rather than using the Scaffold.of() function.
  
  The context used was: ShareEarnPage
    dependencies: [MediaQuery]
    state: _ShareEarnPageState#9b906
  When the exception was thrown, this was the stack: 
  #0      Scaffold.of (package:flutter/src/material/scaffold.dart:1472:5)
  #1      _ShareEarnPageState._click (package:vma_ky/Page/ShareEarnPage.dart:280:18)
  #2      _ShareEarnPageState._buildBtn.<anonymous closure> (package:vma_ky/Page/ShareEarnPage.dart:226:9)
  #3      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:183:24)
  #4      TapGestureRecognizer.handleTapUp (package:flutter/src/gestures/tap.dart:598:11)
  ...
  Handler: "onTap"
  Recognizer: TapGestureRecognizer#7c214
    debugOwner: GestureDetector
    state: ready
    won arena
    finalPosition: Offset(295.7, 695.0)
    finalLocalPosition: Offset(31.1, 33.2)
    button: 1
    sent tap down
  ====================================================================================================
  
  ```

  ### 造成原因：

  找不到context

  ### 解决方法：

  使用在Scaffold() 内部使用Builder（）构建内部嵌套

  如：

```
 @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
    ...
 body: Builder(
        builder: (BuildContext context) {
          return _buildBody(context);
        },
      ),
    );
  }
  _buildBody(BuildContext context) {
    return RaisedButton(
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('测试'),
                        ),
                      );
                    },
                  );
    }
```



## 7.打包编译异常

- ### 报错信息：

  ```
  FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':keyboard_visibility:verifyReleaseResources'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.Workers$ActionFacade
  > Android resource linking failed
     C:\Users\admin\.gradle\caches\transforms-2\files-2.1\799a4313fcc4980072ee2e97207b51c1\core-1.1.0\res\values\values.xml:142:5-173:25: AAPT: error: resource android:attr/fontVariationSettings not found.

     C:\Users\admin\.gradle\caches\transforms-2\files-2.1\799a4313fcc4980072ee2e97207b51c1\core-1.1.0\res\values\values.xml:142:5-173:25: AAPT: error: resource android:attr/ttcIndex not found.


* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 10m 26s
  ```

  ### 造成原因：
https://blog.csdn.net/spinchao/article/details/105660058

  ### 解决方法：
例如：extranal libaries -> flutter plugings 某个库的Android目录，然后是gradle文件，查看。这里 一个库是27，其他28.修改后问题及解决
参考 https://blog.csdn.net/spinchao/article/details/105660058


## 8.打包编译异常
 ```
  Execution failed for task ':app:transformClassesAndResourcesWithR8ForRelease'.
 ```

- ### 报错信息：

  ```
  Execution failed for task ':app:transformClassesAndResourcesWithR8ForRelease'.
  ```

  ### 造成原因：


  ### 解决方法：
在android下gradle.properties里边配置
  ```
   android.enableR8=false
  ```

## 8.打包编译异常

- ### 报错信息：

  ```
  FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':keyboard_visibility:verifyReleaseResources'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.Workers$ActionFacade
  > Android resource linking failed
     C:\Users\admin\.gradle\caches\transforms-2\files-2.1\799a4313fcc4980072ee2e97207b51c1\core-1.1.0\res\values\values.xml:142:5-173:25: AAPT: error: resource android:attr/fontVariationSettings not found.

     C:\Users\admin\.gradle\caches\transforms-2\files-2.1\799a4313fcc4980072ee2e97207b51c1\core-1.1.0\res\values\values.xml:142:5-173:25: AAPT: error: resource android:attr/ttcIndex not found.


* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 10m 26s
  ```

  ### 造成原因：
https://blog.csdn.net/spinchao/article/details/105660058

  ### 解决方法：
例如：extranal libaries -> flutter plugings 某个库的Android目录，然后是gradle文件，查看。这里 一个库是27，其他28.修改后问题及解决
参考 https://blog.csdn.net/spinchao/article/details/105660058


## 8.打包编译异常
 ```
  Execution failed for task ':app:transformClassesAndResourcesWithProguardForRelease'
 ```

- ### 报错信息：

  ```
  Warning: there were 1185 unresolved references to classes or interfaces.
          You may need to add missing library jars or update their versions.
          If your code works fine without the missing classes, you can suppress
          the warnings with '-dontwarn' options.

  Execution failed for task ':app:transformClassesAndResourcesWithProguardForRelease'
  ```

  ### 造成原因：
  AS混淆时出现的错误

  ### 解决方法：
  根据warning提示在android/app/proguard-rules.pro里配置
  例如：
  ```
    -dontwarn com.hyphenate.**
    -keep class com.hyphenate.** { *; }
    -dontwarn com.sun.jna.**
    -keep class com.sun.jna.** { *; }
    -dontwarn okhttp3.internal.**
    -keep class okhttp3.internal.** { *; }
    -dontwarn com.sangcomz.fishbun.adapter.image.impl.**
    -keep class com.sangcomz.fishbun.adapter.image.impl.** { *; }
    -dontwarn me.yohom.amap_location_fluttify.sub_handler.**
    -keep class me.yohom.amap_location_fluttify.sub_handler.** { *; }
 ```



