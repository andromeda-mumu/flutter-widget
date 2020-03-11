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
   /** 对 xx属性 做动画 */
   Animation<double> left;
   Animation<Color> color;

   @override
  void initState() {
    super.initState();
    /** 加入到队列中，等待执行。类似于android的postRunnable */
    Future(_initState);
  }
   void _initState(){
     /** 动画控制器，也就是控制时间的 */
     controller = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));

     /** 通过MediaQuery 获取屏幕宽度 */
     final MediaQueryData = MediaQuery.of(context);
     final displayWidth = MediaQueryData.size.width;
     debugPrint('=====mmc width=$displayWidth');
     /** left值 根据tween 变化，调用setState，更新页面，就形成了动画效果 */
     left = Tween(begin: padding,end:displayWidth-padding).animate(controller)
     ..addListener(() {
       setState(() {

       });
     })
     ..addStatusListener((status) {
       if(status == AnimationStatus.completed){
         controller.reverse();//==============动画完成后，反向执行
       }else if(status == AnimationStatus.dismissed){
         controller.forward();//==============正着执行
       }
     });

    /** color 值也是一直变化的。因为前面已经调用了setState，因此这里不用调用 */
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
        margin: EdgeInsets.only(left: marginLeft,top: marginTop),//==============这里实时获得新的left值
        child: Container(
          decoration: BoxDecoration(
//            color: Colors.red,
            color: color,//==============这里实时获得新的color值
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