# Memory Analyzer（MAT）打开android .hprof 文件

## 安装MAT 

 引 https://www.cnblogs.com/qingqing-919/p/9072930.html

​	打开提示jdk报错 

打开MemoryAnalyzer根目录D:\Android\tools\MemoryAnalyzer-1.10.0.20200225-win32.win32.x86_64\mat\MemoryAnalyzer.ini文件，在最前面加上两行：

> -vm
> C:\Java\jdk-13.0.2_windows-x64_bin\jdk-13.0.2\bin\javaw.exe
>
> （这个是你安装的javaw.exe的绝对路径）

## 转换hprof文件

引 https://blog.csdn.net/u010695063/article/details/86467820

先使用Android sdk tools 中的hprof-conv.exe 把Android Studio产出的.hprof文件转换成MAT可以打开的.hprof文件（因为虚拟机不同 直接打开报错），然后就可以用MAT分析了 



​    D:\Android\Androidsdk\platform-tools  目录下打开powershell 输入

>  hprof-conv 待转换全路径\Android（hprof文件名）.hprof mat（转换后的mat hprof文件名）.hprof