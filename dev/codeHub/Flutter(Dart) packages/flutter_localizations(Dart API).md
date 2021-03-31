## 国际化支持

### flutter剪切板英文改中文

导入包

```undefined
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
```



APP入口添加配置：

main.dart

```csharp
runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('zh', 'CN'),
      const Locale('en', 'US'),
    ],
));
```