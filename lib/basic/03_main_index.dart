import 'package:flutter/material.dart';

import '02_list_favorite.dart';
import '03_Card_demo.dart';
import '03_GridView_demo.dart';
import '03_listview_demo.dart';
import '03_more_container.dart';
import '03_stack_demo.dart';
import '03_first_demo.dart' as first;
import '04_widget.dart';
/**
 * Created by wangjiao on 2020/3/5.
 * description: 主界面
 */

const String CONTAINER_DEMO_PAGE='/a';
void main(){
  runApp(new BasicWidget());
}
class BasicWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return  new MaterialApp(
      home: new HomePage(),
      routes: {
        '/basic':(BuildContext context)=>new RandomWords(),
        '/basica':(BuildContext context)=>new MyContainer(),
        '/basica2':(BuildContext context)=>new TextOne(),
        '/basica3':(BuildContext context)=>new ImageOne(),
        '/basica4':(BuildContext context)=>new ContainerOne(),
        '/basica5':(BuildContext context)=>new FlexOne(),
        '/basica6':(BuildContext context)=>new FlexTwo(),

        '/basicb':(BuildContext context)=>new MyGridView(),
        '/basicc':(BuildContext context)=>new MyListView(),
        '/basicd':(BuildContext context)=>new MyStack(),
        '/basicd2':(BuildContext context)=>new StackOne(),
        '/basice':(BuildContext context)=>new MyCardWidget(),
        '/basicf':(BuildContext context)=>new first.MyApp(),
      },
    );
  }
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
//            child: new Container(
//              padding: EdgeInsets.all(20),
//              child: new Center(child: new Text(content),),
//            ),
          child : new Card(
            child: new Padding(padding: EdgeInsets.all(10),child: Text(content),),
            elevation: 3.0,
          )
          );
        }
     return new Scaffold(
       appBar: new AppBar(title: new Text('home'),),
       body:   new Column(children: <Widget>[
         GetGestureDetector('/basic', '列表收藏'),
         GetGestureDetector('/basica', 'Container'),
         GetGestureDetector('/basica2', 'Text'),
         GetGestureDetector('/basica3', 'image'),
         GetGestureDetector('/basica4', 'container'),
         GetGestureDetector('/basica5', 'flex'),
         GetGestureDetector('/basica6', 'flex_two'),

         GetGestureDetector('/basicb', 'gridview '),
         GetGestureDetector('/basicc', 'ListView'),
         GetGestureDetector('/basicd', 'Stack'),
         GetGestureDetector('/basicd2', '定位布局'),
         GetGestureDetector('/basice', 'Card'),
         GetGestureDetector('/basicf', '第一个UI小实战'),
       ],),
     );
  }
}