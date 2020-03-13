import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/6.
 * description:
 */
 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         home: new Scaffold(
           appBar: new AppBar(title: Text('组件与布局'),),
//           body :new Center(
//               child: new TextOne(),
//               child: new ImageOne(),
//              child: new ContainerOne(),
//           child: new FlexOne(),
//           child: new FlexTwo(),
//           child: new StackOne(),
//           )
         body: new FlexTwo(),
         ),
       );
   }
 }
 class TextOne extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
        Widget text = new Text(
         'hello flutter',
         textAlign: TextAlign.center,
         maxLines: 1,
         overflow: TextOverflow.ellipsis,//溢出
         style: TextStyle(
           fontSize: 30,
           color: Colors.yellow
         ),

       );
         return new Scaffold(
               appBar: AppBar(title: Text('text')),
               body:new Center(child: text)
           );
   }
 }

 /**
 * image缩放：
 *    fill          充满组件，会变形
  *   contain       不变形，会留白，处于中间
  *   cover         充满组件，不变形，会截取
  *   fitWidth      宽度充满，图片不变形，高度可能留白，可能截取
  *   gitHeight     高度充满，图片不变形，宽度可能留白，可能截取
  *   none          不变形，不截取。留白
  *   scaleDown     同上
  *
  *  缓存：imageCache 是ImageProvider默认使用的图片缓存。使用LRU算法，默认存储1000张图片。
  *         maximumSize控制缓存图片数量
  *         maximumSizeBytes控制缓存大小（默认10MB）
  *
  *  CDN优化：可以通过URL增加后缀的方式实现。默认没有
  *
  *  FadeInImage 渐入效果，因为加载图片需要时间.类似Android中的plageHolder
 */
 class ImageOne extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       Widget img = Image.network(
         'https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png',
         fit: BoxFit.contain,
         width: 150,
         height: 100,
       );
        return new Scaffold(
              appBar: AppBar(title: Text('image')),
              body: new Center(child: img,)
          );
   }
 }

 /**
 *    Decoration 是对container进行 装饰的描述。类似于android的shape.
  *   一般使用它的子类 BoxDecoration。这提供了对背景色， 边框，圆角，阴影，渐变等功能的定制。
  *   注意： BoxDecoration中的image设置背景图，绘制在color和gradient之上
  *          image需要DecorationImage类的实现。它与Image组件相似，可以复用Image组件的ImageProvider
 *
  *   BoxConstraints其实是对Container组件大小的描述。
  *
  *   match_parent ===》flutter是  double.infinity
 */
 class ContainerOne extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       Widget ct = new Container(
         alignment: Alignment.center,
         padding: const EdgeInsets.all(15),
         margin: const EdgeInsets.all(15),
         decoration: new BoxDecoration(//边框
             border: new Border.all(color: Colors.red,),
             image:const DecorationImage(
                 image: const NetworkImage('https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png'),
                 fit:BoxFit.fitWidth,
             ),
            borderRadius: const BorderRadius.only( //边框
              topLeft: const Radius.circular(3),
              topRight: const Radius.circular(6),
              bottomLeft: const Radius.circular(9),
              bottomRight: const Radius.circular(0),
            ),

         ),
         child: Text(''),
       );

       return new Scaffold(
             appBar: AppBar(title: Text('')),
             body:  new Center(child: ct)
         );
   }
 }

 /**
 *   单孩子继承：SingleCHildRenderObjectWidget  ，这些组件提供丰富的装饰能力 如container
 *   多孩子继承：MultiChildRenderObjectWidget , 提供丰富的布局能力，如flex,stack,flow 。但几乎没有装饰能力
  *
  *  row和colum的基类是flex.
  *  flex通过direction 设置了主轴方向main axis。垂直方向叫cross axis。
  *  flex布局是从main axis和cross axis 两个方向进行的。两个方向都居中，才是完全居中
 */
 class FlexOne extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       Widget flex=  new Flex(
         direction: Axis.horizontal,//==============类似android 的linerLayout vertical=horizontal
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           new Container(
             width: 40,
             height: 60,
             color: Colors.pink,
             child: const Center(
               child: const Text('left'),
             ),
           ),
           new Container(
             width: 80,
             height: 60,
             color: Colors.grey,
             child: const Center(
               child: const Text('middle'),
             ),
           ),
           new Container(
             width: 60,
             height: 60,
             color: Colors.yellow,
             child: const Center(
               child: const Text('right'),
             ),
           )
         ],
       );
        return new Scaffold(
              appBar: AppBar(title: Text('')),
              body: new Center(child: flex)
          );

   }
 }

 /** 权重 weight = flex  */
 class FlexTwo extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       Widget flex = new Flex(
         direction: Axis.horizontal,
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           new Flexible(
             flex:2,
             fit: FlexFit.loose,
             child: new Container(
               color: Colors.blue,
               height: 60,
               alignment: Alignment.center,
               child: const Text('left!',
                 textAlign: TextAlign.center,
                 style: TextStyle(color: Colors.black),
                 textDirection: TextDirection.ltr,
               ),
             ),
           ),
           new Flexible(
               flex: 1,
               fit: FlexFit.loose,
               child: new Container(
                 color: Colors.red,
                 height: 60,
                 alignment: Alignment.center,
                 child: const Text('right',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    textDirection: TextDirection.ltr,
                 ),

               )
           )
         ],
       );
        return new Scaffold(
              appBar: AppBar(title: Text('')),
              body: new Center(child:flex )
          );
   }
 }

 /**
 * Stack中的子widget分两种：
 *    positioned：
  *        是包裹在组件positioned中的组件
  *        可以通过positioned属性灵活定位
  *        类似于h5中的position定位 absoulute
  *   non-positioned
  *        没有包裹在positioned组件中
  *        需要通过父widget stack 的属性来控制布局
  *        一般用 alignment属性控制对齐方式
  *
 */

 class StackOne extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       Widget  stack = new Container(
         color: Colors.yellow,
         height: 150,
         width: 500,
         child: new Stack(children: <Widget>[
           new Container(
             color: Colors.blueAccent,
             height: 50,
             width: 100,
             alignment: Alignment.center,
             child: Text('unPositioned'),
           ),
           new Positioned(
             left:40,
             top:80,
             child: new Container(
               color: Colors.pink,
               height: 50,
               width: 95,
               alignment: Alignment.center,
               child: Text('Positioned'),
             ),
           )
         ],),
       );
        return new Scaffold(
              appBar: AppBar(title: Text('')),
              body: new Center(child: stack)
          );

   }
 }