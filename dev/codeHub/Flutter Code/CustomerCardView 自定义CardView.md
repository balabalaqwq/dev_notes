```
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'CustomerScaleClick.dart';

// 自定义带点击事件的卡片效果view
class CustomerCardView extends StatefulWidget {
  const CustomerCardView(
      {Key key,
      this.padding,
      this.margin,
      this.radius,
      this.color,
      this.shadowColor,
      this.offsetDx,
      this.offsetDy,
      this.spreadRadius,
      this.blurRadius,
      this.child,
      this.onTap,
      this.width,
      this.height,
      this.scale,
      this.gradient,
      this.constraints,
      this.boxBorder,
      this.behavior,
      this.isCustomRadius,
      this.leftBottomRadius,
      this.rightBottomRadius,
      this.leftTopRadius,
      this.rightTopRadius,
      this.enable,
      this.decoration})
      : super(key: key);

  final GestureTapCallback onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget child;
  final double radius;
  final Color color;
  final Color shadowColor;
  final double offsetDx;
  final double offsetDy;
  final double spreadRadius;
  final double blurRadius;
  final double width;
  final double height;
  final bool enable;
  final double scale;
  final Gradient gradient;
  final BoxConstraints constraints;
  final BoxBorder boxBorder;
  final HitTestBehavior behavior;
  final double leftTopRadius;
  final double rightTopRadius;
  final double leftBottomRadius;
  final double rightBottomRadius;
  final bool isCustomRadius;
  final Decoration decoration;
  @override
  State<StatefulWidget> createState() {
    return CustomerCardViewState();
  }
}

class CustomerCardViewState extends State<CustomerCardView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomerCardView(
      scale: this.widget.scale,
      enable: this.widget.enable,
      onTap: this.widget.onTap,
      behavior: this.widget.behavior,
      child: Container(
        constraints: this.widget.constraints,
        width: this.widget.width,
        height: this.widget.height,
        padding: this.widget.padding,
        margin: this.widget.margin,
        decoration: this.widget.decoration?? BoxDecoration(
          color: this.widget.color ?? Colors.white,
          gradient: this.widget.gradient,
          border: this.widget.boxBorder,
          boxShadow: [
            BoxShadow(
                offset: Offset(
                    this.widget.offsetDx ?? 0.0, this.widget.offsetDy ?? 8.0),
                color: this.widget.shadowColor ?? Color(0xffEBEBEB),
                blurRadius: this.widget.blurRadius ?? 20,
                spreadRadius: this.widget.spreadRadius ?? 5)
          ],
          borderRadius: !(this.widget.isCustomRadius ?? false)
              ? BorderRadius.all(Radius.circular(this.widget.radius ?? 20))
              : BorderRadius.only(
                  topLeft: Radius.circular(this.widget.leftTopRadius),
                  topRight: Radius.circular(this.widget.rightTopRadius),
                  bottomLeft: Radius.circular(this.widget.leftBottomRadius),
                  bottomRight: Radius.circular(this.widget.rightBottomRadius)),
        ),
        child: this.widget.child,
      ),
    );
  }
}
```