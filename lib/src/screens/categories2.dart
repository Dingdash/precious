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
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
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
                      shrinkWrap: true,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: snapshot.data.map((product) {
                      return Material(
                        color: Colors.white,
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
                          child: Card(color: Colors.white,child:Stack(children: <Widget>[SizedBox(
                            height: itemHeight-30,
                            child: SizedBox.expand(
                                child: FadeInImage.assetNetwork(placeholder:  'assets/images/noimage.png', image:product.imgurl,fit: BoxFit.fill,)
                            ),
                          ),Center(child:Text(product.name)),],) ),
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
        name: json['name'],id:json['category_id'].toString(),imgurl: json['picture']
    );
  }

}


