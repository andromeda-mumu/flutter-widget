import 'package:flutter/material.dart';
import 'dart:math' as math;
/**
 * Created by wangjiao on 2020/3/11.
 * description:
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
             child: CustomPaint(painter: PainterDemo(0.0, math.pi),),
             height: 200,
             width: 200,
             color: Colors.deepOrange,
             padding: EdgeInsets.all(30),
           )
         ),
       );
   }
 }
 
class PainterDemo extends CustomPainter{
  final double _arcStart;
  final double _arcSweep;
  PainterDemo(this._arcStart,this._arcSweep);
  @override
  void paint(Canvas canvas, Size size) {
     double side = math.min(size.width,size.height);
     Paint paint = Paint()
     ..color=Colors.blue
     ..strokeCap = StrokeCap.round
     ..strokeWidth=4.0
     ..style=PaintingStyle.stroke;


     canvas.drawArc(Offset.zero&Size(side,side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(PainterDemo oldDelegate) {
    return _arcStart!=oldDelegate._arcStart || _arcSweep !=oldDelegate._arcSweep;
  }
  
}