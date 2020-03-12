import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
/**
 * Created by wangjiao on 2020/3/12.
 * description:
 */
 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         home: new HomePage()
       );
   }
 }

class HomePage extends StatefulWidget{
  State<StatefulWidget> createState()=>new _HomePageState();
}
class _HomePageState extends State<HomePage>{
   List data;
   @override
  void initState() {
    super.initState();
    _pullNet();//==============网络请求数据
  }
  void _pullNet() async{
     await http.get('http://www.wanandroid.com/project/list/1/json?cid=1')
         .then((http.Response response) {
       /** 服务器返回json字符串 .这里吧json 转成对象 */
       var dataToJson= json.decode(response.body);
       /** 对象就好直接获得某字段的数据 */
       dataToJson = dataToJson['data']['datas'];
       debugPrint('=====mmc= dataToJson :${dataToJson}');

       setState(() {
         /** 刷新widget */
          data= dataToJson;
       });
     });
  }

  @override
  Widget build(BuildContext context) {
         return new Scaffold(
               body:new ListView(
//                 children: <Widget>[
//                   _getItem2(),
//                   _getItem2()
//                 ],
               children:data!=null? _getItem():_loading(),
               )
           );
  }
  List<Widget> _loading(){
     return <Widget>[
       new Container(
         height: 300.0,
         child: new Center(
           child: new Column(
             children: <Widget>[
               new CircularProgressIndicator(strokeWidth: 1.0,),
               new Text('正在加载'),
             ],
             mainAxisAlignment: MainAxisAlignment.center,
           ),
         ),
       )
     ];
  }
  
  /** 遍历map,获得多个list 的item.组合成list */
  List<Widget> _getItem(){
     return data.map((item){
       return new Card(
         child: new Padding(
           padding: const EdgeInsets.all(10.0),
           child: _getRowWidget(item),
         ),
         elevation: 3.0,
         margin: const EdgeInsets.all(10.0),
       );
     }).toList();
  }

  /** 这才是真正的 itemview  */
  Widget _getRowWidget(item){
    return new Row(
      children: <Widget>[
        new Flexible(
            flex: 1,
            fit: FlexFit.tight,//==============权重1 。除掉右边的图片，沾满所有空间
            child: new Stack(
              children: <Widget>[
                 new Column(
                   children: <Widget>[
                     new Text("${item['title']}".trim(),
                       style: TextStyle(color: Colors.black,fontSize: 20.0),
                       textAlign: TextAlign.left,
                     ),
                     new Text("${item['desc']}",maxLines: 3,)
                   ],
                 )
              ],
            )
        ),

        new ClipRect(
          child: new FadeInImage.assetNetwork(
              placeholder: "images/shop_normal.png",
              image: "${item['envelopePic']}",
            width: 50.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }

  Widget _getItem2(){
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: _getRowWidget2(),
      ),
      elevation: 3.0,
      margin: const EdgeInsets.all(10.0),
    );
  }

  Widget _getRowWidget2() {
    return new Row(
      children: <Widget>[
        new Flexible(
            flex: 1,
            fit: FlexFit.tight,//==============权重=1
            child: new Stack(
              children: <Widget>[
                new Text(
                    'title'.trim(),
                    style: new TextStyle(color: Colors.black,fontSize: 20.0),
                    textAlign : TextAlign.left,
                ),
                new Container(
                child:   new Text('desc',maxLines: 3,textAlign: TextAlign.end,),
                  margin: const EdgeInsets.only(top: 20.0),
                )

              ],
            )
        ),//flexible

        new ClipRect(
          child: new FadeInImage.assetNetwork(
              placeholder:"images/shop_normal.png",
              image: "images/shop_normal.png",
            width: 50.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }
}