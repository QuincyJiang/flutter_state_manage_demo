
import 'dart:async';

import 'package:flutter/material.dart';
import 'stream_builder.dart';


/// 通过往stream暴露的sink 流入新数据 然后stream.listen() 监听stream中流出的数据  再setState刷新页面
/// 因为调用了当前widget的setState方法  会触发整个StreamWidget的子树进行Rebuild()
/// 有没有什么更好的方法 只令显示内容有变化的子widget Rebuild 而不是重建整个widget树呢？
class StreamWidget extends StatefulWidget {

  @override
  StreamState createState() {
    return new StreamState();
  }
}

///单订阅 Stream 只有当存在监听的时候，才发送数据，广播订阅 Stream 则不考虑这点，有数据就发送；

class StreamState extends State<StreamWidget>{

  String _singleSubscribeCountA = "";
  String _singleSubscribeCountB = "";

  // 创建单订阅类型的streamController
  StreamController _singleController = StreamController();
  // 单订阅类型的streamController中 stream暴露出的sink
  Sink _singleSink;
  // 订阅关系1
  StreamSubscription _singleSubscription1;
  // 订阅关系2
  StreamSubscription _singleSubscription2;


  String _multiSubscribeCountC = "";
  String _multiSubscribeCountD = "";

  // 通过broadCast创建支持多订阅类型的streamController
  StreamController _multiController = StreamController.broadcast();  // 创建多订阅类型
  Sink _multiSink;
  StreamSubscription _multiSubscription1;
  StreamSubscription _multiSubscription2;

  @override
  void initState() {
    _singleSink = _singleController.sink;
    _multiSink = _multiController.sink;
    super.initState();
  }

  @override
  void dispose() {

    _singleSink.close();
    _singleController.close();
    if (_singleSubscription1 != null) {
      _singleSubscription1.cancel();
    }
    if (_singleSubscription2 != null) {
      _singleSubscription2.cancel();
    }

    _multiSink.close();
    _multiController.close();
    if (_multiSubscription1 != null) {

    }
    _multiSubscription1.cancel();
    if (_multiSubscription2 != null) {
      _multiSubscription2.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              padding: EdgeInsets.all(20),
              child: Text("A ：单订阅事件源 收到数据：${_singleSubscribeCountA}"),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              padding: EdgeInsets.all(20),
              child: Text("B ：单订阅事件源 收到数据：${_singleSubscribeCountB}"),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              padding: EdgeInsets.all(20),
              child: Text("C ：多订阅事件源 收到数据：${_multiSubscribeCountC}"),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              padding: EdgeInsets.all(20),
              child: Text("D ：多订阅事件源 收到数据：${_multiSubscribeCountD}"),
            ),

            MaterialButton(
              color: Colors.white70,
              child: Text("单订阅 事件源开始发射数据"),
              onPressed: startSingleListenerStreamEmitter,
            ),
            MaterialButton(
              color: Colors.white70,
              child: Text("单订阅 A开始订阅"),
              onPressed: listenSingleStreamA,
            ),
            MaterialButton(
              color: Colors.white70,
              child: Text("单订阅 B开始订阅"),
              onPressed: listenSingleStreamB,
            ),
            MaterialButton(
              color: Colors.white70,
              child: Text("多订阅 事件源开始发射数据"),
              onPressed: startMultiListenerStreamEmitter,
            ),
            MaterialButton(
              color: Colors.white70,
              child: Text("多订阅 C开始订阅"),
              onPressed: listenMultiStreamC,
            ),
            MaterialButton(
              color: Colors.white70,
              child: Text("多订阅 D开始订阅"),
              onPressed: listenMultiStreamD,
            ),
          ],
        ),
      )
    );
  }

  void  startSingleListenerStreamEmitter() async {
    for (var i = 0;i<=100;i++) {
      _singleSink.add("单订阅"+i.toString());
      await Future<int>.delayed(Duration(milliseconds: 1000));
    }
  }

  void  startMultiListenerStreamEmitter() async {
    for (var i = 0;i<=100;i++) {
      _multiSink.add("多订阅"+i.toString());
      await Future<int>.delayed(Duration(milliseconds: 1000));
    }
  }

  void listenSingleStreamA() {
    // 单订阅模式 listen之后才会开始发射数据
    _singleSubscription1 = _singleController.stream.listen((data) => setState
      ((){
        _singleSubscribeCountA = data ;
        print("Single subscriberA receive stream data :" +data);
    }));
  }
  void listenSingleStreamB() {

    // 单订阅模式 listen之后才会开始发射数据
    _singleSubscription2 = _singleController.stream.listen((data) => setState
      (() {
      _singleSubscribeCountB = data;
      print("Single subscriberB receive stream data :" + data);
    }));
  }
  void listenMultiStreamC() {

    // 单订阅模式 listen之后才会开始发射数据
    _multiSubscription1 = _multiController.stream.listen((data) => setState
      (() {
      _multiSubscribeCountC = data;
      print("Multi subscriberB receive stream data :" + data);
    }));
  }
  void listenMultiStreamD() {
    // 单订阅模式 listen之后才会开始发射数据
    _multiSubscription2 = _multiController.stream.listen((data) => setState
      (() {
      _multiSubscribeCountD = data;
      print("Multi subscriberB receive stream data :" + data);
    }));
  }

}