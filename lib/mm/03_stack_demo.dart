import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/5.
 * description:
 */

void main()=>runApp(new MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new MaterialApp(
        title: 'hhh',
        home:new MyStack()
      );
  }
}

class MyStack extends StatefulWidget{
   State<StatefulWidget> createState()=>new _MyStack();
}

class _MyStack extends State<MyStack>{
  @override
  Widget build(BuildContext context) {
    var stack = new Stack(
      alignment: const Alignment(0.6,0.6),
      children: <Widget>[
        /** 圆形图 */
        new CircleAvatar(
          backgroundImage: new AssetImage('images/1.png'),
          radius: 100,
        ),
        new Container(
            decoration: new BoxDecoration(color: Colors.black45),
            child: new Text('android avatar',style: new TextStyle(color: Colors.white70),),
        ),
        new Container(
          decoration: new BoxDecoration(color: Colors.transparent),
          padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
          child: new CircleAvatar(
                 backgroundImage: new AssetImage('images/b.png'),
                 backgroundColor: Colors.transparent,
                  radius: 20,
               ),
          ),
      ],
    );
     return new Scaffold(
           appBar: AppBar(title: Text('Grid')),
           body:stack
       );
  }
}