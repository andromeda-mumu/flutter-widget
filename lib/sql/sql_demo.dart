import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
/**
 * Created by wangjiao on 2020/3/12.
 * description:
 */

 void main(){
  /** 这一行不能少，不然报错*/
  WidgetsFlutterBinding.ensureInitialized(); 
    foo();
 }

class Todo{
  /** 数据表字段 */
   static const columnId='id';
   static const columnTitle="title";
   static const columnContent ="content";

   int id;
   String title;
   String content;
   /** 构造函数 id可选*/
   Todo(this.title,this.content,[this.id]);

   /** map转成 todo对象*/
   Todo.fromMap(Map<String,dynamic> map):id=map[columnId],title=map[columnTitle],content=map[columnContent];

   /** 对象转成map */
   Map<String,dynamic> toMap()=>{
     columnTitle:title,
     columnContent:content,
   };

   @override
  String toString() {
    return 'Todo{id=$id,title=$title,content=$content}';
  }
}

void foo()async{
  /** 数据表 名 */
  const table = 'Todo';
  /** 数据库 名*/
  var path = await getDatabasesPath()+'/demo.db';
  /** 创建数据库，并设置必要的参数 version 等*/
  var database = await openDatabase(
    path,
    version: 1,
    /** SQL 语句 打开数据库表*/
    onCreate: (db,version) async{
      /** 一直在这里被坑了，sql语句这样写不对！！多余的引号导致的 ,现在这3条语句都是正确的SQL */
      var sql = '''
         CREATE TABLE $table(
           ${Todo.columnId} INTEGER PRIMARY KEY,
           ${Todo.columnTitle} TEXT,
           ${Todo.columnContent} TEXT
         )
      ''';
//      var sql = "CREATE TABLE $table(${Todo.columnId} INTEGER PRIMARY KEY,${Todo.columnTitle} TEXT,${Todo.columnContent} TEXT)";
//      var sql = "CREATE TABLE Todo(id INTEGER PRIMARY KEY ,title TEXT, content TEXT)";
      /** 异步执行 SQL语句*/
      await db.execute(sql);
    }
  );
  /** 删除 表，为了每次运行结果一样，先清除数据*/
  await database.delete(table);
  /**  创建两个对象 */
  var todo1 = Todo('Flutter','Learn Flutter widgets');
  var todo2 = Todo('Flutter','Learn how to Io in Flutter');
  /** 对象转成map，插入数据库 */
  await database.insert(table, todo1.toMap());
  await database.insert(table, todo2.toMap());

  /** 查询数据库表 */
  List<Map> list = await database.query(table);

  /** 重新赋值，这样todo.id才不是0  */
  todo1=Todo.fromMap(list[0]);
  todo2=Todo.fromMap(list[1]);
  debugPrint('=====mmc query:todo1=$todo1');
  debugPrint('=====mmc query:todo2=$todo2');

  /** 修改content字段 */
  todo1.content +='Come on!';
  todo2.content +='I\'m tired';

  /** 使用事务 */
  await database.transaction((txn) async{
    /** 里面只能用txn,直接用database会导致死锁 */
    await txn.update(table, todo1.toMap(),where:'${Todo.columnId}=?',whereArgs:[todo1.id]);//============== ？ 占位符
    /** 注意，whereArgs的参数类型是list，不能写成todo1.id.toString. 这样就变成string与int比较，就取法匹配到最新的一行 */
    await txn.update(table, todo2.toMap(),where:'${Todo.columnId}=?',whereArgs: [todo2.id]);
  });
  /** 查询表数据 */
  list = await database.query(table);
  for(var map in list){
    /** 将map转成对象 */
     var todo = Todo.fromMap(map);
     debugPrint('=====mmc update:todo=$todo');
  }
  /** 关闭数据库 */
  await  database.close();

}