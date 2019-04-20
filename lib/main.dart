import 'package:flutter/material.dart';
import 'package:flutter_state_management/bloc.dart';
import 'package:flutter_state_management/redux.dart';
import 'package:flutter_state_management/redux/app_config.dart';
import 'package:flutter_state_management/set_state.dart';
import 'package:flutter_state_management/stream_builder.dart';
import 'package:redux/redux.dart';
import 'stream.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(ReduxApp());

class ReduxApp extends StatelessWidget {

  // 在此创建全局Store 链接reducer 和 state
  // Store 的本质 仍然是通过StreamController来实现的
  // Store.dispatch(Action) =>middleWare(Action,oldState) =>reducer(Action,
  // oldState) => newState => sink.add(newState => sink.listener(call builder
  // func))
  final store = new Store<AppState>(
      appReducer,
      initialState: new AppState(
          themeData: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          loginStatus: "未登录"
      ));

  @override
  Widget build(BuildContext context) {
    //可以看到 StoreProvider 本质是一个InheritWidget
    // 用它包裹住MaterialApp 使这个InheritWidget成为最高节点，同时将Store传递进去
    // 这也是它得以管理全局状态的原因 因为其他任何page 都是StoreProvider 的子孙
    // 都可以通过StoreProvider<S>.of(context)来获取这个store实例
    return new StoreProvider<AppState>(
      store: store,
      child: StoreBuilder<AppState>(builder: (context,store){
        return new MaterialApp(
          title: "State manage demo",
          theme: store.state.themeData,
          home: MyHomePage(title: store.state.loginStatus,),
        );
      })
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  toStreamPage() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => StreamWidget()));
  }
  toStreamBuilderPage() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => StreamBuilderPage()));
  }

  toSetSatePage(){
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => SetStatePage()));
  }

  toBlocPage(){
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => BlocPage()));
  }

  toReduxPage(){
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => ReduxPage()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: toSetSatePage,
              child: Text("setState"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: toStreamPage,
              child: Text("stream"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: toStreamBuilderPage,
              child: Text("streamBuilder"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: toBlocPage,
              child: Text("bloc"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: toReduxPage,
              child: Text("redux"),
            ),
          ],
        ),
      ),
    );
  }
}
