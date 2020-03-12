import 'package:flutter/material.dart';
void main()=>runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new MaterialApp(
        title: '第三关',
        home: new Scaffold(
          appBar: new AppBar(title:new Text('hello chole')),
          body: new Center(
//              child:new Text('哈哈')
//          child: new TestWidget(),//==============文本测试成功
//          child: new ImageWidget(),//==============图片测试成功
//          child: new MyButtonWidget(),//==============按钮测试成功
//            child: new MessageForm(),//==============输入框测试成功
//          child: new MyLayoutWidget(),//==============布局测试成功
//          child: new MyRowWidget(),//==============水平布局测试成功
//          child: new MyColWidget(),//==============垂直布局测试成功
//          child: new MyExpandWidget(),//==============垂直布局测试成功
//          child: new MyStackWidget(),//==============层叠布局测试成功

          child: new ImageWidget(),
          ),
        ),
      );
  }
}

/** 文本 */
class TestWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text('这里放文本内容',
      style: TextStyle(//==============文本样式
        color: Colors.blue,
        fontSize: 16.0,
        fontWeight: FontWeight.bold
      ),
    );
  }

}

/**
* 图片 (网络，文件，资源，内存)
 * Image.asset(name)
 * Image.file(file);
 * Image.memory(bytes);
 * Image.network(src)
*
*/
class ImageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
//    return Image.network("https://www.baidu.com/img/superlogo_c4d7df0a003d3db9b65e9ef0fe6da1ec.png?where=super",
//      width: 200,
//      height:200,
//    );
  return Image.asset('image/star.png',
          width: 200,
          height: 200,

  );
  }
}

/** 按钮 (flatButton与RaisedButton 类似)*/
class MyButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var flatBtn= FlatButton(
      onPressed: ()=>print('Flatbutton pressed'),
//      child: Text('BUTTON'),
      child: new ImageWidget(),
    );
    var raisedButton = RaisedButton(
      onPressed: ()=>print('RaisedButton pressed'),
    /** child接收一个widget,可以是任意的  */
//      child: Text('BUTTON'),
    child: new ImageWidget(),
    );
//    return raisedButton;
  return flatBtn;

  }

}

/** 文本输入框 */
/**
* flutter中的文本输入框 叫做 TextField
* 为了获得用户输入的文本，需要设置一个controller，从这个controller中拿到文本框的内容
*/
class MessageForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MessageFormState();
  }
}
class _MessageFormState extends State<MessageForm>{
  var editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        /** expanded 代表沾满一行里 除了RaisedButton外的所有空间 */
        Expanded(child: TextField(controller: editController,),),
        RaisedButton(
          child: Text('click'),
//          onPressed: ()=>print('text inputted: ${editController.text}'),
          /** 显示弹框 */
          onPressed: (){
            showDialog(context: context,builder: (_){
              return AlertDialog(
                content: Text(editController.text),
                actions: <Widget>[
                  //点击按钮，关闭弹窗
                  FlatButton(child: Text('ok'),onPressed: ()=>Navigator.pop(context),)
                ],
              );
            });
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    editController.dispose();
  }

}

/** 最简单的布局，container  padding Center */
class MyLayoutWidget extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
     return Container(
//       child: Text('text',style:TextStyle(color: Colors.white) ,),
     child: Center(child: Text('text',style:TextStyle(color: Colors.white) ,),),
       padding: EdgeInsets.all(8.0),
       margin: EdgeInsets.all(4.0),
       width: 80,
       decoration: BoxDecoration(
         color: Colors.blue,
         borderRadius: BorderRadius.circular(5),
       ),
     );
  }
}

/** 水平，竖直布局和expand */
class MyRowWidget extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('text1'),
        Text('text2'),
        Text('text3'),
        Text('text4'),
        Text('text5'),
      ],
    );
  }
}

class MyColWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Column(
       children: <Widget>[
         Text('text1'),
         Text('text2'),
         Text('text3'),
         Text('text4'),
         Text('text5'),
         Text('text6'),
       ],
     );
  }
}

/** expand 可以设置fiex参数，划分比例占用空间。类似android 的weight 权重 */
class MyExpandWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Row(
       children: <Widget>[
         Expanded(
           flex:2, //==============占比全屏宽度的2/3
           child: RaisedButton(child: Text('btn1'),onPressed: null,),
         ),
         Expanded(
           flex: 1,
           child: RaisedButton(child: Text('btn2'),onPressed: null),
         )
       ],
     );
  }
}

/** Stack布局 （一个控件跌在另一个控件上）*/
class MyStackWidget extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return Stack(
      /** aligment取值范围[-1,1]。stack中心为（0,0）下面0.5是让文本对齐到1/4处 */
      alignment: const Alignment(-0.5, -0.5),
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
        Text('foobar'),
      ],
    );
  }
}



