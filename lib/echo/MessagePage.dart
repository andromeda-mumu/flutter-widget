import 'package:flutter/material.dart';

import 'Message.dart';
/**
 * Created by wangjiao on 2020/3/10.
 * description: 输入框页面
 */

 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'Flutter UX demo',
         home: AddMessageScreen()
       );
   }
 }
 class MessageForm extends StatefulWidget{
   State<StatefulWidget> createState()=>new _MessageFormState();
 }
 class _MessageFormState extends State<MessageForm>{
   final editController = TextEditingController();

   @override
  void initState() {
  }
   @override
   void dispose(){
     super.dispose();
     editController.dispose();
   }
   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: EdgeInsets.all(16),
       child: Row(
         children: <Widget>[

           Expanded(//==============输入框沾满 除按钮外的 所有空间
             child: Container(
               margin: EdgeInsets.only(right: 8),
               child: TextField(
                 decoration: InputDecoration(
                   hintText: 'Input message',
                   contentPadding: EdgeInsets.all(0),
                 ),
                 style: TextStyle(
                   fontSize: 22,
                   color: Colors.black54,
                 ),
                 controller: editController,
                 autofocus: true,
               ),//TextField
             ),
           ),

           InkWell(//==============水波纹的按钮
             onTap:(){
               debugPrint('=====mmc send:${editController.text}');
               final msg = Message(
                 editController.text,
                 DateTime.now().millisecondsSinceEpoch
               );
               Navigator.pop(context,msg);
              },
     onDoubleTap: ()=>debugPrint('=====mmc double tapped'),
     onLongPress: ()=>debugPrint('=====mmc long press'),
     child: Container(
     padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
     decoration: BoxDecoration(
     color: Colors.black12,
     borderRadius: BorderRadius.circular(5)
     ),
     child: Text('send'),
     ),
     )//InkWell

     ],
     ),
     );
     }
   }
   class AddMessageScreen extends StatelessWidget{
     @override
     Widget build(BuildContext context) {
          return new Scaffold(
                appBar: AppBar(title: Text('Add Message')),
                body:MessageForm()
            );
     }
   }