import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/9.
 * description:
 */
 void main()=>runApp(new MyApp());
 class MyApp extends StatelessWidget{
   @override
   Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'chloe',
         home: new MyHomePage()
       );
   }
 }

 class MyHomePage extends StatefulWidget{
   State<StatefulWidget> createState()=>new _MyHomePageState();
 }
 class _MyHomePageState extends State<MyHomePage>{
   List<int> items = List.generate(20, (index) => index);//产生数据
   ScrollController _scrollController = new ScrollController();
   bool isPerformingRequest = false;//是否正在请求

   Future<List<int>> fakeRequest(int from,int to) async{
     return Future.delayed(Duration(seconds:2),(){
       return List.generate(to-from,(i)=>i+from);
      });
   }

   @override
  void initState() {
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _getMoreData();
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  _getMoreData() async{
      if(!isPerformingRequest){
        setState(()=>isPerformingRequest=true);
        List<int> newEntries = await fakeRequest(items.length, items.length+10); //异步加载数据
//        newEntries.clear(); //这样可以测试 空数据的时候，动画。
        if(newEntries.isEmpty){
          double edge =70;
          double offsetFromBottom = _scrollController.position.maxScrollExtent-_scrollController.position.pixels;
          if(offsetFromBottom<edge){
             _scrollController.animateTo(
                 _scrollController.offset-(edge-offsetFromBottom),
                 duration: new Duration(milliseconds: 500),
                 curve: Curves.easeOut);
          }
        }
        setState((){
           items.addAll(newEntries);
           isPerformingRequest = false;
        });
      }
 }

   @override
   Widget build(BuildContext context) {
        return new Scaffold(
              appBar: AppBar(title: Text('Infinite listview')),
              body:ListView.builder(
                  itemCount: items.length+1, //==============这里的itemcount 要加上加载组件。
                  itemBuilder: (context,index){
                    if(index==items.length){
                      return _buildProgressIndicator();
                    }else{
                      return ListTile(title: new Text('Number $index'),);
                    }
                  },
                  controller: _scrollController,
              )
          );
   }

   //==============下拉加载更多的加载框
   Widget _buildProgressIndicator(){
     return new Padding(
       padding: const EdgeInsets.all(8),
       child:new Center(
         child: new Opacity(
           opacity: isPerformingRequest?1.0:0.0,
           child: new CircularProgressIndicator(),
         ),
       )
     );
   }
 }