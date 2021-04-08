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