import 'package:flutter/material.dart';
import 'dart:math';
/**
 * Created by wangjiao on 2020/3/3.
 * description:
 */


void main() {
  runApp(MyApp());
}

/**
 *  这个widget是应用顶层的widget
 *  widget有两种：无状态   StatelessWidget
 *               有状态   StatefulWidget
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //创建内容
    return MaterialApp(
      title: 'our first Flutter app',
      //应用的主页
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter rolling demo'),
        ),
        //因为flutter所有东西都是widget，而按钮在中间，因此用center来实现
        body: Center(
//            child: RaisedButton(onPressed: _onPressed(context),child:Text('roll')),
          child: RollingButtion(),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    debugPrint('_onPressed');
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        content: Text('AlertDialog'),
      );
    });
  }

}

class RollingButtion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RollingState();
  }
}
//这里的泛型参数是 RollingButton
//class _RollingState extends State<RollingButtion>{
//  @override
//  Widget build(BuildContext context) {
//      return RaisedButton(
//        child: Text('Roll'),
//        onPressed: _onPressed,
//      );
//  }
//
//  void _onPressed(){
//    debugPrint('_rollingState _onPressed');
//    showDialog(context: context,builder: (_){
//      return AlertDialog(
//        content: Text('AlertDialog'),
//      );
//    });
//  }
//
//}


class _RollingState extends State<RollingButtion> {
  final _random = Random();

  List<int> _roll() {
    final roll1 = _random.nextInt(6) + 1;
    final roll2 = _random.nextInt(6) + 1;
    return [roll1, roll2];
  }

  void _onPressed() {
    debugPrint('_RollingState._onPressed');
    final rollResults = _roll();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("随机数是：(${rollResults[0]},${rollResults[1]})"),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Roll'),
      onPressed: _onPressed,
    );
  }

}