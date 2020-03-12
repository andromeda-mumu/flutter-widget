import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'Message.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
/**
 * Created by wangjiao on 2020/3/12.
 * description: 服务器架构
 */
class HttpEchoServer{
  static const GET ='GET';
  static const POST ='POST';

  String historyFilepath;


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
    historyFilepath = await _historyPath();
    /** 在启动服务器前，先加载历史数据 */
    await _loadMessages();

    /** 创建一个httpServer*/
    httpServer = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    /** 监听请求 */
    return httpServer.listen((request) {
      final path = request.uri.path;
      /** route是否 支持的*/
      final handler = routes[path];
//      debugPrint('=====mmc= url : $handler');
      if(handler!=null){
        handler(request);//==============这个调用方法 一劳永逸。_echo() 或者 _history()
      }else{
        request.response.statusCode = HttpStatus.notFound;
        request.response.close();
      }
    });
  }

  /** 加载本地 历史数据 */
  Future _loadMessages()async{
    try{
      var file = File(historyFilepath);
      debugPrint('=====mmc= historypath : $historyFilepath');
      var exits = await file.exists();
      debugPrint('=====mmc= server 文件是否存在 :$exits');
      if(!exits)return ;
      var content =await file.readAsString();
      debugPrint('=====mmc= server content : $content');
      var list = json.decode(content);
      for(var msg in list){
        var message = Message.fromJson(msg);
        messages.add(message);
      }
    }catch(e){
      debugPrint('=====mmc= _loadMessages: $e');
    }
  }

  /** 不支持的请求 */
  _unsupportedMethod(HttpRequest request){
    request.response.statusCode = HttpStatus.methodNotAllowed;
    request.response.close();
  }
  void _history(HttpRequest request){
    if(request.method!=GET){
        _unsupportedMethod(request);
      return;
    }
    String historyData = json.encode(messages);
    request.response.write(historyData);
    request.response.close();

  }
  Future<String> _historyPath()async{
     final directory = await path_provider.getApplicationDocumentsDirectory();
     return directory.path+'/messages.json';
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
       debugPrint('=====mmc= _echo body $body');
       /** 利用body创建 msg */
       var message = Message.create(body);
       messages.add(message);
       /** 返回客户端响应 */
       request.response.statusCode = HttpStatus.ok;
       /** 对象转成JSON。第二个参数时toEncodable。当对象不是dart内置对象时，会调用它对对象进行序列化。这里没有第二个参数，则encode方法会调用对象的toJson方法。 */
       var data = json.encode(message);
       /** 写入相应体 */
       request.response.write(data);
       _storeMessages();//==============保存历史数据
     }else{
       request.response.statusCode = HttpStatus.badRequest;
     }
     request.response.close();
  }

  Future<bool> _storeMessages() async{
    try{
      /** json.encode 支持list map */
      final data = json.encode(messages);
      debugPrint('=====mmc= client 数据持久化 :$data');
      final file = File(historyFilepath);
      debugPrint('=====mmc= path $historyFilepath');
      final exists = await file.exists();
      debugPrint('=====mmc= client 文件是否存在: ${exists as bool}');
      if(!(exists as bool)){
        await file.create();
      }
      file.writeAsString(data);
      return true;
    }catch(e){
      debugPrint('=====mmc= _storeMessage :$e');
    }
  }
  void close() async{
    var server = httpServer;
    httpServer = null;
    await server?.close();
  }

}