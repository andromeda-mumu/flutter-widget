import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
/**
 * Created by wangjiao on 2020/3/11.
 * description:
 */

/**
* 创建文件
*
*/
void createFile() async{
  const filepath ='../res/test';
  var file = File(filepath);
  try{
    bool exists = await file.exists();
    if(!exists){
      await file.create();
    }
  }catch(e){
    debugPrint('=====mmc $e');
  }
}
/**
* 写文件
*
*/
void writeFile()async{
  const filepath ="../res/test";
  var file = File(filepath);
  await file.writeAsString('hello dart io');
  List<int> toBeWritten =[1,2,3];
  await file.writeAsBytes(toBeWritten);
}
/**
* 如果只为了写文件，可以使用openWrite打开一个IOSink
*
*/
void writeOnly () async{
   const filepath ="../res/test.txt";
   var file = File(filepath);
   IOSink sink;
   try{
     /** 默认的写文件会 覆盖 原有内容。如果需要追加，则使用append模式。 */
//     sink = file.openWrite(mode: FileMode.append);
     sink = file.openWrite();
     /** write的参数是 object。它会自动执行object.toString() 把转换后的string写入write */
     sink.write('hello dart');
     await sink.flush();//==============这一步，才是真正把数据写出去
   }catch(e){
     debugPrint('=====mmc $e');
   }finally{
     sink?.close();
   }
}

/**
* 读文件
*
*/
void readFile()async{
  const filepath ="../res/test.txt";
  var file = File(filepath);
  var msg = await file.readAsString();
  List<int> content = await file.readAsBytes();
  debugPrint('=====mmc $msg');
}
/** openRead
 *
 *  读取bytes的时候，使用的对象是list<int>，而一个int在dart里面有64位。因为dart一开始设计就是为了web,所以这里效率不太高
 * */
void readOnly() async{
  const filepath ="../res/test.txt";
  var file = File(filepath);
  try{
    Stream<List<int>> stream = file.openRead();
    var lines = stream
        .transform(utf8.decoder)//==============把内容用utf8解码
        .transform(LineSplitter());//==============每次返回一行
    await for(var line in lines){
      debugPrint('=====mmc $line');
    }
  }catch(e){
    debugPrint('=====mmc $e');
  }
}
