import 'package:flutter/material.dart';

import 'anim/CustomAnim.dart';
import 'anim/FinishAnimation.dart';
import 'anim/Paintloading.dart';
import 'basic/02_list_favorite.dart';
import 'basic/03_more_container.dart';
import 'basic/03_main_index.dart' as basicmain;
import 'echo/MessageListIndex.dart';
import 'gesture/Page2Page.dart';
import 'gesture/WidgetListener.dart' as gesture;
import 'anim/Tween_cruve_demo.dart' as twenn_cruve;
import 'io/show_app.dart' as shop;
import 'basic/03_first_demo.dart' as first;
import 'listview_demo/01_loadmore.dart';
/**
 * Created by wangjiao on 2020/3/13.
 * description:
 */
void main(){
  runApp(new MaterialApp(
    home: IndexPage(),
    routes: {
      '/a':(BuildContext context)=>new basicmain.BasicWidget(),
      '/a2':(BuildContext context)=>new FirstPage(),
      '/a3':(BuildContext context)=>new MyHomePage(),
      '/b':(BuildContext context)=>new gesture.TextWidget(),
      '/c':(BuildContext context)=>new AnimPaintWidget(),
      '/c2':(BuildContext context)=>new twenn_cruve.AnimPaintWidget(),
      '/c3':(BuildContext context)=>new CustomAnimWidget(),
      '/c4':(BuildContext context)=>new FinishWidget(),
      '/demo1':(BuildContext context)=>new shop.HomePage(),
      '/demo2':(BuildContext context)=>new MessageIndex(),
      '/demo3':(BuildContext context)=>new RandomWords(),
      '/basicf':(BuildContext context)=>new first.MyApp(),

    },
  ));
}

class IndexPage extends StatefulWidget{
  State<StatefulWidget> createState()=>new _IndexPageState();
}
class _IndexPageState extends State<IndexPage>{
  @override
  Widget build(BuildContext context) {
    List<Widget> list =[];
    list.add(getItem("/a","基础组件"));
    list.add(getItem("/a2","页面跳转"));
    list.add(getItem("/a3","listview加载更多动画"));
    list.add(getItem('/b', "手势"));
    list.add(getItem('/c', "绘制圆圈"));
    list.add(getItem('/c2', "动画loading"));
    list.add(getItem('/c3', "小球曲线运动"));
    list.add(getItem('/c4', "支付宝完成对勾动画"));
    list.add(getItem('/demo1', "网络+json互转"));
    list.add(getItem('/demo2', "echo客户端（全面）"));
    list.add(getItem('/demo3', "列表收藏"));
    list.add(getItem('/basicf', "测试"));

    //==============没有widget，不好加入.可以优化
//    list.add(getItem('/d', "json与对象互转"));
//    list.add(getItem('/e', "数据库"));

     return new Scaffold(
           appBar: AppBar(title: Text('主页面')),
           body:ListView(children: list,)
       );
  }

  Widget getItem(String page,String name){
    return new GestureDetector(
      child: new Card(
        child: new Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(name),
        ),
        elevation: 3.0,
        margin: EdgeInsets.all(8.0),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(page);
      },
    );

  }
}