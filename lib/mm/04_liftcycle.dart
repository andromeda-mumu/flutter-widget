import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/6.
 * description:
 */
 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         home: new Scaffold(
           appBar: new AppBar(title: Text(''),),
           body :new Center(child: Text(''),)
         ),
       );
   }
 }

 /**
 * widget是immutable的。发生变化的时候需要重建，所以谈不上状态
 * StatefulWidget 中的状态通过State类实现的。
  *
  * state的生命周期：
  *       initState                   插入渲染树的时候调用，只调用一次
  *
  *       didChangeDependencies       state依赖的对象发生改变的时候
  *       didUpdateWidget             组件状态发生改变的时候，可能调用多次
  *       build                       构建widget的时候调用
  *
  *       deactivate                  移除渲染树的时候调用
  *       dispose                     组件即将销毁时调用
  *
  * 其中  didChangeDependencies 有两种情况会被调用：
  *         1.创建的时候在InitState 之后被调用
  *         2.在依赖的InheritedWidget 发送变化的时候回调用
  *
  *  正常流程退出时，一般会先deactivite后执行dispose。。不过有时也会出现不钓鱼dispose的情况
  *
  *  这里状态改变指：
  *         1.通过setState内容改变
  *         2.父节点的state状态改变，导致孩子节点同步变化
 */

 /**
 * app的生命周期： 通过widgetsBindingOberver的didChangeAppLifecycleState来获取
 *    resumed       可见 且 能响应用户输入
  *   inactive      处在不活动状态，无法处理用户响应
  *   paused        不可见，不响应用户输入，但在后台继续活动
  *
  * 实际场景例子：
  *       在不考虑suspending的情况下，后台切入前台生命周期变化：AppLifecycleState.inactivt------>AppLiftcycleState.resumed
  *       前台压入后台：AppLifecycleState.inactivt------>AppLiftcycleState.paused
 */

