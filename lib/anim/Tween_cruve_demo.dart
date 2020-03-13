import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'PainterDemo.dart';
/**
 * Created by wangjiao on 2020/3/11.
 * description: 绘制动画
 */
void main()=>runApp(new MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'chloe',
      home: new Scaffold(
          appBar: new AppBar(title: Text('MyApp'),),
          body :new AnimPaintWidget()
      ),
    );
  }
}
class AnimPaintWidget extends StatefulWidget{
  State<StatefulWidget> createState()=>new _AnimPaintWidgetState();
}
class _AnimPaintWidgetState extends State<AnimPaintWidget> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    _controller= AnimationController(vsync: this,duration: Duration(milliseconds: 1500))
      ..repeat();
//    ..addListener(() {setState(() {
//
//    });});
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Widget anim = AnimatedBuilder(animation: _controller,builder: (context,child){
      return CustomPaint(painter: PainterDemo(
        /**
        * 把两个固定的start end，变成两个不固定的值。动画+动画的效果
         * Tween 和 curve可以更好的控制animation的值。一般animation会在给定的时间内 线性的 产生0.0到1.0的值
         * Tween可以把这些转变成我们想要的类型或者范围，如Tween(begin: math.pi * 1.5, end: math.pi * 1.5 + math.pi * 2).evaluate(_controller),范围就是1.5pi到3.5pi
         *
         * curve是抽象类表示生成值的曲线。
         *
         * tween curve可以使用chain,evalute，transform 和animation串起来使用
        *
        */
          Tween(begin: math.pi*1.5,end: math.pi*3.5).chain(CurveTween(curve: Interval(0.5, 1.0))).evaluate(_controller),
          math.sin(Tween(begin: 0.0,end: math.pi).evaluate(_controller))*math.pi
//       math.sin(_controller.value*math.pi)*math.pi   也可以这样简洁的写法
        )
      );
    });
    return new Container(
      child: anim,//==============注意，这里要使用container包着。不能直接body
      height: 200,
      width: 200,
      color: Colors.deepOrange,
      padding: EdgeInsets.all(30),
    );
  }
}