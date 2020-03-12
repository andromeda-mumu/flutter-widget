import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
/**
 * Created by wangjiao on 2020/3/12.
 * description:
 */

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  getMessage();
}

Future<String> getMessage() async{
  try{
    final response = await http.get('https://api.isoyu.com/api/Zhihu/zhihu_daily');
    if(response.statusCode==200){
      debugPrint('=====mmc= 请求成功');
      return response.body;
    }
  }catch(e){
    debugPrint('=====mmc getMessage:$e');
  }
}