
import 'dart:async';

import 'package:flutter_state_management/providers/bloc_provider.dart';

class DemoBloc implements IBlocBase {

 StreamController<String> _singleController = new StreamController<String>();
 StreamController<String> _multiController = new StreamController<String>.broadcast();

 Stream<String> get singleStream => _singleController.stream;
 Stream<String> get multiStream => _multiController.stream;
 Sink<String> get _singleEmitter => _singleController.sink;
 Sink<String> get _multiEmitter => _multiController.sink;

  @override
  void dispose() {
   if (!_singleController.isClosed) {
     _singleController.close();
   }
   if (!_multiController.isClosed) {
     _multiController.close();
   }
   _singleEmitter.close();
   _multiEmitter.close();
  }

  void startSingleEmitter() async {
    for (var i = 0;i<=100;i++) {
      _singleEmitter.add("单订阅"+i.toString());
      await Future<int>.delayed(Duration(milliseconds: 1000));
    }
  }

 void startMultiEmitter() async {
   for (var i = 0;i<=100;i++) {
     _multiEmitter.add("多订阅"+i.toString());
     await Future<int>.delayed(Duration(milliseconds: 1000));
   }
 }

}