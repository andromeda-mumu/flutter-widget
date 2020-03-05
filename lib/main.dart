import 'package:flutter/material.dart';
/**
 * Created by wangjiao on 2020/3/5.
 * description: 第三关，第二个小实战
 */
 void main()=>runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final buildings =[
      Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
      Building(BuildingType.restaurnt,  'The Castro Theater', '429 Castro St'),
      Building(BuildingType.theater,'Alamo Drafthouse Cinema', '2550 Mission St'),
      Building(BuildingType.theater, 'Roxie Theater', '3117 16th St'),
      Building(BuildingType.restaurnt, 'United Artists Stonestown Twin', '501 Buckingham Way'),
      Building(BuildingType.restaurnt, 'AMC Metreon 16', '135 4th St #3000'),
      Building(BuildingType.theater, 'K\'s Kitchen', '1923 Ocean Ave'),
      Building(BuildingType.restaurnt, 'Chaiya Thai Restaurant', '72 Claremont Blvd'),
      Building(BuildingType.theater, 'La Ciccia', '291 30th St'),

      Building(BuildingType.theater, 'CineArts at the Empire', '85 W Portal Ave'),
      Building(BuildingType.restaurnt,  'The Castro Theater', '429 Castro St'),
      Building(BuildingType.theater,'Alamo Drafthouse Cinema', '2550 Mission St'),
      Building(BuildingType.theater, 'Roxie Theater', '3117 16th St'),
      Building(BuildingType.restaurnt, 'United Artists Stonestown Twin', '501 Buckingham Way'),
      Building(BuildingType.restaurnt, 'AMC Metreon 16', '135 4th St #3000'),
      Building(BuildingType.theater, 'K\'s Kitchen', '1923 Ocean Ave'),
      Building(BuildingType.restaurnt, 'Chaiya Thai Restaurant', '72 Claremont Blvd'),
      Building(BuildingType.theater, 'La Ciccia', '291 30th St'),


    ];



     return MaterialApp(
       title: 'hhh',
       home:Scaffold(
         appBar: new AppBar(title: Text('哈哈哈'),),
         body: new BuildingListView(buildings,(index)=>debugPrint('item $index clicked')),
       )
     );
  }
}

/** 创建数据模型 */
enum BuildingType{theater,restaurnt}

class Building{
  final BuildingType type;
  final String title;
  final String address;
  Building(this.type,this.title,this.address);
}

/** 实现每个item的UI */
class ItemView extends StatelessWidget{
  final int position;
  final Building building;
  final OnItemClickListener listener;
  ItemView(this.position,this.building,this.listener);
  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      building.type == BuildingType.restaurnt?Icons.restaurant:Icons.theaters,
      color: Colors.blue[500],
    );

    final widget = Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16),
          child: icon,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                building.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(building.address)
            ],
          ),
        )
      ],
    );
    return InkWell(
      onTap: ()=>listener(position),
      child: widget,
    );
  }

}

/** listview，由于渲染机制不同，因此不需要adapter来管理listview */
class BuildingListView extends StatelessWidget{
  final List<Building> buildings;
  final OnItemClickListener listener;
  BuildingListView(this.buildings,this.listener);
  @override
  Widget build(BuildContext context) {
     return ListView.builder(
       itemCount:buildings.length,
       itemBuilder:(context,index){
         return new ItemView(index,buildings[index],listener);
       }
     );
  }
}

/** 回调接口 */
typedef OnItemClickListener = void Function(int position);