# RenderThread(非ui线程进行动画绘制)

> 引 https://mp.weixin.qq.com/s/mHqZYUOo-yrIgknFmOm0ag
> 原 https://www.jianshu.com/p/70789a2eb9de

## 什么是 RenderThread ?
> ==用于分担主线程绘制任务的渲染线程。==

在 Android 3.0 之前（或者没有启用硬件加速时），系统都会使用软件方式来渲染 UI。但是由于 CPU 在结构设计上的差异，对于图形处理并不是那么高效。这个过程完全没有利用 GPU 的图形高性能。

所以从 Android 3.0 开始，Android 开始支持硬件加速，但是到 Android 4.0 时才默认开启硬件加速。

Google 在 2012 年的 I/O 大会上宣布了 Project Butter 黄油计划，并且在 Android 4.1 中正式开启了这个机制。Project Butter 主要包含三个组成部分，VSYNC、Triple Buffer 和 Choreographer。

经过 Android 4.1 的 Project Butter 黄油计划之后，Android 的渲染性能有了很大的改善。

如果整个渲染过程比较耗时，可能造成无法响应用户的操作，进而出现卡顿的情况。GPU 对图形的绘制渲染能力更胜一筹，如果使用 GPU 并在不同线程绘制渲染图形，那么整个流程会更加顺畅。

正因如此，在 Android 5.0 引入两个比较大的改变。

一个是引入了 RenderNode 的概念，它对 DisplayList 及一些 View 显示属性都做了进一步封装。

另一个是引入了 RenderThread，所有的 GL 命令执行都放到这个线程上，渲染线程在 RenderNode 中存有渲染帧的所有信息，可以做一些 View 的异步渲染任务，这样即便主线程有耗时操作的时候也可以保证渲染的流畅性。

> 至此，我们已经知道 RenderThread 是 Android 5.0 之后的产物，用于分担主线程绘制任务的渲染线程。UI 可以进行异步绘制，那动画可以异步似乎也成为可能。

经过查看官方文档，得知 RenderThread 目前仅支持两种动画的完全渲染工作（RenderThread 的文档介绍真的是少之又少）。

- ViewPreportyAnimator
- CircularReveal

为了能够让动画顺利交给 RenderThread，除了不能设置任何回调且 View 支持硬件加速（Android 4.0 之后默认支持）之外，还必须必须满足 ViewPropertyAnimatorRT 不为 null，它是让动画交由 RenderThread 的关键。


==``普通属性动画，在主线程阻塞的时候，会出现丢帧卡顿现象。而使用 RenderThread 渲染的动画即使阻塞了主线程仍然不受影响``==