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
        home:new MyListView()
      );
  }
}

class MyListView extends StatefulWidget{
   State<StatefulWidget> createState()=>new _MyListView();
}
class _MyListView extends State<MyListView>{
  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[];
    for (int i = 0; i<30; i++) {
      list.add(new ListTile(
        title: new Text('title$i',style: _itemTextStyle,),
        subtitle: new Text('A'),
        leading: i % 3==0 ? new Icon(Icons.theaters,color: Colors.blue,)
            :new Icon(Icons.restaurant,color:Colors.blue),
      ));
    }
     return new Scaffold(
           appBar: AppBar(title: Text('listview demo')),
           body:new ListView(children: list)
       );
  }

  TextStyle _itemTextStyle = new TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14
  );
}