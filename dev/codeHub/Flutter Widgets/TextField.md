

# TextField



### 指定输入类型

```
keyboardType: TextInputType.text,//文本
```



### 搜索功能

```
onChanged: (string) {
  setState(() {
    searchList = [];
    //搜索源customerInfoList 例：搜索昵称和内容相关用户
    //渲染时先对搜索结果进行判空，空则显示源数据
    customerInfoList.forEach((element) {
      if(element.nickname.contains(string) || element.content.contains(string)) {
        searchList.add(element);
      }
    });
  });
},
```



### 自定义限制



```
inputFormatters: [
  PrecisionLimitFormatter(0, hasPointer: false)
],// 限制不能输入小数点
```



```
inputFormatters: [PrecisionLimitFormatter(2)],//限制小数点后2位
```



PrecisionLimitFormatter类

```
import 'package:flutter/services.dart';

class PrecisionLimitFormatter extends TextInputFormatter {
  int _scale;
  bool hasPointer;

  PrecisionLimitFormatter(this._scale, {this.hasPointer});

  //只能输入数值
  RegExp exp = new RegExp("[0-9.]");
  static const String POINTER = ".";
  static const String DOUBLE_ZERO = "00";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(POINTER) && newValue.text.length == 1) {
      //第一个不能输入小数点
      return oldValue;
    }

    ///输入完全删除
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    ///只允许输入小数
    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    ///包含小数点的情况
    if (newValue.text.contains(POINTER)) {
      ///是否能包含小数点
      if (hasPointer) {
        ///包含多个小数
        if (newValue.text.indexOf(POINTER) !=
            newValue.text.lastIndexOf(POINTER)) {
          return oldValue;
        }
        String input = newValue.text;
        int index = input.indexOf(POINTER);

        ///小数点后位数
        int lengthAfterPointer =
            input.substring(index, input.length).length - 1;

        ///小数位大于精度
        if (lengthAfterPointer > _scale) {
          return oldValue;
        }
      } else {
        return oldValue;
      }
    } else if (newValue.text.startsWith(POINTER) ||
        newValue.text.startsWith(DOUBLE_ZERO)) {
      ///不包含小数点,不能以“00”开头
      return oldValue;
    }
    return newValue;
  }
}
```