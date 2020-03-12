import 'package:flutter/material.dart';

import 'HttpEchoClient.dart';
import 'HttpEchoServer.dart';
import 'Message.dart';
import 'MessagePage.dart';
/**
 * Created by wangjiao on 2020/3/10.
 * description: 消息列表
 */
  void main()=>runApp(new MyApp());
  class MyApp extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
        return new MaterialApp(
          title: 'chloe',
          home: MessageIndex()//首页
        );
    }
  }

  class MessageIndex extends StatelessWidget{
    
    /**
    * 引用GlobalKey的原因是，MessageIndex需要把AddMessageScreen返回的数据 放到 _MessageListState中。但是却无法从messageList中拿到这个State
    * 所以把这个key设置给MessageList后，就可以通过这个key拿到对应的state
     *
     * 数据变化--》UI变化--》只有state才能变化
    */
    final messageListKey = GlobalKey<_MessageListState>(debugLabel: 'messageListKey');//==============存储数据
    @override
    Widget build(BuildContext context) {
         return new Scaffold(
               appBar: AppBar(title: Text('Echo Client')),
               body: MessageList(key: messageListKey),//==============将数据给到MessageList里
               floatingActionButton: FloatingActionButton(
                   onPressed: () async {
                    final result =  Navigator.push(context, MaterialPageRoute(builder: (_)=>AddMessageScreen()));//==============得到B页面发送的数据
                    debugPrint('=====mmc result:$result');
                    /** 数据类型转换 */
                    if(_client==null)return;
                    /** 数据类型转换 */
                    result.then((msg){//==============第一步，这里要把result转成Message 
                      var ret = msg as Message;
                      debugPrint('=====mmc= result is Message');
//                      var ret = result as Message;//==============注意Future<T> 转成 T
//                      var response = await _client.send(ret.msg);//=====await 错误，这里不能异步
                      _client.send(ret.msg).then((response) { //==============因为onPressed函数不是async，所以不能直接使用await.这里改成then的方式来完成异步。
                          debugPrint('=====mmc= 服务端返回值$response');
                          if(response!=null){
                            /** 这里就是获得state,然后调用addMessage方法 */
                            /** 这里 future<T> 怎么转成 T */
                            debugPrint('=====mmc= response：${response as Message}');//==============Message{msg:啦啦啦,timestamp:1583996239918}
                            messageListKey.currentState.addMessage(response as Message);//==============将得到的数据添加到list中去
                          }else{
                            debugPrint('=====mmc= failed to send $response');
                          }
                          });

                    });
                   },
                 tooltip: 'Add message',
                 child: Icon(Icons.add),
               ),
           );
    }
  }
HttpEchoServer _server;
HttpEchoClient _client;
  class MessageList extends StatefulWidget{
    MessageList({Key key}):super(key:key);//==============构造函数？
    State<StatefulWidget> createState()=>new _MessageListState();
  }

  class _MessageListState extends State<MessageList>{
    final List<Message> messages=[];
   
    @override
  void initState() {
    super.initState();
    const port = 6000;
    _server = HttpEchoServer(port);
    /** initState不是async函数，因此不能用await _server.start。 但是用futher.then(...)跟 await是等价的 */
    _server.start().then((_) => {
      /** 等服务器启动 才能创建客户端 */
       _client = HttpEchoClient(port)
    });
  }

    @override
    Widget build(BuildContext context) {
          return ListView.builder(//==============list中的item
            itemCount: messages.length,
              itemBuilder: (context,index){
                final msg = messages[index];
                final subtitle = DateTime.fromMicrosecondsSinceEpoch(msg.timestamp).toLocal().toIso8601String();
                return ListTile(
                  title: Text(msg.msg),
                  subtitle: Text(subtitle),
                );
              }
          );
    }
    void addMessage(Message msg){
      setState(() {//==============新数据来了，就刷新UI页面
         messages.add(msg);
      });
    }
  }