import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/5.
 * description:
 * Gridview 可以放2维列表
 * Gridview提供2个预装配好的列表，也可以自己 自定义列表
 * gridview支持滑动
 *
 * GridView.count 指定列数
 * GrdiView.extent   子项的最大像素宽度
 */


void main()=>runApp(new MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: '哈哈哈',
        home:new MyGridView()
      );
  }
}
/**
 * Gridview 可以放2维列表
 * Gridview提供2个预装配好的列表，也可以自己 自定义列表
 * gridview支持滑动
 *
 * GridView.count 指定列数
 * GrdiView.extent   子项的最大像素宽度
*/
class MyGridView extends StatefulWidget{
  State<StatefulWidget> createState()=>new _MyGridView();
}
class _MyGridView extends State<MyGridView>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Gridview ')),
      body:buildGrid()
    );
  }

  List<Container> _buildGridTileList(int count){
    return new List<Container>.generate(count, (index) =>
        new Container(child: new Image.asset('images/${(index+1)%4}.png'))
    );
  }

  Widget buildGrid(){
//    return new GridView.extent(
//        maxCrossAxisExtent: 150,//==============这里决定几列
//        padding: const EdgeInsets.all(4),
//        mainAxisSpacing: 4,
//        crossAxisSpacing: 4,
//        children:_buildGridTileList(30),
//    );
  return new GridView.count(
      crossAxisCount: 2,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    padding: const EdgeInsets.all(4),
    childAspectRatio: 2,/*这个代表 平均分配2列*/
    children:_buildGridTileList(40)
  );
  }

}
