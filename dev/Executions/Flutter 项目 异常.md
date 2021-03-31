

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

