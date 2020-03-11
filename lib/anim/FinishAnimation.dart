import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         /** 这里必须要用 StatefulWidget 来嵌套，才能显示出来效果 */
         home: FinishWidget()
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
                body:new Center(child:RawMaterialButton(
                    child: Text('Tap'),
                    onPressed: (){
                      /** 点击，弹出弹窗，显示动画 */
                      FinishAnimation.show(context,onCompleted: ()=>debugPrint('=====mmc 完成动画'));
                    }) ,)
            );
   }
 }

 /**
 * 开始真正的动画部分
 *
 */
class FinishAnimation extends StatefulWidget {
  final Color color;
  final VoidCallback onCompleted;

  const FinishAnimation({Key key, this.color, this.onCompleted})
      : super(key: key);

  @override
  _FinishAnimationState createState() => _FinishAnimationState();

  static show(BuildContext context, {VoidCallback onCompleted}) {
    showDialog(//==============显示弹窗
      barrierDismissible: false,//==============点击弹窗外，不关闭弹窗。类似android中的dialog设置canCancel(false)
      context: context,
      builder: (context) {//==============build返回一个widget
        return Center(
          child: Container(
            decoration: BoxDecoration(//==============白色背景框，圆角
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            height: 120.0,
            width: 120.0,
            padding: EdgeInsets.all(30.0),
            /** 这里的color可以自定义 */
            child: FinishAnimation(/*color: Colors.red,*/onCompleted: () {//==============真正显示的widget,是一个动画。
              Navigator.of(context).pop();//==============定义了动画complete时，弹窗小时。
              if (onCompleted != null) {
                onCompleted();//==============这里回调 业务代码。告诉调用者，绘制完成了
              }
            }),
          ),
        );
      },
    );
  }
}

/**
* 真正绘制画面类
 * 画一个圆弧，也就是外圆
 * 在画一个对勾，其实就是2条线组成，需要3个点确定线的位置
*/
class _FinishAnimationPainter extends CustomPainter {
  static const Offset _p1 = Offset(0.0, 0.5);
  static const Offset _p2 = Offset(0.3, 0.8);
  static const Offset _p3 = Offset(0.75, 0.35);

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

  _FinishAnimationPainter(this.color, this.value, this.line1StartValue,
      this.line1EndValue, this.line2EndValue)
      : _arcStart = math.pi + math.pi * 2 * value * 2,
        _arcSweep = -value * math.pi * 2,
        _line1Start = _p1 - (_p1 - _p2) * line1StartValue,
        _line1End = _p1 - (_p1 - _p2) * line1EndValue,
        _line2End = _p2 - (_p2 - _p3) * line2EndValue;

  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
      ..color = color ?? Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    if (_line1Start != _line1End) {
      canvas.drawLine(_line1Start * side, _line1End * side, paint);//==============画对勾的上半部分的直线
    }
    if (_p2 != _line2End) {
      canvas.drawLine(_p2 * side, _line2End * side, paint);//==============画对勾的下半部分的直线
    }
    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);//==============画圆弧
  }

  @override
  bool shouldRepaint(_FinishAnimationPainter other) {
    return value != other.value;
  }
}

class _FinishAnimationState extends State<FinishAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,//==============动画控制器
        builder: (context, child) {
          return _buildBody();
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )
      ..forward()//==============开始
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {//==============动画结束，调用onCompleted.其实就是上面写的，弹窗消失
          widget.onCompleted();
        }
      });
  }

  Widget _buildBody() {
    return CustomPaint( //==============绘制 与 动画结合的地方
      painter: _FinishAnimationPainter(
//        widget.color,
      Colors.yellow,//==============这里也是可以自定义颜色的地方
        _controller.value,
        Tween(begin: 0.0, end: 0.5).transform(Interval(0.75, 1.0).transform(_controller.value)),//line1Start
        Interval(0.5, 0.75).transform(_controller.value),//line1End
        Interval(0.75, 1.0).transform(_controller.value),//line2End
      ),
    );
  }
}