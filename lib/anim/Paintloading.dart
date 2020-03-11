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
           body :new Container(
             child: AnimPaintWidget(),//==============注意，这里要使用container包着。不能直接body
             height: 200,
             width: 200,
             color: Colors.deepOrange,
             padding: EdgeInsets.all(30),
           )
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
     return AnimatedBuilder(animation: _controller,builder: (context,child){
       return CustomPaint(painter: PainterDemo(0.0,_controller.value*math.pi*2));
     });
   }
 }