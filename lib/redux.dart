
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_state_management/redux/app_config.dart';
import 'package:flutter_state_management/redux/login_status_redux.dart';
import 'package:flutter_state_management/redux/theme_redux.dart';
import 'package:redux/redux.dart';

class ReduxPage extends StatelessWidget{
  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
      return StoreBuilder<AppState>(
        builder: (context, stote){
          return new Scaffold(
              appBar: AppBar(
                title: Text("Redux"),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.white70,
                      child: Text("橙色主题"),
                      onPressed: () => changeTheme(context,stote,Colors.deepOrange),
                    ),
                    MaterialButton(
                      color: Colors.white70,
                      child: Text("蓝色主题"),
                      onPressed: () => changeTheme(context,stote,Colors.blue),
                    ),
                    new TextField(
                      controller: _controller,
                      decoration: new InputDecoration(
                        hintText: '密码：233',
                      ),
                    ),
                    MaterialButton(
                      color: Colors.white70,
                      child: Text("登录"),
                      onPressed: () => login(_controller.text,context,stote),
                    ),
                  ],
                ),
              )
          );
        }
      );
  }

  void changeTheme(BuildContext context,Store store,MaterialColor color){
    store.dispatch(new ChangeThemeAction(ThemeData(primarySwatch: color)));
  }

  void login(String psw, BuildContext context,Store store){
    store.dispatch(LoginAction(psw));
  }
}