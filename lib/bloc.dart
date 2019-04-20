
import 'package:flutter/material.dart';
import 'package:flutter_state_management/bloc/demo_bloc.dart';
import 'package:flutter_state_management/providers/bloc_provider.dart';


/// BloC 即 Business logic Component
/// 使用Bloc模式构建页面 可以分离业务逻辑
/// 页面部分只与widget相关 并且可以抛弃StatefulWidget 更优雅更清爽
///
/// 看一下通过Bloc模式 我们可以获得什么：
///
/// 1. 责任分离：StreamBuilder控件中没有任何处理业务逻辑的代码，所有的业务逻辑处理都在单独的DemoBloc组件中进行。
///    如果你要修改业务逻辑，只需要修改 startSingleEmitter()方法就行了，无论处理过程多么复杂，BlocPage都不需要关心。
/// 2. 可测试性：只需要测试DemoBloc类即可。
/// 3. 自由组织布局：有了Streams，你就可以完全独立于业务逻辑地去组织你的布局了。可以在App中任何位置触发操作，只需要通过
///    对应的sink传入即可；也可以在任何页面的任何位置来展示数据，只需要监听对应的stream。
/// 4. 减少了build的数量：使用StreamBuilder放弃setState()
///    大大减少了build的数量，因为只需要build需要刷新的控件，从性能角度来讲是一个重大的提升。
///
///
class BlocPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: DemoBloc(),
      child: BlocWidget(),
    );
  }
}

class BlocWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    // BlocProvider 方法 通过当前的buildContext 遍历widget树 找到祖先节点中DemoBloc成员变量 并获取之
    // 这种方法的时间复杂度为o(n) 不适合目标父widget与当前widget层级相隔太远
    // 也可以看到 BloC模式 更适合维护页面相关的数据和状态
    // App层级的数据状态 如果在最顶层Widget写一个AppBloc的话
    // 如果当前页面需要获取App相关的数据 通过buildContext去遍历widget树的话 性能难免不好
    // 所以有没有更好的 管理App 全局状态的方式呢？

    final DemoBloc bloc = BlocProvider.of<DemoBloc>(context);
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
                  stream: bloc.singleStream,
                  initialData: "initData",
                  builder: (BuildContext context,AsyncSnapshot<String>
                  snapshot){
                    return Text("A ：单订阅事件源 收到数据：${snapshot.data}");},
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                ),
                padding: EdgeInsets.all(20),
                child: StreamBuilder<String>(
                  stream: bloc.multiStream,
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

                child: StreamBuilder<String>(
                  stream: bloc.multiStream,
                  initialData: "initData",
                  builder: (BuildContext context,AsyncSnapshot<String>
                  snapshot){
                    return Text("D ：多订阅事件源 收到数据：${snapshot.data}");},
                ),
              ),

              MaterialButton(
                color: Colors.white70,
                child: Text("单订阅 事件源开始发射数据"),
                onPressed: ()=>bloc.startSingleEmitter(),
              ),

              MaterialButton(
                color: Colors.white70,
                child: Text("多订阅 事件源开始发射数据"),
                onPressed: ()=>bloc.startMultiEmitter(),
              ),
            ],
          ),
        )
    );
  }
}