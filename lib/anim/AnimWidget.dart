import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/10.
 * description: 动画控件
 */

 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         home: new Scaffold(
           appBar: new AppBar(title: Text('MyApp'),),
           body :AnimationWidget()
         ),
       );
   }
 }
class AnimationWidget extends StatefulWidget{
  State<StatefulWidget> createState()=>new _AnimationWidgetState();
}
class _AnimationWidgetState extends State<AnimationWidget> with SingleTickerProviderStateMixin{
   AnimationController controller;
   CurvedAnimation curve;
   @override
  void initState() {
    super.initState();
    controller = AnimationController(//==============线性的动画
      duration: Duration(milliseconds: 5000),
      vsync: this
    );
    curve = CurvedAnimation(//==============非线性
      parent: controller,
      curve: Curves.easeInOut
    );
    controller.forward();//==============开始动画
  }
  @override
  Widget build(BuildContext context) {
     /** 单个动画 */
//     return ScaleTransition(
//       child: FlutterLogo(size: 200,),
////       scale: controller,
//     scale: curve,
//     );
  var scaled = ScaleTransition(
    child: FlutterLogo(size: 200),
    scale: curve,
  );
     return FadeTransition(
       child: scaled, //==============动画也是widget,也可以当做child
       opacity: curve,
     );
  }
}