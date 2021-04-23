# StringExtension



```
/// 零宽字符
extension StringExtension on String {
  String get notBreak => replaceAll('', '\u{200B}');
}
```





## 函数场景



str='规格：123456' 

超范围了显示 '规...' 

想要显示效果'规格：123...'