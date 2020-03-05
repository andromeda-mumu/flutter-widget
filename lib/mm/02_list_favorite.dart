import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
/**
 * Created by wangjiao on 2020/3/3.
 * description: 第二关 列表，收藏等
 */

void main()=> runApp(new MyApp());

/**
*
*/
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    
    return  new MaterialApp(
//      title: 'welcome to Flutter',
//      home: new Scaffold(
//        appBar: new AppBar(title: new Text('welcome to Flutter2'),),
//        body: new Center(
////            child: new Text('hello world'),
////        child: new Text(wordPair.asPascalCase),
//        child: new RandomWords(),//==============这里就是返回一个有状态的组件
//        ),
//      ),

    /** MyApp江油RandomWordsState 来管理，这使得用户更容易在APP顶栏中更换界面 */
      title: 'hello chloe',
      theme: new ThemeData(primaryColor: Colors.lightGreen),//==============改变主题
      home: new RandomWords(),
    );
  }

}

/**
 *   stateless组件不可变，他们的属性是不能改变的，所有的值都是final
 *  stateful组件可以保存状态，它在声明周期内可以改变状态。
 *         实现这个需要两个类：statefulWidget  state
 * statefulWidget本身不可变，但state是可变的，并存在生命周期
 *
 * 创建一个有状态的randomWords，然后，创建它的状态类，RandomWordsState，这个类保存喜欢的单词
 */

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}
class RandomWordsState extends State<RandomWords>{
  /** dart中下划线代表私有变量 */
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();//set优于list,因为set不允许有重复
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
  return new Scaffold(
    appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        /** 有些组件的子组件是单个组件（child). 另一些组件，像action的子组件是一个组件数组（children),用方括号表示[] */
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
    ),

    body: _buildSuggestions(),
  );
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
        /**
        *  这里是每次生成一个单词对 时 ，被调用
         *  对于奇数行，添加一个 divider组件 分隔单词
         *  对于偶数行，添加一个 ListTile 组件保存单词
         *
        *
        */
        itemBuilder: (context ,i ){
          if(i.isOdd) return new Divider();
          /** 这个表达式，能计算出真实的 单词对 量。 因为有分割线。 */
          final index = i~/2;
          //==============如果到达底部
          if(index>=_suggestions.length){
            //==============生成10个单词对
            debugPrint('又增加10条');
              _suggestions.addAll(generateWordPairs().take(10));
          }
          /** 每次生成单词对 时，都会调用这个方法 */
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    /** 用listTile 来显示每个单词对 */
     return new ListTile(
       title: new Text(
         pair.asPascalCase,
         style: _biggerFont,
       ),
       /** 添加心形图标 */
       trailing: new Icon(
         alreadySaved ? Icons.favorite : Icons.favorite_border,
         color: alreadySaved ? Colors.red : null,
       ),
       onTap: (){
         /** 图标被点击，会调用setState这个回调
          *
          *  flutter是响应式框架，调用setState会触发State对象的 build方法，从而UI 更新
          *
          */
         setState(() {
           if(alreadySaved){
             _saved.remove(pair);
           }else{
             _saved.add(pair);
           }
         });
       },
     );
  }

  Widget _pushSaved(){
    /** 添加一条新路径 */
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context){
            final tiles = _saved.map(
                (pair){
                  /** 生成列表行 */
                  return new ListTile(title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),);
                },
            );
            /** 在每行之间 添加水平间距 */
            final divided = ListTile.divideTiles(tiles: tiles,context: context).toList();
            
            /** builder返回一个Scaffold组件，这组件包含appbar 和 列表 */
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('save suggestions'),
              ),
              body: new ListView(children:divided),
            );
            
          }
      )
    );
  }

}
