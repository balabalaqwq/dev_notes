
# SeerBar
***解决thumb与progress之间不相接有间隔的问题***

> android:splitTrack="false"



***解决GifDrawable复用会闪一帧***

```java
if(mIvLoading!=null){
    gifIn.seekTo(0);//重置，否则除首次加载外每次加载都会闪一下
    mIvLoading.setVisibility(View.VISIBLE);
    gifIn.reset();//复位，重新开始播放
}
```



***设置图片根据屏幕宽度自适应***

```
ViewGroup.LayoutParams layoutParams = imageView.getLayoutParams();
        WindowManager wm = (WindowManager) getContext()
                .getSystemService(Context.WINDOW_SERVICE);
        DisplayMetrics outMetrics = new DisplayMetrics();
        wm.getDefaultDisplay().getMetrics(outMetrics);
        screenWidth = outMetrics.widthPixels;
        layoutParams.width = screenWidth;
        layoutParams.height = ViewGroup.LayoutParams.WRAP_CONTENT;
        imageView.setLayoutParams(layoutParams);
        imageView.setMaxWidth(screenWidth);
        imageView.setMaxHeight(parent.getHeight());
        imageView.setAdjustViewBounds(true);
        imageView.setScaleType(ImageView.ScaleType.FIT_XY);
```

