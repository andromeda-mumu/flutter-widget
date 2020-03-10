/**
 * Created by wangjiao on 2020/3/10.
 * description: 数据模型
 */

class Message{
  final String msg;
  final int timestamp;

  Message(this.msg,this.timestamp);

  @override
  String toString() {
    return 'Message{msg:$msg,timestamp:$timestamp}';
  }
}