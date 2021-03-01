

## 处理Android Studio 编译报错：compileDebugJavaWithJavac问题

使用Android Studio 编译代码总是报错：Execution failed for task ‘:app:compileDebugJavaWithJavac’. 却又没有显示错误原因，找不到报错原因无从下手。

**可以在Terminal窗口输入命令**

```gradle
gradlew compileDebugJavaWithJavac
```

** 进行编译，编译完成后会显示出报错的详细信息。**





gradle.properties

```
org.gradle.jvmargs=-Xmx1536m -Dfile.encoding=UTF-8
```

