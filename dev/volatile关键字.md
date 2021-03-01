# volatile关键字

> 引 郭霖 https://mp.weixin.qq.com/s/WtMeB-4sXOYQtvYKUx6c5Q

## CPU高速缓存和可见性问题

当一个程序运行的时候，数据是保存在内存当中的，但是执行程序这个工作却是由CPU完成的。那么当CPU正在执行着任务呢，突然需要用到某个数据，它就会从内存中去读取这个数据，得到了数据之后再继续向下执行任务。

CPU速度快，但还是要从内存去读取数据，而这个过程是非常缓慢的，所以就大大限制了CPU的发展。

为了解决这个问题，CPU厂商引入了高速缓存功能。内存里存储的数据，CPU高速缓存里也可以存一份，这样当频繁需要去访问某个数据时就不需要重复从内存中去获取了，CPU高速缓存里有，那么直接拿缓存中的数据即可，这样就可以大大提升CPU的工作效率。

而当程序要对某个数据进行修改时，也可以先修改高速缓存中的数据，因为这样会非常快，等运算结束之后，再将缓存中的数据写回到内存当中即可。

这种工作方式在单线程的场景下是没问题的，准确来讲，在单核多线程的场景下也是没问题的。但如果到了多核多线程的场景下，可能就会出现问题。


> 这就是多核多线程场景下遇到的可见性问题，因为当一个线程去修改某个变量的值时，该变量对于另外一个线程并不是立即可见的。

```java
public class Main {

    static boolean flag;

    public static void main(String... args) {
        new Thread1().start();
        new Thread2().start();
    }

    static class Thread1 extends Thread {
        @Override
        public void run() {
            while (true) {
                if (flag) {
                    flag = false;
                    System.out.println("Thread1 set flag to false");
                }
            }
        }
    }

    static class Thread2 extends Thread {
        @Override
        public void run() {
            while (true) {
                if (!flag) {
                    flag = true;
                    System.out.println("Thread2 set flag to true");
                }
            }
        }
    }

}
```
这段代码真的非常简单，我们开启了两个线程来对同一个变量flag进行修改。Thread1使用一个while(true)循环，发现flag是true时就把它改为false。Thread2也使用一个while(true)循环，发现flag是false时就把它改为true。

理论上来说，这两个线程同时运行，那么就应该一直交替打印，你改我的值，我再给你改回去。

实际上真的会是这样吗？我们来运行一下就知道了。

https://mmbiz.qpic.cn/mmbiz_gif/v1LbPPWiaSt5WA3enR2PicaRa0qiaFj3iaIll9tJAWe6VYBmBciat2GiaEic7ZN7GVeP1jW090FQBovGW84t6ZxzN62Iw/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1

可以看到，打印过程只持续了一小会就停止打印了，但是程序却没有结束，依然显示在运行中。

这怎么可能呢？理论上来说，flag要么为true，要么为false。true的时候Thread1应该打印，false的时候Thread2应该打印，两边都不打印是为什么呢？

我们用刚才所学的知识就可以解释这个原本解释不了的问题，因为Thread1和Thread2的CPU高速缓存中各有一份flag值，其中Thread1中缓存的flag值是false，Thread2中缓存的flag值是true，所以两边就都不会打印了。

这样我们就通过一个实际的例子演示了刚才所说的可见性问题。那么该如何解决呢？

答案很明显，volatile。

```java
public class Main {

    volatile static boolean flag;
    ...

}
```

https://mmbiz.qpic.cn/mmbiz_gif/v1LbPPWiaSt5WA3enR2PicaRa0qiaFj3iaIlFsnTwM9T7JMGBkBUYWNKTIFBTKBYOzbzxP6IHChOKPiafJS0vibL4m1g/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1


## 指令排重问题

```java
// 第一段代码
int a = 10;
int b = 5;
a = 20;
System.out.println(a + b);

// 第二段代码
int a = 10;
a = 20;
int b = 5;
System.out.println(a + b);
```

这两段代码没有任何区别，声明变量b和修改变量a之间的顺序是随意的，它们之间谁也不碍着谁。

