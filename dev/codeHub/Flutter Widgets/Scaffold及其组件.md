# Scaffold 及其组件



## snackBar、bottomSheet的使用：

```
@override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
    ...
 body: Builder(//通过Builder传context 不然拿不到context
        builder: (BuildContext context) {
          return _buildBody(context);
        },
      ),
    );
  }
  _buildBody(BuildContext context) {
    return RaisedButton(
                    onPressed: () {
                  //弹出snackBar    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('测试'),
                        ),
                      );
                       //弹出bottomSheet
                       Scaffold.of(context).showBottomSheet((context) => _buildARCodeView(context));
                    },
                  );
    }
```

