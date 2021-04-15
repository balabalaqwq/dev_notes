

**dart是强类型语言 ;**

**使用var（编译期的“语法糖”）时，在编译后会自动推断出类型;**

**dynamic表示动态类型，在编译时不会检查类型，被编译后为object类型，在运行时才会类型检查** 



# String

### substring()

![image-20210325184218307](https://gitee.com/balabalaqwq/pics/raw/master/image-20210325184218307.png)



### replace()

手机号隐藏第4-7位

```
str.replaceRange(3, 7, "****")
```

# List

### sort()  排序

```
Map map = Map();
map['id'] = i;
map['element'] = poster;
tempList.add(map);
//排序 按照map['id']对List<Map<String, dynamic>> 进行排序
tempList.sort((a, b) => (a['id']).compareTo(b['id']));
```