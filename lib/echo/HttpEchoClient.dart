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
    debugPrint('=====mmc= send:$msg');
    /** 执行一个post请求，body参数是一个dynamic ,是任意类型。这里msg是string，所以post会自动设置Content-type=text/plain */
     final response = await http.post(host+'/echo',body: msg);
    debugPrint('=====mmc= responseStatus${response.statusCode}');
     if(response.statusCode ==200){
       debugPrint('=====mmc= 请求成功');
       Map<String,dynamic> msgJson = json.decode(response.body);
       debugPrint('=====mmc= msfJson$msgJson');
       /** json转对象 */
       var message = Message.fromJson(msgJson);
       debugPrint('=====mmc= message$message');
       return message;
     }else{
       return null;
     }

  }

}