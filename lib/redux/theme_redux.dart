import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/// 处理主题action的Reducer

///将 Action 、处理 Action 的方法、State 绑定
/// 这种写法是Dart的语法特性 当class中的方法 参数类型 与返回值类型 与目标一致时
/// 可以省略return new class.call(func())  而直接写作 Class(func())

final themeDataReducer = TypedReducer<ThemeData, ChangeThemeAction>(_refresh);

///定义处理 Action 行为的方法，返回新的 State
ThemeData _refresh(ThemeData themeData, action) {
  return action.themeData;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class ChangeThemeAction {

  final ThemeData themeData;

  ChangeThemeAction(this.themeData);

}
