import 'package:flutter/material.dart';
import 'dart:math' as math;
/**
 * Created by wangjiao on 2020/3/10.
 * description: 自定义动画
 */

 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         home: new Scaffold(
           appBar: new AppBar(title: Text('Animation demo'),),
           body : CustomAnimWidget()
         ),
       );
   }
 }

 class CustomAnimWidget extends StatefulWidget{
   State<StatefulWidget> createState()=>new _CustomAnimWidgetState();
 }
 class _CustomAnimWidgetState extends State<CustomAnimWidget> with SingleTickerProviderStateMixin{
   static const padding = 16.0;
   AnimationController controller;
   Animation<double> left;
   Animation<Color> color;

   @override
  void initState() {
    super.initState();
    Future(_initState);
  }
   void _initState(){
     controller = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));

     /** 通过MediaQuery 获取屏幕宽度 */
     final MediaQueryData = MediaQuery.of(context);
     final displayWidth = MediaQueryData.size.width;
     debugPrint('=====mmc width=$displayWidth');
     left = Tween(begin: padding,end:displayWidth-padding).animate(controller)
     ..addListener(() {
       setState(() {

       });
     })
     ..addStatusListener((status) {
       if(status == AnimationStatus.completed){
         controller.reverse();
       }else if(status == AnimationStatus.dismissed){
         controller.forward();
       }
     });


     color = ColorTween(begin: Colors.red,end: Colors.blue).animate(controller);
     controller.forward();
   }
   @override
   Widget build(BuildContext context) {//刷新页面，形成动画的效果
      final unit = 24.0;
      final marginLeft = left == null?padding:left.value;

      final unitizedLeft = (marginLeft-padding)/unit;
      final unitizedTop = math.sin(unitizedLeft);

      final marginTop =(unitizedTop+1)*unit+padding;

      final color = this.color == null?Colors.red:this.color.value;
      return Container(
        margin: EdgeInsets.only(left: marginLeft,top: marginTop),
        child: Container(
          decoration: BoxDecoration(
//            color: Colors.red,
            color: color,
            borderRadius: BorderRadius.circular(7.5)
          ),
          width: 15,
          height: 15,
        ),
      );
   }

   @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
 }