import 'dart:convert';

import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/11.
 * description:
 */

void main(){
  /** ======================encode把对象转成json================== */
  var point = Point(2,12,'some point');
  /** 使用 encode将对象转成json */
  var pointJson = json.encode(point);//==============这里encode内部会调用point的tojson方法
  debugPrint('=====mmc pointJson=$pointJson');
  
  /** encode对于list map都是支持的 */
  var pointArr= [point,point];
  var pointArrJson = json.encode(pointArr);
  debugPrint('=====mmc pointArrJson=$pointArrJson');

  /** =====================decode把json转成对象======================== */
  var decoded = json.decode(pointJson);
  debugPrint('=====mmc decoded.runtimeType=${decoded.runtimeType}');//==============_InternalLinkedHashMap<String, dynamic>
  var point2 = Point.fromJson(decoded);//============== 将map里的值拿出来，转成对象
  debugPrint('=====mmc point2=$point2'+'=====point2.runtimeType=${point2.runtimeType}');

  decoded = json.decode(pointArrJson);
  debugPrint('=====mmc decoded.runtimeType=${decoded.runtimeType}');//==============List<dynamic>
  var pointArr2 = <Point>[];
  for(var map in decoded){
    pointArr2.add(Point.fromJson(map));
  }
  debugPrint('=====mmc pointArr2=$pointArr2'+'=====pointArr2.runtimeType=${pointArr2.runtimeType}');

}

/**
*  限定toJson方法的原型，是因为json.encode 只支持 Map,list,String,int等内置对象。当遇到不认识的类型，如果没有给他设置参数toEncodable,
 * 就会去调用对象的toJson方法。（所以方法原型不能变）
*
*/
 class Point{
  int x;
  int y;
  String desc;
  Point(this.x,this.y,this.desc);

  /**
  * 注意：这个方法只有一个语句，这个语句定义了一个map
  * 使用这种语法，dart会自动把这个map当做方法的返回值
  */
  Map<String,dynamic> toJson()=>{
    'x':x,
    'y':y,
    'desc':desc
  };

  /**
  * 把Json转换成对象
  *
  */
   Point.fromJson(Map<String,dynamic> map):x =map['x'],y=map['y'],desc=map['desc'];

  @override
  String toString() {
    return 'Point{x=$x,y=$y,desc=$desc}';
  }

 }

