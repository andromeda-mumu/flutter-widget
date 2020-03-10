import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/10.
 * description: 页面跳转
 */

 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         home: new FirstPage()
       );
   }
 }

 class FirstPage extends StatefulWidget{
   State<StatefulWidget> createState()=>new _FirstPageState();
 }
 class _FirstPageState extends State<FirstPage>{
   @override
   Widget build(BuildContext context) {
          return new Scaffold(
                appBar: AppBar(title: Text('Navigation demo')),
                body:Center(
                  child: RaisedButton(
                     child: Text('first page'),
                      onPressed: () async{
                       var msg = await Navigator.push(context, MaterialPageRoute(builder: (_)=>SecondPage()));
                       debugPrint('=====mmc msg=$msg');
                      }),
                )
            );
   }
 }

 class SecondPage extends StatefulWidget{
   State<StatefulWidget> createState()=>new _SecondPageState();
 }
 class _SecondPageState extends State<SecondPage>{
   @override
   Widget build(BuildContext context) {
          return new Scaffold(
                appBar: AppBar(title: Text('Navifation demo')),
                body:Center(
                  child: RaisedButton(
                      child: Text('Second page'),
                      onPressed: (){
                    Navigator.pop(context,"我是secode页面传递给first页面数据");
                  }),
                )
            );
   }
 }