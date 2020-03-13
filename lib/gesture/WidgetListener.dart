import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/10.
 * description: 手势处理
 */
  void main()=>runApp(new MyApp());
  class MyApp extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
        return new MaterialApp(
          title: 'chloe',
          home: new Scaffold(
            appBar: new AppBar(title: Text('MyApp'),),
            body :new Center(
//              child: new TextWidget(),
//                child: new TextWidget2()
            child: new ListenerText(),
            )
          ),
        );
    }
  }
class TextWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return RaisedButton(
        child:Text('click'),
        onPressed: ()=>debugPrint('clicked')
      );
  }
}

/**
* 不像button,大部分控件并没有手势监听函数，因此为了监听这些控件上的手势时间，需要使用另一个控件---GestureDetector
*
 * onTapDown      按下
 * onTap          点击动作
 * onTapUp        抬起
 * onTapCancel    前面触发了onTapDown,但并没有完成一个onTap动作
 * onDoubleTap    双击
 * onLongPress    长按
 * onScaleState  onScaaleUpdate  onScaleEnd    缩放
 * onVerticalDragDown  onVerticalDragStart  onVerticalDragUpdate  onVerticalDragEnd  onVerticalDragCancel  onVerticalDragUpdate  在竖直方向上方向上移动
 * onHorizontalDragDown  onHorizontalDragStart  onHorizontalDragUpdate  onHorizontalDragEnd   onHorizontal FragCancel  onHorizontalUpdate  在水平方向上移动
 * onPanDown  onPanStart onPanUpdate  onPanEnd onPanCancel  拖拽 （水平 竖直方向移动）
 *
 * 如果同时设置 onVerticalXXX 和 onHorizontalXXX ,只有一个生效。
 * onVerticalXXX/onHrozontalXXX  与 onPanXXX 不能同时设置
 *
 * 水波纹效果  InkWell
*/
class TextWidget2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return GestureDetector( /** 只要包裹上 GestureDetector 这样任何widget都可以有事件了*/
        child: Text('text'),
        onTap: ()=>debugPrint('click'),
      );
  }
}

class ListenerText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Listener(
        child: Text('text'),
        onPointerDown:(event)=>print('onPonterDown') ,
        onPointerUp:(event)=>print('onPointerUp'),
        onPointerMove:(event)=>print('onPointerMove'),
        onPointerCancel:(event)=>print('onPointerCancel')
      );
  }
}
