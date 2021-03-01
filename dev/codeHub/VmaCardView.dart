import 'package:flutter/material.dart';
import 'package:vma_ky/UI/VmaScaleClick.dart';

// 自定义带点击事件的卡片效果view
class VmaCardView extends StatefulWidget {
  const VmaCardView(
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
      this.enable})
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

  @override
  State<StatefulWidget> createState() {
    return VmaCardWidgetState();
  }
}

class VmaCardWidgetState extends State<VmaCardView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return VmaScaleClick(
      scale: this.widget.scale,
      enable: this.widget.enable,
      onTap: this.widget.onTap,
      child: Container(
        width: this.widget.width,
        height: this.widget.height,
        padding: this.widget.padding,
        margin: this.widget.margin,
        decoration: BoxDecoration(
          color: this.widget.color ?? Colors.white,
          gradient: this.widget.gradient,
          boxShadow: [
            BoxShadow(
                offset: Offset(
                    this.widget.offsetDx ?? 0.0, this.widget.offsetDy ?? 8.0),
                color: this.widget.shadowColor ?? Color(0xffEBEBEB),
                blurRadius: this.widget.blurRadius ?? 20,
                spreadRadius: this.widget.spreadRadius ?? 5)
          ],
          borderRadius:
              BorderRadius.all(Radius.circular(this.widget.radius ?? 20)),
        ),
        child: this.widget.child,
      ),
    );
  }
}