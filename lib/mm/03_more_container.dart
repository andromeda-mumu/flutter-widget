import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/5.
 * description: 第三关，各种widget
 */

 void main()=>runApp(new MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'hhh',
      home:new MyContainer()
    );
  }
}

/** container */
class MyContainer extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>new _MyContainerState();
}

class _MyContainerState extends State<MyContainer>{
  @override
  Widget build(BuildContext context) {
      Expanded imageExpanded(String img){
        return new Expanded(
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border.all(width:10,color: Colors.black38),
                borderRadius: const BorderRadius.all(const Radius.circular(8)),),
              margin: const EdgeInsets.all(4), 
              child: new Image.asset(img)
        ),);
      }

      var container = new Container(
        decoration: new BoxDecoration(color: Colors.black26),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                imageExpanded('images/a.png'),
                imageExpanded('images/b.png'),
              ],
            ),
            new Row(
              children: <Widget>[
                imageExpanded('images/c.png'),
                imageExpanded('images/d.png'),
              ],
            ),
            new Row(
              children: <Widget>[
                imageExpanded('images/haha.png'),
              ],
            ),
          ],
        ),
      );
      return new Scaffold(
        appBar: new AppBar(title:Text('container page demo')),
        /** 用scrollview包起来，不然会溢出。但是用expanded咋没用呢 */
        body: new SingleChildScrollView(child: new Center(
          child: container,
        ),)
      );
  }
}