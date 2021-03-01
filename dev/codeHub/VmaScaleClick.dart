import 'package:flutter/material.dart';

class VmaScaleClick extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final double scale;
  final bool enable;

  const VmaScaleClick(
      {Key key, this.child, this.onTap, this.scale, this.enable})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VmaScaleClickState();
  }
}

class VmaScaleClickState extends State<VmaScaleClick> {
  double _scale = 1;
  bool _enable = true;

  @override
  Widget build(BuildContext context) {
    _enable = this.widget.enable ?? _enable;
    return GestureDetector(
      onTap: this.widget.onTap,
      onTapDown: (e) {
        if (!_enable) return;
        setState(() => _scale = this.widget.scale ?? 0.95);
      },
      onTapUp: (e) {
        if (!_enable) return;
        setState(() => _scale = 1);
      },
      onTapCancel: () {
        if (!_enable) return;
        setState(() => _scale = 1);
      },
      child: Transform.scale(
        scale: this.widget.onTap == null ? 1 : _scale,
        child: this.widget.child,
      ),
    );
  }
}