也正是因为这个原因，CPU在执行代码时，其实并不一定会严格按照我们编写的顺序去执行，而是可能会考虑一些效率方面的原因，对那些先后顺序无关紧要的代码进行重新排序，这个操作就被称为指令重排。

这么看来，指令重排这个操作没毛病啊。确实，但只限在单线程环境下。

很多问题一旦进入了多线程环境，就会变得更加复杂，我们来看如下代码：

```java
public class Main {

    static boolean init;
    static String value;

    static class Thread1 extends Thread {
        @Override
        public void run() {
            value = "hello world";
            init = true;
        }
    }

    static class Thread2 extends Thread {
        @Override
        public void run() {
            while (!init) {
                // 等待初始化完成
            }
            value.toUpperCase();
        }
    }

}
```
这段代码的思路仍然很简单，Thread1用于对value数据进行初始化，初始化完成之后会将init设置成true。Thread2则会先通过while循环等待初始化完成，完成之后再对value数据进行操作。

那么这段代码可以正常工作吗？未必，因为根据刚才的指令重排理论，Thread1中value和init这两个变量之间是没有先后顺序的。如果CPU将这两条指令进行了重排，那么就可能出现初始化已完成，但是value还没有赋值的情况。这样Thread2的while循环就会跳出，然后在操作value的时候出现空指针异常。

所以说，指令重排功能一旦进入了多线程环境，也是可能会出现问题的。

而至于解决方案嘛，当然还是volatile了。

对某个变量声明了volatile关键字之后，同时也就意味着禁止对该变量进行指令重排。所以我们只需要这样修改代码就能够保证程序的安全性了。

```java
public class Main {

    volatile static boolean init;
    ...

}
```


## volatile在Android上的应用

这里我给大家举一个常见的示例吧，在Android上我们应该都编写过文件下载这个功能。在执行下载任务时，我们需要开启一个线程，然后从网络上读取流数据，并写入到本地，重复执行这个过程，直到所有数据都读取完毕。

那么这个过程我可以用如下简易代码进行表示：

```java
public class DownloadTask {

    public void download() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                while (true) {
                    byte[] bytes = readBytesFromNetwork(); // 从网络上读取数据
                    if (bytes.length == 0) {
                        break; // 下载完毕，跳出循环
                    }
                    writeBytesToDisk(bytes); // 将数据写入到本地
                }
            }
        }).start();
    }

}
```

到此为止没什么问题。

不过现在又来了一个新的需求，要求允许用户取消下载。我们都知道，Java的线程是不可以中断的，所以如果想要做取消下载的功能，一般都是通过标记位来实现的，代码如下所示：

```java
public class DownloadTask {

    boolean isCanceled = false;

    public void download() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                while (!isCanceled) {
                    byte[] bytes = readBytesFromNetwork();
                    if (bytes.length == 0) {
                        break;
                    }
                    writeBytesToDisk(bytes);
                }
            }
        }).start();
    }

    public void cancel() {
        isCanceled = true;
    }

}
```

这里我们增加了一个isCanceled变量和一个cancel()方法，调用cancel()方法时将isCanceled变量设置为true，表示下载已取消。

然后在download()方法当中，如果发现isCanceled变量为true，就跳出循环不再继续执行下载任务，这样也就实现了取消下载的功能。

这种写法能够正常工作吗？根据我的实际测试，确实基本上都是可以正常工作的。

但是这种写法真的安全吗？不，因为你会发现download()方法和cancel()方法是运行在两个线程当中的，因此cancel()方法对于isCanceled变量的修改，未必对download()方法就立即可见。

所以，存在着这样一种可能，就是我们明明已经将isCanceled变量设置成了true，但是download()方法所使用的CPU高速缓存中记录的isCanceled变量还是false，从而导致下载无法被取消的情况出现。

因此，最安全的写法就是对isCanceled变量声明volatile关键字：

```java
public class DownloadTask {

    volatile boolean isCanceled = false;
    ...

}
```
这样就可以保证你的取消下载功能始终是安全的了。