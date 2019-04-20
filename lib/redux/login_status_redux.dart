import 'package:redux/redux.dart';

/// 处理登录action的Reducer

final loginStatusRedux = TypedReducer<String, LoginAction>(_login);

///定义处理 Action 行为的方法，返回新的 State
String _login(String oldLoginState,action)  {
    if (action.password == "233")
      return "登录成功";
    return oldLoginState;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class LoginAction {

  final String password;

  LoginAction(this.password);

}