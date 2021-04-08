```
ListView.separated(
  scrollDirection: Axis.horizontal,
  padding:
  EdgeInsets.only(left: 25.w, right: 25.w),
  itemBuilder: (BuildContext context, int index) {
    if(index == 0) {
      return _demo(index, "全部", null);
    }
    if(materialChannelList.isNotEmpty) {
      return _demo(index, materialChannelList[index -1].name, materialChannelList[index - 1].typeId);
    } else {
      return _demo(index, recommendList[index -1].name, recommendList[index - 1].id);
    }
  },
  // itemCount: materialChannelList.isNotEmpty? materialChannelList.length + 1 :recommendList.length + 1,
  itemCount: materialChannelList.isNotEmpty ? materialChannelList.length + 1 : recommendList.length+1,
  physics: BouncingScrollPhysics(),
  separatorBuilder:
      (BuildContext context, int index) =>
      VerticalDivider(
        width: 20.w,
        color: Colors.white,
      ),
)
```