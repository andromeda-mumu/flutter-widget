import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Message.dart';
/**
 * Created by wangjiao on 2020/3/12.
 * description:
 */
class HttpEchoClient{
  final int port;
  final String host;

  HttpEchoClient(this.port):host='http://localhost:$port';

  Future<Message> send(String msg)async{
    /** 执行一个post请求，body参数是一个dynamic ,是任意类型。这里msg是string，所以post会自动设置Content-type=text/plain */
     final response = await http.post(host+'/echo',body: msg);
    debugPrint('=====mmc= send Status${response.statusCode}');
     if(response.statusCode ==200){
       debugPrint('=====mmc= send 请求成功');
       Map<String,dynamic> msgJson = json.decode(response.body);
       /** json转对象 */
       var message = Message.fromJson(msgJson);
       return message;
     }else{
       return null;
     }

  }


  Future<List<Message>> getHistory() async{
    try{
      final response = await http.get(host+'/history');
      debugPrint('=====mmc= getHistory status ${response.statusCode}');
      if(response.statusCode==200){
        debugPrint('=====mmc= getHistory body ${response.body}');
        return _decodeHistory(response.body);
      }
    }catch(e){
      debugPrint('=====mmc= getHistory: $e');
    }
    return null;
  }
  List<Message> _decodeHistory(String response){
    var messages = json.decode(response);
    debugPrint('=====mmc= decode history :$messages');
    var list = <Message>[];
    for(var msgJson in messages){
      list.add(Message.fromJson(msgJson));
    }
    return list;
  }

}