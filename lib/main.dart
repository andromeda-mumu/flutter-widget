import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/5.
 * description: 第三关，小实战
 */

void main()=>runApp(new MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: '第一个实战',
        home: Scaffold(
          appBar: new AppBar(title:new Text('appbar')),
//          body: Image.asset('images/star.png',
//            width:200,
//            height:200,
//            fit: BoxFit.cover,//类似于fitxy吧，图片铺满组件的大小
//          ),
//        body:new _TitleSection("我要认真", '我要努力', 100)//==============没有圈定范围，导致icon与数字都在屏幕中间。与文字没在一行
//        body: new Container(
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              /** 用类创建一个个的widget */
//              _MidWidget(Icons.call, 'CALL'),
//              _MidWidget(Icons.near_me, 'ROUTE'),
//              _MidWidget(Icons.share, 'SHATE'),
//            /** 用方法创建 一个个的widget 也可以 */
////            _buildButton(context,Icons.call, 'CALL'),
////            _buildButton(context,Icons.near_me, 'ROUTE'),
////            _buildButton(context,Icons.share, 'SHATE'),
//            ],
//          ),
//        ),
        body: _TextSection(),
        )
      );
  }


  /** 方法创建widget  类似android的自定义view */
 Widget _buildButton(BuildContext context,IconData icon,String text){
   final color = Theme.of(context).primaryColor;
   return Column(
     mainAxisSize: MainAxisSize.min,
     mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       Icon(icon,color:color),
       Container(
         margin: const EdgeInsets.only(top:8),
         child: Text(
             text,
             style:TextStyle(
               fontSize: 12,
               fontWeight: FontWeight.w400,
               color:color,
             )
         ),
       )
     ],
   );
 }
}

class _TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final int startCount;

  _TitleSection(this.title, this.subtitle, this.startCount);

  @override
  Widget build(BuildContext context) {
    /** 为了给整个布局加padding,所有套个container */
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          /** 为了让title沾满屏幕宽度的剩余空间，所有用Expanded包着 */
          Expanded(
            /** Expanded只能包含一个子元素。因此要用column来做 */
            child: Column(
              /** 让文本水平方向对齐start */
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(subtitle,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text(startCount.toString())
        ],
      ),
    );
  }
}
class _MidWidget extends StatelessWidget{
  final IconData icon;
  final String text;
  _MidWidget(this.icon,this.text);
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
      return Column(
        /** main axis与cross axis相对应，竖直方向对齐 。*/
        /** 放置完子控件后，屏幕还有剩余空间，min表示尽量少占用 .类似android的wrap_content*/
        mainAxisSize: MainAxisSize.min,//max的话，那就是会在整个屏幕的中间。而min则整体都在屏幕的上面
        /** 居中 */
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon,color:color),
          Container(
            margin: const EdgeInsets.only(top:8),
            child: Text(
              text,
              style:TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:color,
              )
            ),
          )
        ],
      );
  }
}
class _TextSection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Container(
       padding: const EdgeInsets.all(32),
       child: Text(
         '''
         Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.

         ''',
         softWrap: true,
       ),
     );
  }
}