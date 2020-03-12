/**
 * Created by wangjiao on 2020/3/10.
 * description: 数据模型
 */

class Message{
  final String msg;
  final int timestamp;

  Message(this.msg,this.timestamp);
  Message.create(String msg):msg = msg,timestamp = DateTime.now().millisecondsSinceEpoch;

  Map<String,dynamic> toJson()=>{
    'msg':'$msg',
    'timestamp':timestamp
  };

  Message.fromJson(Map<String,dynamic> json):msg=json['msg'],timestamp=json['timestamp'];

  @override
  String toString() {
    return 'Message{msg:$msg,timestamp:$timestamp}';
  }

}