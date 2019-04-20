import 'dart:async';

import 'package:flutter/material.dart';


/// 通过flutter提供的StreamBuilder组件 可以做到局部刷新
/// 我们只需要创建streamController 往stream的sink里丢数据
/// 在需要刷新的地方 使用StreamController刷新ui就好了 甚至都不需要写订阅的代码  好像setState() 没有用到了
/// 那我们可不可以把StatefulWidget 换成StatelessWidget呢？
/// 好像不行 因为StreamController 还需要我们在页面销毁时进行释放 不然会导致内存泄漏的
/// 唯一还需要用到StatefulWidget的地方 就是这个dispose() 的生命周期方法了
/// 而且现在更新数据的业务逻辑和widget的逻辑混写在一起了
/// 如果业务逻辑复杂了 那岂不是很难看？ 有更优雅点的实现方式吗？
class StreamBuilderPage extends StatefulWidget {

  @override
  StreamBuilderState createState() {
    return new StreamBuilderState();
  }
}

///单订阅 Stream 只有当存在监听的时候，才发送数据，广播订阅 Stream 则不考虑这点，有数据就发送；

class StreamBuilderState extends State<StreamBuilderPage>{

  StreamController<String> _singleController = StreamController();  // 创建单订阅类型
  Sink<String> _singleSink;
  StreamSubscription<String> _singleSubscription1;
  StreamSubscription<String> _singleSubscription2;


  StreamController<String> _multiController = StreamController.broadcast();  // 创建多订阅类型
  Sink<String> _multiSink;
  StreamSubscription<String> _multiSubscription1;
  StreamSubscription<String> _multiSubscription2;

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
          title: Text("StreamBuilder"),
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
                child: StreamBuilder<String>(
                  stream: _singleController.stream,
                  initialData: "initData",
                    builder: (BuildContext context,AsyncSnapshot<String>
                        snapshot){
                    return Text("A ：单订阅事件源 收到数据：${snapshot.data}");},
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                padding: EdgeInsets.all(20),
//                child: StreamBuilder<String>(
//                  stream: _singleController.stream,
//                  initialData: "initData",
//                  builder: (BuildContext context,AsyncSnapshot<String>
//                  snapshot){
//                    return Text("B ：单订阅事件源 收到数据：${snapshot.data}");},
//                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                ),
                padding: EdgeInsets.all(20),
                child: StreamBuilder<String>(
                  stream: _multiController.stream,
                  initialData: "initData",
                  builder: (BuildContext context,AsyncSnapshot<String>
                  snapshot){
                    return Text("C ：多订阅事件源 收到数据：${snapshot.data}");},
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                padding: EdgeInsets.all(20),

                // stream 通过外部传入，对数据的变化进行监听 在不同回调中，通过 setState 进行更新 _summary
                // 当 _summary 更新后，由于调用了 setState，
                // 触发state的build被调用，而在build方法中会调用 我们传过去的builder 方法，将最新的
                // _summary传递出去 这样便做到了局部刷新
                child: StreamBuilder<String>(
                  stream: _multiController.stream,
                  initialData: "initData",
                  builder: (BuildContext context,AsyncSnapshot<String>
                  snapshot){
                    return Text("D ：多订阅事件源 收到数据：${snapshot.data}");},
                ),
              ),

              MaterialButton(
                color: Colors.white70,
                child: Text("单订阅 事件源开始发射数据"),
                onPressed: startSingleListenerStreamEmitter,
              ),

              MaterialButton(
                color: Colors.white70,
                child: Text("多订阅 事件源开始发射数据"),
                onPressed: startMultiListenerStreamEmitter,
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


}