

## 1.处理Android Studio 编译报错：compileDebugJavaWithJavac问题

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



## 2.git update保存  Error merging

使用Android Studio Git工具更新工程报错：

```
Error merging
			Unable to create 'D:/workspace/vma/super_sale/.git/index.lock': File exists.
			If no other git process is currently running, this probably means a git process crashed in this repository earlier. Make sure no other git process is running and remove the file manually to continue.
```

解决：

打开报错工程下.git路径 删除index.lock文件

## 3.build.gradle阿里云镜像

```
buildscript {
    repositories {
        // 添加阿里云 maven 地址
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        maven { url 'http://maven.aliyun.com/nexus/content/repositories/jcenter' }
        google()
//        jcenter()
    }
    ...
}

allprojects {
    repositories {
        // 添加阿里云 maven 地址
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        maven { url 'http://maven.aliyun.com/nexus/content/repositories/jcenter' }
        google()
//        jcenter()
    }
}
...
```

