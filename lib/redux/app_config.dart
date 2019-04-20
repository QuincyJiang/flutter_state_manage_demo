import 'package:flutter/material.dart';
import 'theme_redux.dart';
import 'login_status_redux.dart';


/// 1. 定义全局state 会影响整个app的行为
class AppState{
  ThemeData themeData;
  String loginStatus;
  AppState({this.themeData, this.loginStatus});
}


/// 2. 定义state对应的Reducer 所谓Reducer 就是一个Function 拿到action 和 上一个state
///    然后根据对应的业务逻辑 决定如何更新state
///    因为Reducer 和 State 基本都是一起出现 所以习惯上将State 和 与之对应的Reducer写在一起
///
///    这里可以看到  Redux 相比于 BloC 的优势在于
///    一个BloC 其实就等同于一个Business层 相对比较独立 一般只关注某个page的局部状态
///    bloc 与 bloc 之间沟通困难
///    而 Redux 更擅长与 整和各个Business层 因为每个Reducer 其实都相当于一个Business
///    reducer 与 reducer 之前可以组合使用

AppState appReducer(AppState lastState,dynamic action){
  return AppState(
      themeData: themeDataReducer(lastState.themeData, action),
    loginStatus: loginStatusRedux(lastState.loginStatus, action)
  );
}




