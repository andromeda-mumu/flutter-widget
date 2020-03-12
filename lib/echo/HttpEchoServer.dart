import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'Message.dart';
/**
 * Created by wangjiao on 2020/3/12.
 * description: 服务器架构
 */
class HttpEchoServer{
  static const GET ='GET';
  static const POST ='POST';

   List<Message> messages =[];
  final int port;
  HttpServer httpServer;
  /** 在dart里，函数也是class object ，所以可以放在map里 */
  Map<String,void Function(HttpRequest)> routes;

  HttpEchoServer(this.port){
    _initRoutes();
  }
  void _initRoutes(){
    routes ={
      /** 只支持path为这两个的请求 */
      '/history':_history,
      '/echo':_echo,
    };
  }

  /** 返回一个future,这样客户端可以在start后，做一些事*/
  Future start() async{
    /** 创建一个httpServer*/
    httpServer = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    /** 监听请求 */
    return httpServer.listen((request) {
      final path = request.uri.path;
      /** route是否 支持的*/
      final handler = routes[path];
      debugPrint('=====mmc= handler$handler');
      if(handler!=null){
        handler(request);
      }else{
        request.response.statusCode = HttpStatus.notFound;
        request.response.close();
      }
    });
  }

  void handle(HttpRequest request){

  }
  /** 不支持的请求 */
  _unsupportedMethod(HttpRequest request){
    request.response.statusCode = HttpStatus.methodNotAllowed;
    request.response.close();
  }
  void _history(HttpRequest){

  }


  void _echo(HttpRequest request)async{
     if(request.method!=POST){
       _unsupportedMethod(request);
       return;
     }
     /** 获取从客户端post请求的 body参数 */
     /** 异常 The argument type 'Utf8Decoder' can't be assigned to the parameter type 'StreamTransformer'. */
     String body = await utf8.decoder.bind(request).join();
//     String body = await request.transform(utf8.decoder).join();//======类型不匹配导致错误
     if(body!=null){
       debugPrint('=====mmc= body$body');
       /** 利用body创建 msg */
       var message = Message.create(body);
       messages.add(message);
       /** 返回客户端响应 */
       request.response.statusCode = HttpStatus.ok;
       /** 对象转成JSON。第二个参数时toEncodable。当对象不是dart内置对象时，会调用它对对象进行序列化。这里没有第二个参数，则encode方法会调用对象的toJson方法。 */
       var data = json.encode(message);
       /** 写入相应体 */
       request.response.write(data);
     }else{
       request.response.statusCode = HttpStatus.badRequest;
     }
     request.response.close();
  }
  void close() async{
    var server = httpServer;
    httpServer = null;
    await server?.close();
  }

}