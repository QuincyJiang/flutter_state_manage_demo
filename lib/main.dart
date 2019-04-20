import 'package:flutter/material.dart';
import 'package:flutter_state_management/bloc.dart';
import 'package:flutter_state_management/setState.dart';
import 'stream.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
        builder: (BuildContext context) => BlocPage()));
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
              color: Colors.deepOrangeAccent,
              onPressed: toSetSatePage,
              child: Text("setState"),
            ),
            MaterialButton(
              color: Colors.deepOrangeAccent,
              onPressed: toStreamPage,
              child: Text("stream"),
            ),
            MaterialButton(
              color: Colors.deepOrangeAccent,
              onPressed: toBlocPage,
              child: Text("bloc"),
            ),
            MaterialButton(
              color: Colors.deepOrangeAccent,
              onPressed: toReduxPage,
              child: Text("redux"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toStreamPage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
