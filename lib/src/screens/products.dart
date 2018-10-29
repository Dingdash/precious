import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
class Products extends StatelessWidget{
  int categories;
  Products({this.categories});

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('tes')),

          ),
          body:Text('tes') ,
        )

    );
  }
  Future<List<Data>> _getDatas(int offset, int limit)async{
    String response = await _getJson(offset,limit);
    var datas = List<Data>();
    List<Map> list = json.decode(response);
    list.forEach((Map map)=> datas.add(new Data.fromMap(map)));
    return datas;
  }
  Future <String> _getJson(int offset,int limit)async
  {

  }
}

class Data{
  String id;
  String name;
  Data.loading(){
    name = "Loading ... ";

  }
  Data.fromMap(Map map){
    id = map['id'];
    name = map['name'];

  }
}