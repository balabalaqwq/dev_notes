```
import 'package:flutter/material.dart';

class CustomerScaleClick extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final double scale;
  final bool enable;
  final HitTestBehavior behavior;

  const CustomerScaleClick(
      {Key key, this.child, this.onTap, this.scale, this.enable, this.behavior})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomerScaleClickState();
  }
}

class CustomerScaleClickState extends State<CustomerScaleClick> {
  double _scale = 1;
  bool _enable = true;

  @override
  Widget build(BuildContext context) {
    _enable = this.widget.enable ?? _enable;
    return GestureDetector(
      behavior: this.widget.behavior,
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

```

