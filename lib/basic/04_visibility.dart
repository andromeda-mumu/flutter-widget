import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/6.
 * description:
 */
 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{

   @override
   Widget build(BuildContext context) {
      const  isVisible = true;

       return new MaterialApp(
         title: 'chloe',
         home: new Scaffold(
           appBar: new AppBar(title: Text('显示与隐藏'),),
           body :new Center(
//               child: isVisible ? Text('hehe'):new Container(),//==============空widget占位，不显示
//           child: new OffstageOne(),
           child: new OpacityOne(),
           )
         ),
       );
   }
 }

 /**
 *    删除：将widget从renderTree中移除
  *   offstage: 这是一个widget,将offstage属性设置为true,那么Offstage以及他的child都不会被绘制在界面上
  *
 *    透明度：副作用是这个widget以及经过完整的layout & paint过程，成本高。同时设置透明度本身也要耗费一定的计算资源，造成二次浪费。变透明位置还在
 */

class OffstageOne extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    const  isVisible = false;
      return new Offstage(
        offstage: isVisible,//==============为false显示，true不显示
        child: Text('嘻嘻'),
      );
  }
}

class OpacityOne extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    const  isVisible = true;
      return new AnimatedOpacity(
          opacity: isVisible ? 1.0:0.0,
          child: Text('嘻嘻嘻'),
          duration: Duration(microseconds: 10)
      );
  }
}