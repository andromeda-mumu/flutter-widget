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
         home: new FinishWidget()
       );
   }
 }
 class FinishWidget extends StatefulWidget{
   State<StatefulWidget> createState()=>new _FinishWidgetState();
 }
 class _FinishWidgetState extends State<FinishWidget>{
   @override
   Widget build(BuildContext context) {
          return new Scaffold(
                appBar: AppBar(title: Text('完成动画')),
                body:new Center(
                    child: RawMaterialButton(
                        child: Text('tap'),
                        onPressed: (){
                          FinishAnimation.show(context,onCompleted: ()=>debugPrint('=====mmc 动画完成'));
                        }))
            );
   }
 }

 class FinishAnimation extends StatefulWidget {
   final Color color;
   final VoidCallback onCompleted;

   const FinishAnimation({Key key, this.color, this.onCompleted})//==============这样写，代表参数不是必须的
       :super(key: key);

   State<StatefulWidget> createState() => new _FinishAnimationState();

   static show( BuildContext context,{VoidCallback onCompleted}){
       showDialog(
         context: context,
         barrierDismissible: false,
         builder: (context){
           return Center(
              child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10))
                 ),
                height: 120,
                width: 120,
                padding: EdgeInsets.all(30),
                child: FinishAnimation(onCompleted: (){
                  Navigator.of(context).pop();
                  if(onCompleted!=null){
                    onCompleted();
                  }
                },)
              ),
           );
         }
       );
   }

 }

  class _FinishAnimationPainter extends CustomPainter{
   static const Offset _p1 = Offset(0.0,0.5);
   static const Offset _p2 = Offset(0.3,0.8);
   static const Offset _p3 = Offset(0.75,0.35);

   final Color color;
   final double value;
   final double line1StartValue;
   final double line1EndValue;
   final double line2EndValue;

   final double _arcStart;
   final double _arcSweep;
   final Offset _line1Start;
   final Offset _line1End;
   final Offset _line2End;
   _FinishAnimationPainter(this.color,this.value,this.line1StartValue,this.line1EndValue,this.line2EndValue)
   :_arcStart = math.pi+math.pi*2*value*2,
   _arcSweep = -value*math.pi *2,
   _line1Start = _p1-(_p1 - _p2)*line1StartValue,
   _line1End = _p1 -(_p1 - _p2)*line1EndValue,
   _line2End = _p2 - (_p2 - _p3)*line2EndValue;



  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
    ..color =color ?? Colors.blue
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 4.0
    ..style = PaintingStyle.stroke;

    if(_line1Start!=_line1End){
      canvas.drawLine(_line1Start*side, _line1End*side, paint);
    }
    if(_p2!=_line2End){
      canvas.drawLine(_p2*side, _line2End*side, paint);
    }
    canvas.drawArc(Offset.zero & Size(side,side), _arcStart, _arcSweep, false, paint);

  }

  @override
  bool shouldRepaint(_FinishAnimationPainter oldDelegate) {
    return value !=oldDelegate.value;
  }

  }

 class _FinishAnimationState extends State<FinishAnimation> with SingleTickerProviderStateMixin{
   AnimationController _controller;
   @override
   Widget build(BuildContext context) {
         return AnimatedBuilder(
           animation: _controller,
           builder: (context,child){
             return _buildBody();
           },
         ) ;
   }
   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500),
    )
      ..forward()
        ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
          widget.onCompleted();
      }
        });
  }

  Widget _buildBody(){
     return CustomPaint(
       painter: _FinishAnimationPainter(widget.color, _controller.value,
           /** 这里注意了，千万要写成float类型，小数点不能省略。不然就报错。*/
           Tween(begin: 0.0,end: 0.5).transform(Interval(0.75,1.0).transform(_controller.value)),
           Interval(0.5,0.75).transform(_controller.value),
           Interval(0.75,1.0).transform(_controller.value)),
     );
  }
 }