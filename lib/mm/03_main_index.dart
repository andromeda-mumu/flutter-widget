import 'package:flutter/material.dart';

import '03_Card_demo.dart';
import '03_GridView_demo.dart';
import '03_listview_demo.dart';
import '03_more_container.dart';
import '03_stack_demo.dart';
/**
 * Created by wangjiao on 2020/3/5.
 * description: 主界面
 */

const String CONTAINER_DEMO_PAGE='/a';
void main(){
  runApp(new MaterialApp(
    home: new HomePage(),
    routes: {
      CONTAINER_DEMO_PAGE:(context)=>new MyContainer(),
      '/b':(BuildContext context)=>new MyGridView(),
      '/c':(BuildContext context)=>new MyListView(),
      '/d':(BuildContext context)=>new MyStack(),
      '/e':(BuildContext context)=>new MyCardWidget(),
    },
  ));
}

class HomePage extends StatefulWidget{
  State<StatefulWidget> createState()=>new _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
      GetGestureDetector(String routeName,String content){
          return new GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(routeName);
            },
            child: new Container(
              padding: EdgeInsets.all(20),
              child: new Center(child: new Text(content),),
            ),
          );
        }
     return new Scaffold(
       appBar: new AppBar(title: new Text('home'),),
       body:   new Column(children: <Widget>[
         GetGestureDetector(CONTAINER_DEMO_PAGE, 'Container demo 1'),
         GetGestureDetector('/b', 'Grid demo 1'),
         GetGestureDetector('/c', 'ListView demo 1'),
         GetGestureDetector('/d', 'Stack demo 1'),
         GetGestureDetector('/e', 'Card demo 1'),
       ],),
     );
  }
}