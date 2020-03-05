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
        title: 'chloe',
        home:new MyCardWidget()
      );
  }
}

/**
* card是material组件库，可以包含一些数据，用listview来组装
* card只有一个 子widget,可以是column  row list grid 或其他组合widget
*
*    默认情况下，card尺寸是0像素。可以用sizedBox来指定card的尺寸
*    elevation 可以修改阴影效果
 *
 *    不支持滚动
*/
class MyCardWidget extends StatefulWidget{
  State<StatefulWidget> createState()=>new _MyCardState();
}
class _MyCardState extends State<MyCardWidget>{
  @override
  Widget build(BuildContext context) {
      List<Widget> list = <Widget>[];
      for(int i=0;i<30;i++){
          list.add(new Card(
              child: new Column(
                children: <Widget>[
                  new Image.asset('images/${(i+1)%3}.png'),
                  new ListTile(
                    title: new Text('title$i',style: _itemTextStyle,),
                    subtitle: new Text('A'),
                    leading: i%3==0?new Icon(Icons.theaters,color: Colors.blue,):new Icon(Icons.restaurant,color: Colors.blue,)
                  ),
                ],
          ),));
      }
       return new Scaffold(
             appBar: AppBar(title: Text('Card view')),
             body:new ListView(children: list)
         );
  }
  TextStyle _itemTextStyle = new TextStyle(fontWeight: FontWeight.w500,fontSize: 14);
}