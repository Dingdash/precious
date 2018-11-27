import 'package:flutter/material.dart';

import '../utils/config.dart' as c;
import 'package:http/http.dart'as http;
import 'dart:async';
import 'dart:convert';
import '../widgets/drawer.dart';

class Categories extends StatelessWidget {

  Widget build(BuildContext context) {

    return Scaffold(
        drawer: myDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Categories'),
        ),
        body: SafeArea(
          child: CategoriesTile(context),
        ),

    );
  }

  Widget CategoriesTile(BuildContext context) {
    return FutureBuilder<List<Category>>(
            future: getCategories(),
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
                break;
                case ConnectionState.none : FlatButton(child: Text("click here to retry"), onPressed: getCategories);
                break;
                default:
                  if(snapshot.hasError)
                    return Text('Error:${snapshot.error}');
                  else
                    return GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data.map((product) {
                      return Material(
                        color: Colors.red,
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context).pushReplacementNamed('/home');
                            Navigator.pushNamed(
                                context,
                                '/categories/' +
                                    product.name +
                                    '/' +
                                    product.id.toString());
                          },
                          child: Center(child: Text(product.name)),
                        ),
                      );
                    }).toList(),
                  );
              }
            }
        );
  }
  Future<List<Category>> getCategories() async {
    //logic for fetching remote data
    var response = await http
        .get(c.base_url+'/categories/all');
    var parsed =  json.decode(response.body).cast<Map<String,dynamic>> () ;
    parsed.forEach((cat){
      Category  cc = new Category(name: cat['name'],id:cat['category_id'].toString(),imgurl: 'tes');
    });
    return parsed.map<Category>((json)=> Category.fromJson(json)).toList();
  }
}



class Category{
  String name;
  String id;
  String imgurl;
  Category({this.name,this.id,this.imgurl});
  factory Category.fromJson(Map<String, dynamic> json)
  {
    return Category(
        name: json['name'],id:json['category_id'].toString(),imgurl: 'tes'
    );
  }

}


